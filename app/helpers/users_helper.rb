require 'digest/md5'

module UsersHelper
	
	def gravatarUrlFor(string)
		hash = Digest::MD5.hexdigest(@user.email.downcase)
		"http://www.gravatar.com/avatar/#{hash}.png"
	end
	
end
