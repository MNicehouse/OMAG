class ResponsesController < ApplicationController
    def index
      @responses = Response.where('user_id = ? ', current_user).order(assessment_id: :desc)
    end
end
