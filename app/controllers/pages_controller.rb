class PagesController < ApplicationController
	layout 'panel'
	before_filter :require_user
	before_filter :set_title
	before_action :set_page, only: [:edit, :update, :destroy]
	skip_before_filter :verify_authenticity_token, :only => [:destroy]

	def index
		@pages = Page.all
	end

	def new
		@page = Page.new
	end

	def edit
		@uploads = @page.uploads.all
		@upload = Upload.new
	end

	def show
	end

	def create
		@page = Page.new(page_params)

		respond_to do |format|
			if @page.save
				format.html { redirect_to pages_url, notice: 'Página criada com sucesso!', alert: 'success' }
			else
				format.html { render :new }
			end
		end
	end

	def update
		respond_to do |format|
			if @page.update(page_params)
				format.html { redirect_to pages_url, notice: 'Página alterada com sucesso!', alert: 'success' }
			else
				format.html { render :new }
			end
		end
	end

	def destroy
		@page.destroy
		respond_to do |format|
			format.html { redirect_to pages_url, notice: 'Página deletada com sucesso!', alert: 'success' }
		end
	end

	private
	def set_title
		@title = "pages"
	end

	def set_page
		@page = Page.find(params['id'])
	end

	def page_params
		params.require(:page).permit(:title, :status, :user_id)
	end
end