class ResponsesController < ApplicationController

  def index
    @responses = Response.where('user_id gi= ? ', current_user).order(assessment_id: :desc)
  end

  def create
    @assessment = Assessment.find(params[:assessment])
    @response = Response.new(assessment: @assessment)
    @response.save!
    redirect_to edit_response_path(@response), turbolinks: true
  end

  def edit
    @response = Response.find(params[:id])
    respond_to :js
  end

  def update
    @response = Response.find(params[:id])
    @user = User.find(params[:id])
    @response.update(user: @user)
    # redirect needs to be edited
    # redirect_to response_path(@response)
  end

  private

  def response_params
    params.require(:response).permit(:user_id, :assessment_id, :score, :completed)
  end
end
