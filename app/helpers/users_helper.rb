require 'digest/md5'

module UsersHelper
	
	def gravatarUrlFor(email, options={})
		email = '' if email.nil?
		hash = Digest::MD5.hexdigest(email.downcase)
		"http://www.gravatar.com/avatar/#{hash}.png?s=#{options[:size]}"
	end
	
	def link_to_page_url_if_needed(user, text)
		if user.page_url.blank?
			text
		else
			link_to text, user.page_url
		end
	end
	
end
