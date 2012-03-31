class PagesController < ApplicationController
	
	def show
		path = File.expand_path(File.join(File.dirname(__FILE__), "../../public/pages/#{params[:id]}.textile"))
		pageFile = File.new(path)
		@page = RedCloth.new(pageFile.read(nil)).to_html.html_safe
		render :template=> 'pages/show'
	end
	
end