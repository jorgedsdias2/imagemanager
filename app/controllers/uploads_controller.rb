class UploadsController < ApplicationController
	layout 'panel'
	before_filter :require_user
	before_filter :set_title
	before_filter :set_upload, only: [:show, :edit, :update, :destroy]
	skip_before_filter :verify_authenticity_token, :only => [:destroy]

	def index
		@uploads = Upload.all
	end

	respond_to do |format|
		format.html # index.html.erb
		format.json { render json: @uploads.map { |upload| upload.to_upload } }
	end

	def show
		respond_to do |format|
			format.html # show.html.erb
			format.json { render json: @upload }
		end
	end

	def new
		@upload = Upload.new

		respond_to do |format|
			format.html # new.html.erb
			format.json { render json: @upload }
		end
	end

	def edit
	end

	def create
		@upload = Upload.new(upload_params)

		respond_to do |format|
			if @upload.save
				format.html {
					render :json => [@upload.to_upload].to_json,
					:content_type => 'text/html',
					:layout => false
				}

				format.json { render json: {files: [@upload.to_upload]}, status: :created, location: @upload }
			else
				format.html { render :new }
				format.json { render json: @upload.errors, status: :unprocessable_entity }
			end
		end
	end

	def update
		respond_to do |format|
			if @upload.update_attributes(upload_params)
				format.html { redirect_to uploads_url, notice: "Upload alterado com sucesso!" }
				format.json { head :no_content }
			else
				format.html { render :edit }
				format.json { render json: @upload.errors, status: :unprocessable_entity }
			end
		end
	end

	def destroy
		@upload.destroy

		respond_to do |format|
			format.html { redirect_to uploads_url }
			format.json { head :no_content }
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
			params.require(:upload).permit(:file_name, :content_type, :file_size, :width, :height)
		end
end