class ResponsesController < ApplicationController
    def index
      @responses = Response.where('user_id gi= ? ', current_user).order(assessment_id: :desc)
    end

    def show
      # generals
      @response = Response.find(params[:id])
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
      # forth
      @myquestionindex_new = quest_arr.find_index(@myquestionid).nil? ? 0 : quest_arr.find_index(@myquestionid) + 1
      if (@myquestionindex_new) >= quest_arr.count
        render "users/show", status: :unprocessable_entity
      else
        @myquestionid_new = quest_arr[@myquestionindex_new]
      end
      # back
      @myquestionindex_new_pre = quest_arr.find_index(@myquestionid).nil? ? 0 : quest_arr.find_index(@myquestionid) - 1
      if (@myquestionindex_new_pre) < 0
        @myquestionindex_new_pre = 0
        @myquestionid_new_pre = @myquestionid
      else
        @myquestionid_new_pre = quest_arr[@myquestionindex_new_pre]
      end
      @dir_param = params[:dir_param].nil? ? 'forth' : params[:dir_param]
    end

    private
  
    def role(puser)
       return puser.admin ? "Admin" : "User"
    end

end
