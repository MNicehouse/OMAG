class ResponsesController < ApplicationController

  def index
    @responses = Response.where('user_id gi= ? ', current_user).order(assessment_id: :desc)
  end

  def new
    @responses = Response.new
    # new response over grids
    @redir = params[:redir_param].nil? ? 0 : params[:redir_param].to_i
    @pagy_ready, @assessments_ready = pagy(Assessment.where(state: true).nil? ? [] : Assessment.where(state: true).reorder(:created_at), items: 10)
    @role = role(current_user)
    @assessnotchosen = true
    @pagy_clients, @clients = pagy(User.where(admin: false).nil? ? [] : User.where(admin: false).reorder(:created_at), items: 10)
  end

  def create
    if params[:commit] == 'create new assessment'
      @assessment = Assessment.find(params[:assessment_id])
      @user = User.find(params[:user_id])
      @response = Response.new(assessment: @assessment, user: @user)
      @response.save
      redirect_to user_path(current_user, redir_param: 61, accord_param: "flush-headingSix")
    else
      @assessment = Assessment.find(params[:assessment_id])
      @response = Response.new(assessment: @assessment, user: User.find(params[:response][:user].to_i))
      if @response.has_one_question
        @response.save!
        @assessment.state = true
        @assessment.save
        redirect_to user_path(current_user, redir_param: 61, accord_param: "flush-headingSix")
      end
    end
  end

  def edit
    @response = Response.find(params[:id])
  end

  def update
    @response = Response.find(params[:id])
    @user = User.find(params[:id])
    @response.update(user: @user)
    redirect_to user_path(current_user, redir_param: 61, accord_param: "flush-headingSix")
  end

  private

  def response_params
    params.require(:response).permit(:user_id, :assessment_id, :score, :completed)
  end

  def role(puser)
    return puser.admin ? "Admin" : "User"
  end
end
