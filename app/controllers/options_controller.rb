class OptionsController < ApplicationController
  before_action :set_question, only: %i[new create]

  def new
    @option = Option.new
  end

  def create
    @option = Option.new(option_params)
    @option.question = @question
    @option.save
    redirect_to new_question_path(@question)
  end

  private

  def set_question
    @question = Question.find(params[:question_id])
  end

  def option_params
    params.require(:option).permit(:option_text, :value)
  end
end
