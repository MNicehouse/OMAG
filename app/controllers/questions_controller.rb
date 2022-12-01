class QuestionsController < ApplicationController

  def new
    @question = Question.new
    @question.options.build
  end

  def create
    @question = Question.new(question_params)
    @question.save!
    redirect_to root_path
  end

  private

  def question_params
    params.require(:question)
          .permit(:question_text, :question_type,
                  options_attributes: %i[id option_text value])
  end
end
