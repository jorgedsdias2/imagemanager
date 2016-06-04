class UploadsController < ApplicationController
	layout 'panel'
	before_filter :require_user
	before_filter :set_title
	before_filter :set_upload, only: [:edit, :update, :destroy]
	skip_before_filter :verify_authenticity_token, :only => [:create, :destroy]

	def index
		@upload = Upload.new
	end

	def create
		success = false

		if upload_params[:images]
			upload_params[:images].each do |image|
				@upload = Upload.create(image: image)

				if @upload.save
					success = true
				else
					success = false
				end
			end
		end

		respond_to do |format|
			if success
				format.html { redirect_to uploads_url, notice: "Upload realizado com sucesso!", alert: "success" }
				format.json { render json: success, status: :created }
			else
				format.html { render :index, notice: "Upload não realizado com sucesso!", alert: "danger" }
				format.json { render json: success, status: :unprocessable_entity }
			end
		end
	end

	private
		def set_title
			@title = "Upload de Imagens"
		end

		def set_upload
			@upload = Upload.find(params[:id])
		end

		def upload_params
			params.require(:upload).permit(images: [])
		end
end