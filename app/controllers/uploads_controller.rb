class UploadsController < ApplicationController
	layout 'panel'
	before_filter :require_user
	before_filter :set_title
	before_filter :set_upload, only: [:edit, :update, :destroy]
	skip_before_filter :verify_authenticity_token, :only => [:create, :destroy]

	def create
		success = false
		error = nil

		if upload_params[:images]
			upload_params[:images].each do |image|
				@upload = Upload.create(page_id: upload_params[:page_id], image: image)

				if @upload.save
					success = true
				else
					success = false
					error = @upload.errors.full_messages.to_s
				end
			end
		end
		
		respond_to do |format|
			if success
				format.json { render :json => { success: "Upload realizado com sucesso!" }, status: :created }
			else
				format.json { render :json => { error: "Erro: " + error }, status: :unprocessable_entity }
			end
		end
	end

	def destroy
		@upload.image.destroy

		respond_to do |format|
			if @upload.destroy
				format.json { render :json => { success: "Upload deletado com sucesso!", status: :deleted } }
			else
				format.json { render :json => { error: "Erro: " + @upload.errors.full_messages.to_s }, status: :unprocessable_entity }
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
			params.require(:upload).permit(:page_id, {images: []})
		end
end