class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!

  # Call the set_user_id_at_database method before each request
  before_action :set_user_id_at_database, if: :user_signed_in?

  # Call the unset_user_id_at_database method after each request
  after_action :unset_user_id_at_database, if: :user_signed_in?

  # def after_sign_up_path_for(resource)
  #   agents_path
  # end

  # def after_inactive_sign_up_path_for(resource)
  #   agents_path
  # end

  # After the user signs in, redirect them to the available properties page
  def after_sign_in_path_for(resource)
    # Also set the database variable to the current user
    root_path
  end

  # After the user signs out, redirect them to the home page
  def after_sign_out_path_for(resource)
    root_path
  end

  def set_user_id_at_database
    ActiveRecord::Base.connection.execute("SET myapp.current_user_id TO '#{current_user.id}';")
  end

  def unset_user_id_at_database
    ActiveRecord::Base.connection.execute("RESET myapp.current_user_id;")
  end
end
