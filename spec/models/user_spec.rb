require "rails_helper"

RSpec.describe User, type: :model do
    it "ユーザの作成年月が表示されること" do
        user = User.new(email: "hoge@example.com", created_at: Time.utc(2019, 1, 1, 12, 0, 0))
        expect(user.created_month).to eq "2019年01月"
    end
end