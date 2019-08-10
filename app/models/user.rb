# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  confirmation_token     :string(255)
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string(255)
#  failed_attempts        :integer          default(0), not null
#  unlock_token           :string(255)
#  locked_at              :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  name                   :string(255)
#  avatar_file_name       :string(255)
#  avatar_content_type    :string(255)
#  avatar_file_size       :integer
#  avatar_updated_at      :datetime
#

class User < ApplicationRecord
  validates :name,
            presence: true,
            uniqueness: { case_sensitive: false }
  validates_format_of :name, with: /^[a-zA-Z0-9_\.]*$/, multiline: true
  validate :validate_name

  attr_accessor :login

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :lockable, :timeoutable

  has_attached_file :avatar,
                    styles: { medium: "300x300>", thumb: "100x100>" },
                    default_url: "/missing.png"

  validates_attachment_content_type :avatar,
                                    content_type: %r{\Aimage\/.*\z}

  def send_devise_notification(notification, *args)
    devise_mailer.send(notification, self, *args).deliver_later
  end

  def login
    @login || self.name || self.email
  end

  def validate_name
    errors.add(:name, :invalid) if User.where(email: name).exists?
  end

  def self.find_for_database_authentication(warden_confitions)
    conditions = warden_confitions.dup
    conditions[:email].downcase! if conditions[:email]
    login = conditions.delete(:login)

    where(conditions.to_hash).where(
      ["lower(name) = :value OR lower(email) = :value",
        { value: login.downcase }]
    ).first
  end

end
