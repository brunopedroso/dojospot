
Factory.sequence :dojo_session_title do |n|
	"Sessão de dojo número #{n}"
end


Factory.define DojoSession do |s|
		s.title {Factory.next :dojo_session_title}
		s.text "Venha codar com a gente!"
		s.place "na SEA tecnologia"
		s.date {Date.today}
		s.time "17:00 às 19:00"
end

Factory.sequence :user_name do |n|
	"foo#{n}"
end

Factory.sequence :user_email do |n|
	"foo#{n}@example.com"
end


Factory.define User do |u|
		u.username {Factory.next :user_name}
	  u.email {Factory.next :user_email}
		u.password 'secret'
end