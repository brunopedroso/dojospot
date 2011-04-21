require 'digest/md5'

module UsersHelper
	
	def gravatarUrlFor(email, options={})
		hash = Digest::MD5.hexdigest(email.downcase)
		"http://www.gravatar.com/avatar/#{hash}.png?s=#{options[:size]}"
	end
	
end
