class SessionsController < ApplicationController

  def create
	  user = User.find_by_email(params[:email])
	  if user && user.senha == params[:password]
	    render json: user
	  else
	  	render json:{}, :status => :unauthorized
	  end
	end

end
