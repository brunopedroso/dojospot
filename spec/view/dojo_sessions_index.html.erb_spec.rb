require 'spec_helper'

describe 'dojo sessions index' do
	
	# TODO: mudar pra testar a dojo_sesisons/index
	
	context 'proposed sessions display list' do
		
		
		it 'should show no-sessions message without proposed sessions' do 
			assigns[:dojo_sessions] = []
			render('dojo_sessions/index')
			response.should have_tag('p', 'Nenhuma sessão proposta no momento.')
		end

		context 'details' do

			before :each do 
				@dojo_session = Factory.create(:dojo_session, :confirmed_users=>[Factory.create(:user)])
				assigns[:dojo_sessions] = [@dojo_session]
			end

			it 'should show the next proposed session' do
				render('dojo_sessions/index')

				response.should have_tag('h1', @dojo_session.title)
				response.should have_tag('p', @dojo_session.text)
				response.should include_text(@dojo_session.place)
				response.should include_text(I18n.l(@dojo_session.date, :format=>"pretty"))
				response.should include_text(@dojo_session.time)

			end

			it 'should present date in brazilian format' do
				render('dojo_sessions/index')
				the_date = I18n.l @dojo_session[:date], :format=>"pretty"
				response.should include_text(the_date)
			end

			it 'should not show the no-sessions message' do
				render('dojo_sessions/index')
				response.should_not have_tag('p', 'Nenhuma sessão proposta no momento.')
			end
			
			it 'should not show a link to edit if i am NOT logged in' do
				session[:user_id] = nil
				render('dojo_sessions/index')
				response.should_not have_tag('a[href=?]', "/dojo_sessions/#{@dojo_session.id}/edit", 'editar')
			end

			it 'should show a link to edit when i am logged in one of the confirmed users ' do
				user = @dojo_session.confirmed_users[0]

				# tem que ter privilégio
				user.has_propose_priv=true
				user.save

				session[:user_id] = user.id
				
				render('dojo_sessions/index')
				response.should have_tag('a[href=?]', "/dojo_sessions/#{@dojo_session.id}/edit", 'editar')
			end

			it 'should not show a link to edit if i am NOT a confirmed user' do
				session[:user_id] = Factory.create(:user).id
				render('dojo_sessions/index')
				response.should_not have_tag('a[href=?]', "/dojo_sessions/#{@dojo_session.id}/edit", 'editar')
			end

			it 'should not show a link to edit if i do NOT have privileges' do
				user = @dojo_session.confirmed_users[0]
				user.has_propose_priv=false
				session[:user_id] = session[:user_id] = user.id
				render('dojo_sessions/index')
				response.should_not have_tag('a[href=?]', "/dojo_sessions/#{@dojo_session.id}/edit", 'editar')
			end

			
		end


		it 'should show the three proposed sessions' do
			assigns[:dojo_sessions] = [Factory.create(:dojo_session), Factory.create(:dojo_session), Factory.create(:dojo_session)]
			render('dojo_sessions/index')
			dojo_sessions = assigns[:dojo_sessions]
			response.should have_tag('div[id=?]', "dojo_session_#{dojo_sessions[0].id}", :text=>/.*#{dojo_sessions[0].title}*/)
			response.should have_tag('div[id=?]', "dojo_session_#{dojo_sessions[1].id}", :text=>/.*#{dojo_sessions[1].title}*/)
			response.should have_tag('div[id=?]', "dojo_session_#{dojo_sessions[2].id}", :text=>/.*#{dojo_sessions[2].title}*/)
		end
		
	end


	context 'proposition' do
	
		before :each do 
			assigns[:dojo_sessions] = []
		end
	
		it 'should not show link to propose session when not logged in' do
			render('dojo_sessions/index')
			response.should_not have_tag('a[href=?]','/dojo_sessions/new')
		end

		it 'should not show link to propose session if i dont have such privilege' do
			session[:user_id] = Factory.create(:user, :has_propose_priv => false).id
			render('dojo_sessions/index')
			response.should_not have_tag('a[href=?]','/dojo_sessions/new')
		end

		it 'should show link to propose session when logged in' do
			session[:user_id] = Factory.create(:user, :has_propose_priv => true).id
			render('dojo_sessions/index')
			response.should have_tag('a[href=?]','/dojo_sessions/new','Propor uma nova sessão')
		end

	end

	context 'confirmation' do

		before :each do
			@user = Factory.create(:user)
			session[:user_id] = @user.id
		end
		
		context 'link to confirm' do
			it 'should show a link to confirm presence in the session if there is nobody confirmed' do

				@dojo_session = Factory.create(:dojo_session)
				assigns[:dojo_sessions] = [@dojo_session]

				render('dojo_sessions/index')

				response.should have_tag('a[href=?]', "/dojo_sessions/#{@dojo_session.id}/confirm_presence", 'Confirmar minha presença')

			end
			
			it 'should show a link to confirm presence in the session if i am not one of the confirmed users' do

				@dojo_session = Factory.create(:dojo_session, :confirmed_users=>[Factory.create(:user)])
				assigns[:dojo_sessions] = [@dojo_session]

				render('dojo_sessions/index')

				response.should have_tag('a[href=?]', "/dojo_sessions/#{@dojo_session.id}/confirm_presence", 'Confirmar minha presença')

			end

			it 'should not show a link to confirm presence if i am already a confirmed user' do

				@dojo_session = Factory.create(:dojo_session, :confirmed_users=>[@user])
				assigns[:dojo_sessions] = [@dojo_session]

				render('dojo_sessions/index')

				response.should_not have_tag('a', 'Confirmar minha presença')

			end
			
			it 'should show a link to confirm presence even if i am not logged in' do
				
				# a idéia é que caia na página de login, mas isso deve ser testado no controller, não aqui.
				
				session[:user_id] = nil
				@dojo_session = Factory.create(:dojo_session)
				assigns[:dojo_sessions] = [@dojo_session]

				render('dojo_sessions/index')

				response.should have_tag('a', 'Confirmar minha presença')

			end
			
		end
		
		
		context 'confirmed users list' do 
			
			it 'should show nowbody-confirmed-message if there is nobody confirmed' do

				@dojo_session = Factory.create(:dojo_session, :confirmed_users=>[])
				assigns[:dojo_sessions] = [@dojo_session]

				render('dojo_sessions/index')

				response.should_not have_tag('div[id=?]', "dojo_session_#{@dojo_session.id}", :text=>/.*Confirmados até agora.*/)
				response.should have_tag('div[id=?]', "dojo_session_#{@dojo_session.id}", :text=>/.*Ninguém confirmou ainda.*/)

			end

			it 'should not show nobody-confirmed-message if there is someone confirmed' do

				@dojo_session = Factory.create(:dojo_session, :confirmed_users=>[Factory.create(:user)])
				assigns[:dojo_sessions] = [@dojo_session]

				render('dojo_sessions/index')

				response.should have_tag('div[id=?]', "dojo_session_#{@dojo_session.id}", :text=>/.*Confirmados até agora.*/)
				response.should_not have_tag('div[id=?]', "dojo_session_#{@dojo_session.id}", :text=>/.*Ninguém confirmou ainda.*/)

			end

			it 'should show the names of the confirmed users' do
				user1 = Factory.create(:user)
				user2 = Factory.create(:user)
				@dojo_session = Factory.create(:dojo_session, :confirmed_users=>[user1, user2])
				assigns[:dojo_sessions] = [@dojo_session]

				render('dojo_sessions/index')

				response.should have_tag('div[id=?]', "dojo_session_#{@dojo_session.id}", :text=>/.*Confirmados até agora.*/)
				response.should have_tag('div[id=?] ol li', "dojo_session_#{@dojo_session.id}", :text=>/.*#{user1.username}.*/)
				response.should have_tag('div[id=?] ol li', "dojo_session_#{@dojo_session.id}", :text=>/.*#{user2.username}.*/)

			end
			
			it 'should show a link to unconfirm, if the current_user is already confirmed' do
				@dojo_session = Factory.create(:dojo_session, :confirmed_users=>[@user])
				assigns[:dojo_sessions] = [@dojo_session]
				
				render('dojo_sessions/index')
				
				response.should have_tag('div[id=?] a[href=?]', "dojo_session_#{@dojo_session.id}", unconfirm_presence_dojo_session_path(@dojo_session.id),:text=>/.*desconfirmar.*/)
				
			 end

			it 'should show a link to unconfirm, if i am not confirmed' do
				user1 = Factory.create(:user)
				@dojo_session = Factory.create(:dojo_session, :confirmed_users=>[user1])
				assigns[:dojo_sessions] = [@dojo_session]

				render('dojo_sessions/index')

				response.should_not have_tag('div[id=?] a[href=?]', "dojo_session_#{@dojo_session.id}", unconfirm_presence_dojo_session_path(@dojo_session.id))

			 end

			it 'should show a link to unconfirm, if i am not logged in' do
				@dojo_session = Factory.create(:dojo_session, :confirmed_users=>[@user])
				assigns[:dojo_sessions] = [@dojo_session]
				session[:user_id] = nil

				render('dojo_sessions/index')

				response.should_not have_tag('div[id=?] a[href=?]', "dojo_session_#{@dojo_session.id}", unconfirm_presence_dojo_session_path(@dojo_session.id))

			 end

			
		end

	
		
	end

end