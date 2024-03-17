class HomeController < ApplicationController
  # Skip the before_action :authenticate_user! for the home page
  skip_before_action :authenticate_user!

  # GET /
  def index
    # Get the current user if signed in
    @user = current_user if user_signed_in?

    # Render the home page
    render "index"
  end
end
