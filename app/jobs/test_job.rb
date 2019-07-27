class TestJob < ApplicationJob
  queue_as :default

  def perform(*args)
    Rails.logger.debug "#{self.class.name}:job done(#{args.inspect})"
  end
end
