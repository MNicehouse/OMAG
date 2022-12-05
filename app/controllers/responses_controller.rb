class ResponsesController < ApplicationController

  def index
    @responses = Response.where('user_id gi= ? ', current_user).order(assessment_id: :desc)
  end

  def create
    @assessment = Assessment.find(params[:assessment_id])
    @response = Response.new(assessment: @assessment, user: User.find(params[:response][:user].to_i))
    @response.save!
    redirect_to user_path(current_user)
  end

  def edit
    @response = Response.find(params[:id])
  end

  def update
    @response = Response.find(params[:id])
    @user = User.find(params[:id])
    @response.update(user: @user)
    redirect_to user_path(current_user)
  end

  private

  def response_params
    params.require(:response).permit(:user_id, :assessment_id, :score, :completed)
  end
end
