class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  include Pagy::Backend

  def after_sign_in_path_for(resource)
    if @user.nil?
      redirect_to root_path # redirect to /
    elsif @user.admin
      user_path(@user, redir_param: 61, accord_param: "flush-headingSix") # your path
    else
      user_path(@user, redir_param: 21, accord_param: "flush-headingTwo") # your path
    end
  end
end
