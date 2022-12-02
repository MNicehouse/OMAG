class AssessmentsController < ApplicationController
  before_action :authenticate_admin!, only: [ :new, :create ]

  def new
    @assessment = Assessment.new
    @questions = Question.all
  end

  def show
    @assessment = Assessment.find(params[:id])
    @question = Question.new
  end

  def create
    @assessment = Assessment.new(assessment_params)
    if @assessment.save!
      redirect_to assessment_path(@assessment)
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def assessment_params
    params.require(:assessment).permit(:name, :description)
  end
end
