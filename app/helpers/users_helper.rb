require 'digest/md5'

module UsersHelper
	
	def gravatarUrlFor(email)
		hash = Digest::MD5.hexdigest(email.downcase)
		"http://www.gravatar.com/avatar/#{hash}.png"
	end
	
end
