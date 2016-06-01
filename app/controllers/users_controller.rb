class UsersController < ApplicationController
	layout 'panel'
	before_filter :require_user
	before_filter :set_title
	before_filter :set_user, only: [:edit, :update, :destroy]
	skip_before_filter :verify_authenticity_token, :only => [:destroy]

	def index
		@users = User.order('id DESC').all
	end

	def new
		@user = User.new
	end

	def edit
	end

	def create
		@user = User.new(user_params)

		respond_to do |format|
			if @user.save
				format.html { redirect_to users_url, notice: "Usuário criado com sucesso!", alert: "success" }
			else
				format.html { render :new }
			end
		end
	end

	def update
		respond_to do |format|
			if @user.update(user_params)
				format.html { redirect_to users_url, notice: "Usuário alterado com sucesso!", alert: "success" }
			else
				format.html { render :edit }
			end
		end
	end

	def destroy
		@user.destroy
		respond_to do |format|
			format.html { redirect_to users_url, notice: "Usuário deletado com sucesso!", alert: "success" }
		end
	end

	private
		def set_title
			@title = "Usuários"
		end

		def set_user
			@user = User.find(params[:id])
		end

		def user_params
			params.require(:user).permit(:name, :email, :password, :password_confirmation)
		end
end
