class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!

  # def after_sign_up_path_for(resource)
  #   agents_path
  # end

  # def after_inactive_sign_up_path_for(resource)
  #   agents_path
  # end

  # After the user signs in, redirect them to the available properties page
  def after_sign_in_path_for(resource)
    # Also set the database variable to the current user
    @user = current_user
    ActiveRecord::Base.connection.execute("SET myapp.current_user_id TO '#{current_user.id}';")
    root_path
  end

  # After the user signs out, redirect them to the home page
  def after_sign_out_path_for(resource)
    ActiveRecord::Base.connection.execute("RESET myapp.current_user_id;")
    root_path
  end
end
