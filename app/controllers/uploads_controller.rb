class UploadsController < ApplicationController
	layout 'panel'
	before_filter :require_user
	before_filter :set_title
	before_filter :set_upload, only: [:edit, :update, :destroy]
	skip_before_filter :verify_authenticity_token, :only => [:destroy]

	def index
		@uploads = Upload.all
	end

	def new
		@upload = Upload.new
	end

	def edit
	end

	def create
		@upload = Upload.new(upload_params)

		respond_to do |format|
			if @upload.save
				format.html { redirect_to users_url, notice: "Upload criado com sucesso!", alert: "success" }
			else
				format.html { render :new }
			end
		end
	end

	def update
		respond_to do |format|
			if @upload.update(user_params)
				format.html { redirect_to users_url, notice: "Upload alterado com sucesso!", alert: "success" }
			else
				format.html { render :edit }
			end
		end
	end

	def destroy
		@upload.destroy

		respond_to do |format|
			format.html { redirect_to users_url, notice: "Upload deletado com sucesso!", alert: "success" }
		end
	end

	private
		def set_title
			@title = "Uploads"
		end

		def set_upload
			@upload = Upload.find(params[:id])
		end

		def upload_params
			params.require(:upload).permit(:image)
		end
end