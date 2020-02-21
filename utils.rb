module Utils
	def self.check_for_role_by_rolenames(user, roles)
  		whitelist = File.read("./whitelist.txt")
  		whitelist.lines.each do |line|
    		if user.id == line.chomp!.to_i
	  	    	return true
    		end
	  	end
  		user.roles.each do |role|
    		if roles.include? role.name
	      		return true
    		end
  		end
	  	return false
	end

	def self.get_userid_from_tag(tag)
		tag.scan(/\d/).join('')
	end

	def self.create_log_message(command, event)
		msg = "#{command} || #{event.author.name} || #{event.content}"
	end

	# TODO? never tested
	def self.add_key_value_to_embed_field(embed_msg, key, value)
		Discordrb::EmbedField.new(embed_msg, true, key, value) # true is for :inline
	end
end