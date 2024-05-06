class LandingPageController < ApplicationController
  skip_after_action :verify_authorized

  def landing
  end
end
