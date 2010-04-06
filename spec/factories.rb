
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

Factory.define User do |u|
		u.username 'foo'
	  u.email 'foo@example.com'
		u.password 'secret'
end