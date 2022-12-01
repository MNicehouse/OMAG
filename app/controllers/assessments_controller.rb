class AssessmentsController < ApplicationController
  before_action :authenticate_admin!, only: [ :new, :create ]

  def new
    @assessment = Assessment.new
    @questions = Question.all
  end

  def create
    @assessment = Assessment.new(assessment_params)
    @assessment.save!
    redirect_to assessment_path(@assessment)
  end

  private

  def assessment_params
    params.require(:assessment).permit(:title, :description)
  end
end
