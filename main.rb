# TODO: formatovani helpu (Embed)
# TODO: logovani zpusobu pouzivani bota
# TODO: presunout globalni promenne a perzistentni data do statickych trid
# TODO: strawpoll
# TODO: perhaps


require 'discordrb'
require 'logger'

OWNER_ID = 328207275758059520
Bajkar = 358337749000126471

file = File.open('log.txt', File::WRONLY | File::APPEND)
$log = Logger.new(file, formatter: proc{ |severity, datetime, progname, msg| 
    "#{severity} #{datetime} || #{msg}\n"
})

personal_file = File.open('holo_mentions.txt', File::WRONLY | File::APPEND)
$personal_log = Logger.new(personal_file, formatter: proc{|severity, datetime, progname, msg|
    "#{datetime} || #{msg}\n"
})

$quote = "Default quote, use `h!set_quote` to add your own!"

$last_copypasta = ""
$last_gde_body = Time.now - 60
$last_rozsazeni_time = Time.now

$coolStory = ""
$hAhaa = ""
$star = ""

bot.ready() do |event|
  $coolStory = bot.find_emoji("CoolStory")
  $hAhaa = bot.find_emoji("HAhaa")
  $star = bot.find_emoji("star")
end

bot.command(:help) do |event|
  event << "`h!get_definition [SUBJECT] [term]` => get definition, eg. `h!get_definition ISA Tok`"
  event << "`h!add_definition [SUBJECT] [term] [definition...]` => add definition to a subject (Helper/Mod only)"
  event << "`h!add_subject [SUBJECT]` => add a subject to list of subjects, eg. `h!add_subject IZP` (Helper/Mod only)"
  event << "`h!subject_definitions [SUBJECT]` => get all definitions from given subject, eg. `h!subject_definitions IZP`"
  event << "`h!subjects` => get list of subjects\n"

  event << "h!FIT_zaznamy_link"
  event << "h!FIT_video_link\n"

  event << "h!help_random => list of several useless (although mildly entertaining) commands"
end


bot.command(:help_random) do |event|
  event << "h!pasta => get random copypasta"
  event << "h!pastas => list of all copypastas"
  event << "h!set_quote => set this bot's quote"
  event << "h!quote => get this bot's quote"
  event << "h!why_ruby => the decision-making behind choosing Ruby\n"
  event << "h!karma"
  event << "h!cbt"
  event << "h!ga"
  event << "h!exams"
  event << "h!linux"
  event << "h!racism"
  event << "h!flip"
end

bot.command(:big_boi_help) do |event|
  if event.author.id != OWNER_ID
    return nil
  end
  event << "h!whitelist"
  event << "h!JonLajoie"
  event << "h!bajkalarka"
  event << "h!somebody"
  event << "h!set_log"
  event << "h!kybl"
  event << "h!plna_taska"
  event << "h!rod"
end

bot.reaction_add(emoji: "\u2b50") do |event|
  return nil
  if Discordrb::Channel.load_message(event.message.id)
    puts "ayy"
  else
    puts "lmao"
  end

  xd = event.channel.load_message(event.message.id).nonce
  if event.channel.load_message(event.message.id).nonce == nil
    embed_msg = Discordrb::Webhooks::Embed.new(title: event.message.author.name, description: event.message)
    bot.send_message(672804971464491008, "", false, embed_msg)
  else
    puts "kokot"
    nil
  end
end

# TODO
bot.command(:blacklist) do |event, user|
  whitelist = File.read("./whitelist.txt")
  id = get_userid_from_tag(user)
  
end

bot.command(:whitelist) do |event, user|
  if event.author.id != OWNER_ID
    event.respod "Not permitted"
    return nil
  end
  whitelist = File.open("./whitelist.txt", "a+")
  id = get_userid_from_tag(user)
  whitelist.write(id + "\n")
  event.respond "User has been added to whitelist"
end

bot.command(:get_definition) do |event, subject, name|
  begin
    event.respond File.read("./school/#{subject}/#{name}.txt")
  rescue
    event.respond "Definition not found."
  end
end

bot.command(:add_definition, usage: 'add_definition [subject] [name] [args]') do |event, subject, name, *args|
  authorized_roles = ["Mod", "Helper"]
  if !check_for_role_by_rolenames(event.author, authorized_roles)
    $log.info create_log_message("add_definition_attempt", event)
    event.respond "You do not have permissions."
    return nil
  end

  $log.info create_log_message("add_definition", event)
  begin
    file = File.open("./school/#{subject}/#{name}.txt", "w+")
    file.write(args.join(' '))
    file.close
    event.respond "Definition of #{name} has been added to #{subject} library."
  rescue
    event.respond "Subject not found, try `h!subjects`"
  end
end

bot.command(:add_subject) do |event, subject|
  if Dir.exists? "./school/#{subject}"
    event.respond "Subject already exists"
    return nil
  else
    Dir.mkdir "./school/#{subject}"
    event.respond "Subject added"
  end
end

bot.command(:subject_definitions) do |event, subject|
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


bot.command(:subjects) do |event|
  dirs = Dir.glob("**/school/*").select {|f| File.directory? f}
  dirs.each do |file|
    event << "#{file.split("/")[-1]}"
  end
  nil
end

bot.command(:FIT_zaznamy_link) do |event|
  $log.info create_log_message("FIT_zaznamy_link", event)
  event.respond "https://drive.google.com/drive/folders/1YtEOsXAUEZDzh5WwAmml9g8FT7iHgWcG"
end

bot.command(:FIT_video_link) do |event|
  $log.info create_log_message("FIT_video_link", event)
  event.respond "video1.fit.vutbr.cz"
end


bot.command(:somebody) do |event|
  event.respond "<https://youtu.be/L_jWHffIx5E?t=36>"
end

bot.command(:diag) do |event|
  $log.info create_log_message("diag", event)
  if test_pastas
    event.respond "Copypasta library seems to be OK!"
  else
    event.respond "Certain copypasta in library is too long!"
  end
end

bot.message(from: ["Bajkař", "ElDandee"]) do |event|
  event.message.create_reaction($coolStory)
  event.message.create_reaction($hAhaa)
end

bot.command(:flip) do |event|
  num = rand 0..1
  event.respond num == 0 ? "Ano" : "Ne"
end

bot.command(:quote) do |event|
  $log.info create_log_message("quote", event)
  event.respond $quote
end

bot.command(:set_quote) do |event|
  $log.info create_log_message("set_quote", event)
  new_quote = ""
  words = event.content.split(' ')
  for i in 1...words.length
    new_quote += words[i] + " "
  end
  new_quote += "– *#{event.author.name}*"
  $quote = new_quote
  event.respond "Quote set to \"#{new_quote}\""
end

bot.command(:bajkalarka) do |event|
  event.respond "=== UVOD ===\n\n-by Bajkar"
end

bot.command(:karma) do |event|
  $log.info create_log_message("karma", event)
  msg = "Sice nejsi nejkrásnější, ani nejchytřejší, ani dobrý sportovec, ale my tě máme stejně rádi :heart:\n"
  event.respond msg
end

bot.command(:racism) do |event|
  $log.info create_log_message("racism", event)
  event.respond "Racism bad mmmkay"
end

bot.command(:ping) do |event|
  $log.info "ping || #{Time.now - event.timestamp} || #{event.author.name} || #{event.content}"
  event.respond "#{Time.now - event.timestamp} s"
end

bot.command(:set_log) do |event, new_log|
  if event.author.id != OWNER_ID
    return nil
  end
  $log.info create_log_message("new_log", event)
  $log.close
  file = File.open(new_log, "w+")
  $log = Logger.new(file)
  $log.info create_log_message("new_log", event)
  nil
end

bot.command(:pastas) do |event|
  msg = ""
  content = Dir["./copypastas/**.txt"]
  content.each do |file|
    msg += "#{file.split(".txt")[-1].split("/")[-1]}, "
  end
  event.respond msg
end

bot.command(:pasta, max_args: 2) do |event, *args|
  $log.info create_log_message("pasta", event)
  if args.length == 0
    event.respond get_random_pasta
  else
    event.respond File.read("./copypastas/#{args[0]}.txt")
  end
end

bot.message(start_with: "!kasparek") do |event|
  event.respond "Neposlouchej MEE6, i s tvým kašpárkem se dá zahrát ... mírně nadprůměrné divadlo"
end

bot.message(contains: [/gde body/i, /body gde/i, ":GDEBODY:"]) do |event|
  if $last_gde_body + 5 < Time.now
    $log.info create_log_message("gde body", event)
    event.respond "Pal do piče"
  end
end

bot.command(:why_ruby) do |event|
  $log.info create_log_message("why_ruby", event)
  event.respond "Ruby is a big dick language and here's why: <https://www.youtube.com/watch?v=dQw4w9WgXcQ>"
end

bot.command(:exams) do |event|
  $log.info create_log_message("exams", event)
  event.respond File.read("./copypastas/exams.txt")
end

# TODO
# bot.command(:strawpoll) do |event, question, *options|
#   $log.info create_log_message("strawpoll", event)
#   msg = "#{question}:\n"

#   i = 0  
#   emoji_nums = ['one', 'two', 'three', 'four', 'five', 'six', 'seven', 'eight', 'nine', 'keycap_ten']
#   row = ""
#   for emoji in emoji_nums
#     row = ":#{emoji}:\t#{options[i]}\n"
#     i += 1
#     if i > options.length
#       break
#     else
#       msg = msg.concat(row)
#       #new_reaction = 
#     end
#   end
#   event.respond(msg)
# end

bot.command(:cbt) do |event|
  $log.info create_log_message("cbt", event)
  event.respond File.read("./copypastas/cbt.txt")
end

bot.command(:ga) do |event|
  $log.info create_log_message("gibabay", event)
  event.respond "GI:b:A:b:AY WHEN"
end

bot.command(:linux) do |event|
  $log.info create_log_message("linux interjection", event)
  event.respond File.read("./copypastas/gnu_interjection.txt")
end

bot.command(:kybl) do |event|
  event.respond "<https://www.youtube.com/watch?v=ovolaH4gMOk>"
end

bot.message(contains: /hol[ao]/i) do |event|
  puts "Someone mentioned you! || server: #{event.server.name}, in: #{event.channel.name}, from: #{event.author.name} => #{event.content}"
  $personal_log.info "server: #{event.server.name}, in: #{event.channel.name}, from: #{event.author.name} => #{event.content}"
end

bot.command(:JonLajoie) do |event|
  event << "h!idgaf"
  event << "h!eng"
  event << "h!eng2"
  event << "h!ikp"
end

bot.command(:ikp) do |event|
  event.respond "https://www.youtube.com/watch?v=xC03hmS1Brk"
end

bot.command(:idgaf) do |event|
  event.respond "https://www.youtube.com/watch?v=ulIOrQasR18"
end

bot.command(:eng) do |event|
  event.respond "https://www.youtube.com/watch?v=5PsnxDQvQpw"
end

bot.command(:eng2) do |event|
  event.respond "https://www.youtube.com/watch?v=GmG4X9PGOXs"
end




def get_userid_from_tag(tag)
  tag.scan(/\d/).join('')
end

# returns string from a file in 'copypastas' folder
def get_random_pasta
  pasta_dir = Dir["./copypastas/**/*.txt"]
  text = ""
  loop do
    path = pasta_dir[rand(pasta_dir.length)]
    text = File.read(path)
    if (text != $last_copypasta)
      break
    end
  end
  $last_copypasta = text
  return text
end

def check_for_role_by_rolenames(user, roles)
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

def create_log_message(command, event)
  msg = "#{command} || #{event.author.name} || #{event.content}"
end

def init_reaction(text, bot, server)
  #data = {:name => text, :animated => false}
  #emoji = Emoji.new(data, bot, server)
end

def test_pastas
  pasta_dir = Dir["./copypastas/**/*.txt"]
  res = true
  for file in pasta_dir
    current = File.read(file)
    if current.length > 2000
      res = false
      puts "#{file} is too big! #{current.length}/2000 chars."
    end
  end
  return res
end

bot.message(contains: /dobrou noc holo/i) do |event|
  if event.author.id != OWNER_ID
    return
  end
  event.respond "Dobrou noc"
  exit
end

bot.command(:ruby) do |event|
  event.respond "Hóvno"
end

bot.command(:plna_taska) do |event|
  event.respond "<https://www.youtube.com/watch?v=5xQdOshDUOw>"
end

bot.command(:rod) do |event|
  event.respond "Jsem žena!"
end

bot.message(contains: /kdyby se mi cht[eě]lo/i) do |event|
  event.respond "jak se ti nechce"
end

bot.message(contains: /nem[aá]m pravdu\?/i) do |event|
  if event.author.id == OWNER_ID  # in case it's me
    if event.content.match? (/nemám pravdu?/i)
      event.respond "Ne, nemáš pravdu."
    else
      event.respond "Ano, máš pravdu."
    end
  else
    if rand(0..1) == 0
      event.respond "Ne, nemáš pravdu."
    else
      event.respond "Ano, máš pravdu."
    end
  end
end

# example
bot.command(:random, min_args: 0, max_args: 2, usage: 'random [min/max] [max]') do  |event, min, max|
  if max
    rand(min.to_i..max.to_i)
  elsif min
    rand(0..min.to_i)
  else
    rand
  end
end

bot.run
