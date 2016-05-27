class SessionsController < ApplicationController
	layout 'login'
	before_filter :require_user, only: [:index]
	before_filter :set_title, only: [:new]

	def index
		@title = 'Dashboard'
		flash[:notice] = nil
		render layout: 'panel'
	end

	def new
	end

	def create
		@user = User.find_by_email(params[:session][:email])
		respond_to do |format|
			if @user && @user.authenticate(params[:session][:password])
				session[:user_id] = @user.id
				format.html { redirect_to index_url }
			else
				flash[:notice] = "E-mail ou Senha inválidos"
				format.html { render :new }
			end
		end
	end

	def destroy
		session[:user_id] = nil
		respond_to do |format|
			format.html { redirect_to login_url }
		end
	end

	private
		def set_title
			@title = "Login"
		end
end