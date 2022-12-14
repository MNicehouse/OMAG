class UsersController < ApplicationController

  def show
    @assessment = Assessment.new
    @user = User.find(params[:id])
    @role = role(@user)
    @redir = params[:redir_param].nil? ? 0 : params[:redir_param].to_i
    # user
    @responses_current = @user.responses.where(completed: false).sort_by(&:created_at).reverse
    @responses_completed = @user.responses.where(completed: true).sort_by(&:created_at).reverse
    # empties?
    @responses_current_exist = @responses_current.count > 0 ? true : false
    @responses_completed_exist = @responses_completed.count > 0 ? true : false
    # user
    @admin_responses_current = Response.where(completed: false).sort_by(&:created_at).reverse
    @admin_responses_completed = Response.where(completed: true).sort_by(&:created_at).reverse
    # empties?
    @admin_responses_current_exist = @admin_responses_current.count > 0 ? true : false
    @admin_response_completed_exist = @admin_responses_completed.count > 0 ? true : false
  end

  def pic_response_picker()
    return ["assessment1.jpg", "assessment2.jpg", "assessment3.jpg", "assessment4.jpg", "assessment5.jpg", "assessment6.jpg"].sample
  end
  helper_method :pic_response_picker

  private

  def role(puser)
    return puser.admin ? "Admin" : "User"
  end

end
