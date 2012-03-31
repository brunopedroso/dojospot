require 'spec_helper'

describe 'dojo_sessions/show.html.erb' do
	before :each do 
		@dojo_session = Factory.create(:dojo_session)
		assigns[:dojo_session] = @dojo_session
	  
	  controller.singleton_class.class_eval do
      protected
        def logged_in?
          not User.first.nil?
        end
        def current_user
          User.first
        end
        helper_method :logged_in?
        helper_method :current_user
    end
		
	end

	context 'test some things in the dojo_session partial' do
		
		#TODO: it should be testing if the partial is being rendered, but with a mock. I could'n do that yet :-(

		it 'should show the sessions details' do
			render

			rendered.should have_selector('h1', :content=> @dojo_session.title)
			rendered.should have_selector('p', :content=>@dojo_session.text)
			rendered.should contain(@dojo_session.place)
			rendered.should contain(I18n.l(@dojo_session.date, :format=>:pretty))
			rendered.should contain(@dojo_session.time)

		end

		it 'should present date in brazilian format' do
			render
			the_date = I18n.l @dojo_session[:date], :format=>:pretty
			rendered.should contain(the_date)
		end

		it 'should textilize the dojo session content' do
			@dojo_session.text = 'h3. meu titulo muito feliz'
			render
			rendered.should have_selector('h3', :content=>'meu titulo muito feliz')
		end
		
	end

end