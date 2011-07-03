class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :track_time

  private

  def track_time
    @request_started_time = Time.now
  end
end
