class AnswersController < ApplicationController
    before_action :set_response, only: [:new, :create]

    def new
        # generals
        @answer = Answer.new
        # @response = Response.find(params[:response_id])
        @user = @response.user
        @role = role(@user)
        @redir = params[:redir_param].nil? ? 0 : params[:redir_param].to_i
        #questions
        @questions = @response.assessment.questions_assessments.joins(:question)
        @questions_count = @questions.count
        quest_arr = []
        @questions.map { |u| quest_arr << u.id }
        quest_arr.sort
        @myquestionid = params[:myassessquestionid].nil? ? -1 : params[:myassessquestionid].to_i
        @dir_param = params[:dir_param].nil? ? 'forth' : params[:dir_param]
        # forth
        if @dir_param == "forth"
          @myquestionindex_new = quest_arr.find_index(@myquestionid).nil? ? 0 : quest_arr.find_index(@myquestionid) + 1
          if (@myquestionindex_new) >= quest_arr.count
            render "users/show"
          else
            @myquestionid_new = quest_arr[@myquestionindex_new]
          end
        end
        # back
        if @dir_param == "back"
          @myquestionindex_new = quest_arr.find_index(@myquestionid).nil? ? 0 : quest_arr.find_index(@myquestionid) - 1
          if (@myquestionindex_new) < 0
            @myquestionindex_new = 0
            @myquestionid_new = @myquestionid
          else
            @myquestionid_new = quest_arr[@myquestionindex_new]
          end
        end
      end

      def create
        # check if answer not exists already to the given foreign keys
        if params.has_key?(:answer)
            suspect_answers_exact = Answer.where(option_id: params[:answer][:option_id], response_id: @response.id)
        else
            suspect_answers_exact = nil
        end
        suspect_answers_set = QuestionsAssessment.find(params[:assessquestion_id]).question.options.joins(:answers).merge(Answer.where(response_id: @response.id))
        if suspect_answers_exact.nil?  || suspect_answers_exact.count > 0
          # dont have to do nothing
        elsif suspect_answers_set.nil?
            @answer = Answer.new
            @answer.option = Option.find(params[:answer][:option_id])
            @answer.response = @response
            @answer.save
        else
            suspect_answers_set.each do |suspect_option|
                @delanswer = Answer.find_by(option_id: suspect_option.id, response_id: @response.id)
                @delanswer.delete
            end
            @answer = Answer.new
            @answer.option = Option.find(params[:answer][:option_id])
            @answer.response = @response
            @answer.save
        end
        if params[:commit] == 'forth'
            redirect_to new_response_answer_path( @response, myassessquestionid: params[:assessquestion_id], dir_param: "forth", redir_param: @redir_param, accord_param: @accord_param )
        elsif  params[:commit] == 'back'
            redirect_to new_response_answer_path( @response, myassessquestionid: params[:assessquestion_id], dir_param: "back", redir_param: @redir_param, accord_param: @accord_param )
        end
      end

      private
    
      def role(puser)
         return puser.admin ? "Admin" : "User"
      end

      def answer_params
        params.require(:answer).permit(:option_id)
      end

      def set_response
        @response = Response.find(params[:response_id])
        @redir_param = params[:redir_param]
        @accord_param = params[:accord_param]
      end
end
