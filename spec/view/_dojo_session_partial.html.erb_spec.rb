require 'spec_helper'

def render_partial
	render(:partial => 'dojo_sessions/dojo_session', :locals=>{:dojo_session=>@dojo_session})
end

describe 'dojo partial' do
	
		context 'details' do

			before :each do 
				@dojo_session = Factory.create(:dojo_session, :confirmed_users=>[Factory.create(:user)])
			end

			
			it 'should show the next proposed session' do
				render_partial
				response.should have_tag('h1', @dojo_session.title)
				response.should have_tag('p', @dojo_session.text)
				response.should include_text(@dojo_session.place)
				response.should include_text(I18n.l(@dojo_session.date, :format=>"pretty"))
				response.should include_text(@dojo_session.time)

			end
			
			it 'should present date in brazilian format' do
				render_partial
				the_date = I18n.l @dojo_session[:date], :format=>"pretty"
				response.should include_text(the_date)
			end
			
			it 'should not show the no-sessions message' do
				render_partial
				response.should_not have_tag('p', 'Nenhuma sessão proposta no momento.')
			end
					
			it 'should textilize the dojo session content' do
				@dojo_session.text = 'h3. meu titulo muito feliz'
				render_partial
				response.should have_tag('h3', 'meu titulo muito feliz')
			end
					
			it 'should not show a link to edit if i am NOT logged in' do
				session[:user_id] = nil
				render_partial
				response.should_not have_tag('a[href=?]', "/dojo_sessions/#{@dojo_session.id}/edit", 'editar')
			end
			
			it 'should show a link to edit when i am logged in one of the confirmed users ' do
				user = @dojo_session.confirmed_users[0]
			
				# tem que ter privilégio
				user.has_propose_priv=true
				user.save
			
				session[:user_id] = user.id
			
				render_partial
				response.should have_tag('a[href=?]', "/dojo_sessions/#{@dojo_session.id}/edit", 'edit')
			end
			
			it 'should not show a link to edit if i am NOT a confirmed user' do
				session[:user_id] = Factory.create(:user).id
				render_partial
				response.should_not have_tag('a[href=?]', "/dojo_sessions/#{@dojo_session.id}/edit", 'edit')
			end
			
			it 'should not show a link to edit if i do NOT have privileges' do
				user = @dojo_session.confirmed_users[0]
				user.has_propose_priv=false
				session[:user_id] = session[:user_id] = user.id
				render_partial
				response.should_not have_tag('a[href=?]', "/dojo_sessions/#{@dojo_session.id}/edit", 'editar')
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
				render_partial
				response.should have_tag('a[href=?]', "/dojo_sessions/#{@dojo_session.id}/confirm_presence", 'Confirm my presence!')
			end
			
			it 'should show a link to confirm presence in the session if i am not one of the confirmed users' do
				@dojo_session = Factory.create(:dojo_session, :confirmed_users=>[Factory.create(:user)])
				render_partial
				response.should have_tag('a[href=?]', "/dojo_sessions/#{@dojo_session.id}/confirm_presence", 'Confirm my presence!')
			end
	
			it 'should not show a link to confirm presence if i am already a confirmed user' do
				@dojo_session = Factory.create(:dojo_session, :confirmed_users=>[@user])
				render_partial
				response.should_not have_tag('a', 'Confirmar minha presença')
			end
			
			it 'should show a link to confirm presence even if i am not logged in' do
				
				# a idéia é que caia na página de login, mas isso deve ser testado no controller, não aqui.
				
				session[:user_id] = nil
				@dojo_session = Factory.create(:dojo_session)
				render_partial
				response.should have_tag('a', 'Confirm my presence!')
			end
			
		end
		
		
		context 'confirmed users list' do 
			
			it 'should show nowbody-confirmed-message if there is nobody confirmed' do
				@dojo_session = Factory.create(:dojo_session, :confirmed_users=>[])
				render_partial
				response.should_not have_tag('div[id=?]', "dojo_session_#{@dojo_session.id}", :text=>/.*Confirmados até agora.*/)
				response.should have_tag('div[id=?]', "dojo_session_#{@dojo_session.id}", :text=>/.*Nobody confirmed yet.*/)
			end
	
			it 'should not show nobody-confirmed-message if there is someone confirmed' do
				@dojo_session = Factory.create(:dojo_session, :confirmed_users=>[Factory.create(:user)])
				render_partial
				response.should have_tag('div[id=?]', "dojo_session_#{@dojo_session.id}", :text=>/.*Confirmed so far.*/)
				response.should_not have_tag('div[id=?]', "dojo_session_#{@dojo_session.id}", :text=>/.*Ninguém confirmou ainda.*/)
			end
	
			it 'should show the usernames of the confirmed users' do
				user1 = Factory.create(:user)
				user2 = Factory.create(:user)
				@dojo_session = Factory.create(:dojo_session, :confirmed_users=>[user1, user2])
				render_partial
				response.should have_tag('div[id=?]', "dojo_session_#{@dojo_session.id}", :text=>/.*Confirmed so far.*/)
				response.should have_tag('div[id=?] ol li', "dojo_session_#{@dojo_session.id}", :text=>/.*#{user1.username}.*/)
				response.should have_tag('div[id=?] ol li', "dojo_session_#{@dojo_session.id}", :text=>/.*#{user2.username}.*/)
			end
	
			it 'should show the names of the confirmed users if they have filled a name' do
				user1 = Factory.create(:user, :name=>'my real name')
				user2 = Factory.create(:user)
				user3 = Factory.create(:user, :name=> '') #empty - this is a special case
				@dojo_session = Factory.create(:dojo_session, :confirmed_users=>[user1, user2, user3])
				render_partial
				response.should have_tag('div[id=?]', "dojo_session_#{@dojo_session.id}", :text=>/.*Confirmed so far.*/)
				response.should have_tag('div[id=?] ol li', "dojo_session_#{@dojo_session.id}", :text=>/.*#{user1.name}.*/)
				response.should have_tag('div[id=?] ol li', "dojo_session_#{@dojo_session.id}", :text=>/.*#{user2.username}.*/)
				response.should have_tag('div[id=?] ol li', "dojo_session_#{@dojo_session.id}", :text=>/.*#{user3.username}.*/)
			end
	
			
			it 'should show a link to unconfirm, if the current_user is already confirmed' do
				@dojo_session = Factory.create(:dojo_session, :confirmed_users=>[@user])
				render_partial
				response.should have_tag('div[id=?] a[href=?]', "dojo_session_#{@dojo_session.id}", unconfirm_presence_dojo_session_path(@dojo_session.id),:text=>/.*unconfirm.*/)
			 end
	
			it 'should show a link to unconfirm, if i am not confirmed' do
				user1 = Factory.create(:user)
				@dojo_session = Factory.create(:dojo_session, :confirmed_users=>[user1])
				render_partial
				response.should_not have_tag('div[id=?] a[href=?]', "dojo_session_#{@dojo_session.id}", unconfirm_presence_dojo_session_path(@dojo_session.id))
			 end
	
			it 'should show a link to unconfirm, if i am not logged in' do
				@dojo_session = Factory.create(:dojo_session, :confirmed_users=>[@user])
				session[:user_id] = nil
				render_partial
				response.should_not have_tag('div[id=?] a[href=?]', "dojo_session_#{@dojo_session.id}", unconfirm_presence_dojo_session_path(@dojo_session.id))
			 end
			
		end

		context 'a past session' do
			
			it 'should not show the confirmations div' do
				
				yesterday = Date.today-1
				@dojo_session = Factory.create(:dojo_session, :confirmed_users=>[@user], :date=>yesterday)
				
				render_partial
				response.should_not have_tag('div[id=?]', "confirmations")
				
			end
			
		end
		
	end

end