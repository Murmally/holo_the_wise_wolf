class School_related
	def self.handle_get_definition(event)
	  begin
	    event.respond File.read("./school/#{subject}/#{name}.txt")
	  rescue
	    event.respond "Definition not found."
	  end
	end

	def self.handle_add_definition(event, subject, name, *args, log)
	  authorized_roles = ["Mod", "Helper"]
	  if !check_for_role_by_rolenames(event.author, authorized_roles)
	    log.info create_log_message("add_definition_attempt", event)
	    event.respond "You do not have permissions."
	    return nil
	  end

	  begin
	    file = File.open("./school/#{subject}/#{name}.txt", "w+")
	    file.write(args.join(' '))
	    file.close
	    event.respond "Definition of #{name} has been added to #{subject} library."
	  rescue
	    event.respond "Subject not found, try `h!subjects`"
	  end
	end

	def self.handle_add_subject(event, subject)
	  if Dir.exists? "./school/#{subject}"
	    event.respond "Subject already exists"
	    return nil
	  else
	    Dir.mkdir "./school/#{subject}"
	    event.respond "Subject added"
	  end
	end

	def self.handle_subject_definitions(event, subject)
	  msg = ""
	  if !Dir.exists? "./school/#{subject}"
	    event.respond "No such subject found, try h!subjects"
	    return nil
	  end
	  content = Dir["./school/#{subject}/**.txt"]
	  event << "#{subject} definitions:"
	  content.each do |file|
	    event << "#{file.split(".txt")[-1].split("/")[-1]}"
	  end
	  nil
	end


	def self.handle_subjects(event)
	  dirs = Dir.glob("**/school/*").select {|f| File.directory? f}
	  dirs.each do |file|
	    event << "#{file.split("/")[-1]}"
	  end
	  nil
	end

	def self.handle_FIT_zaznamy_link(event)
	  event.respond "https://drive.google.com/drive/folders/1YtEOsXAUEZDzh5WwAmml9g8FT7iHgWcG"
	end

	def self.handle_FIT_video_link(event)
	  event.respond "video1.fit.vutbr.cz"
	end

end