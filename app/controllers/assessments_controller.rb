class AssessmentsController < ApplicationController
  before_action :authenticate_admin!, only: [ :new, :create ]

  def new
    @assessment = Assessment.new
    @questions = Question.all
  end

  def show
    @assessment = Assessment.find(params[:id])
    @user = current_user
    @users = User.all
    @responses = Response.all
    @response = Response.new
    if params[:question_id]
      @question = Question.find(params[:question_id])
    else
      @question = Question.new
    end
  end

  def create
    @assessment = Assessment.new(assessment_params)
    if @assessment.save!
      redirect_to assessment_path(@assessment)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def index
    # @assessments = Assessment.all
    @pagy, @assessments = pagy(Assessment.all, items: 10)
    @role = role(current_user)
    @assessnotchosen = true
  end

  private

  def assessment_params
    params.require(:assessment).permit(:name, :description)
  end

  def role(puser)
    return puser.admin ? "Admin" : "User"
  end
end
