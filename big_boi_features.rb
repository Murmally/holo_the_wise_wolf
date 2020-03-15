include Bot

bot.command(:windmill) do |event|
	msg = '```_
       / /\
      / / /
     / / /   _
    /_/ /   / /\
    \ \ \  / /  \
     \ \ \/ / /\ \
  _   \ \ \/ /\ \ \
/_/\   \_\  /  \ \ \
\ \ \  / /  \   \_\/  
 \ \ \/ / /\ \ 
  \ \ \/ /\ \ \
   \ \  /  \ \ \
    \_\/   / / /
          / / /
         /_/ /
         \_\/```'
   event.respond msg
end

bot.message(contains: /breathes in/i) do |event|
  if rand(0..1) == 0
    event.respond "||nigger||"
  else
    event.respond "||ginger||"
  end
end

bot.command(:plna_taska) do |event|
  event.respond "<https://www.youtube.com/watch?v=5xQdOshDUOw>"
end

bot.message(contains: /hol[ao]/i) do |event|
  puts "Someone mentioned you! || server: #{event.server.name}, in: #{event.channel.name}, from: #{event.author.name} => #{event.content}"
  personal_log.info "server: #{event.server.name}, in: #{event.channel.name}, from: #{event.author.name} => #{event.content}"
end

bot.command(:kybl) do |event|
  event.respond "<https://www.youtube.com/watch?v=ovolaH4gMOk>"
end

bot.command(:cbt) do |event|
  $log.info create_log_message("cbt", event)
  event.respond File.read("./copypastas/cbt.txt")
end

bot.command(:set_log) do |event, new_log|
  if event.author.id != UserIdManager.owner
    return nil
  end
  $log.info create_log_message("new_log", event)
  $log.close
  file = File.open(new_log, "w+")
  $log = Logger.new(file)
  $log.info create_log_message("new_log", event)
  nil
end

bot.command(:racism) do |event|
  event.respond "Racism bad mmmkay"
end
