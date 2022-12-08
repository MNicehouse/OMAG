class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
  end

  def hrole(puser)
    return puser.admin ? "Admin" : "User"
  end
  helper_method :hrole
end
