
Dado /^que eu não estou logado no sistema$/ do
  visit("/logout")
end

Dado /^que existe um usuário "([^\"]*)" com senha "([^\"]*)"$/ do |user, pass|
  Factory.create :user, :username=>user, :password=>pass
end