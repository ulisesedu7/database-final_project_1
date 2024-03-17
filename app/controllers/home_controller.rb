class HomeController < ApplicationController
  # Skip the before_action :authenticate_user! for the home page
  skip_before_action :authenticate_user!
  skip_before_action :set_user_id_at_database
  skip_after_action :unset_user_id_at_database

  # GET /
  def index
    # Render the home page
    render "index"
  end
end
