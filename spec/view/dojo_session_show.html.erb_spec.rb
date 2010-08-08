require 'spec_helper'

describe 'dojo sessions show' do
	
	before :each do 
		@dojo_session = Factory.create(:dojo_session)
		assigns[:dojo_session] = @dojo_session
	end

	context 'test some things in the dojo_session partial' do
		
		#TODO: it should be testing if the partial is being rendered, but with a mock. I could'n do that yet :-(

		it 'should show the sessions details' do
			render("dojo_sessions/show")

			response.should have_tag('h1', @dojo_session.title)
			response.should have_tag('p', @dojo_session.text)
			response.should include_text(@dojo_session.place)
			response.should include_text(I18n.l(@dojo_session.date, :format=>"pretty"))
			response.should include_text(@dojo_session.time)

		end

		it 'should present date in brazilian format' do
			render("dojo_sessions/show")
			the_date = I18n.l @dojo_session[:date], :format=>"pretty"
			response.should include_text(the_date)
		end

		it 'should textilize the dojo session content' do
			@dojo_session.text = 'h3. meu titulo muito feliz'
			render("dojo_sessions/show")
			response.should have_tag('h3', 'meu titulo muito feliz')
		end
		
	end

end