
Dado /^que eu estou logado no sistema$/ do
	Dado %{que eu estou logado no sistema como "foo"}
end

Dado /^que eu estou logado no sistema como "([^\"]*)"$/ do |nome|
  user = Factory.create :user, :username=>nome, :email=>"#{nome}@example.com"
	visit '/sessions/new'
	fill_in "login", :with => user.username
	fill_in "password", :with => user.password
	click_button('Log in')
end

Dado /^que eu não estou logado no sistema$/ do
  visit("/logout")
end

Dado /^que existe um usuário "([^\"]*)" com senha "([^\"]*)"$/ do |user, pass|
  Factory.create :user, :username=>user, :password=>pass
end

Dado /^que o usuário "([^\"]*)" não tem privilégio de propor sessão$/ do |username|
 	u =  User.find_by_username(username)
	u.has_propose_priv = false
	u.save
end

Dado /^que o usuário "([^\"]*)" tem privilégio de propor sessão$/ do |username|
 	u =  User.find_by_username(username)
	u.has_propose_priv = true
	u.save
end