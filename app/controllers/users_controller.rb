class UsersController < ApplicationController

    def show
        @user = User.find(params[:id])
        @role = role(@user)
        @redir = params[:redir_param].nil? ? 0 : params[:redir_param].to_i
        # booking
        @responses_current = @user.responses.where(score: nil)
        @responses_historic = @user.responses.where.not(score: nil)
        # empties? 
        @responses_current_exist = @responses_current.count > 0 ? true : false
        @response_historic_exist = @responses_historic.count > 0 ? true : false
  
         end
     
      private
  
      def role(puser)
         return puser.consultant ? "Admin" : "Client"
      end
end
