class QuestionsController < ApplicationController

  def new
    @question = Question.new
    @question.options.build
  end

  def create
    @assessment = Assessment.find(params[:assessment])
    @question = Question.new(question_params)
    @qa = QuestionsAssessment.new
    @qa.assessment = @assessment
    options = [params[:option_1], params[:option_2], params[:option_3]]
    values = [params[:value_1], params[:value_2], params[:value_3]]
    if @question.save!
      @qa.question = @question
      @qa.weight = params[:weight]
      @qa.save
      options.each_with_index do |option, i|
        option = Option.new
        option.option_text = options[i]
        option.value = values[i]
        option.question = @question
        option.save
      end
    end
    # Need to put an alternative statment next week
    redirect_to assessment_path(@assessment)
  end

  def destroy
    @question = Question.find(params[:id])
    @assessment = @question.questions_assessments.first.assessment
    @question.destroy
    redirect_to assessment_path(@assessment)
  end

  private

  def question_params
    params.require(:question).permit(:question_text, :question_type)
  end

  def options_params
    params.require(:option).permit(:option_text, :value)
  end
end
