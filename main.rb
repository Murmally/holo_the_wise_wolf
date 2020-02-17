# TODO: presunout globalni promenne a perzistentni data do statickych trid
# TODO: strawpoll
# TODO: perhaps


require_relative 'init'
require_relative 'help'
require_relative 'school_related'
require_relative 'random_features'
require_relative 'big_boi_features' # stuff that is not meant for public's eyes


$bot = init_bot()
$log = init_log()


# To avoid repeatedly searching DC servers' emojis
class SavedEmojis
	attr_reader :hahaa, :coolStory, :abdoHappy, :cryabdo

	def initialize
		@hahaa = $bot.find_emoji("HAhaa")
		@coolStory = $bot.find_emoji("CoolStory")
		@abdoHappy = $bot.find_emoji("AbdoHappy")
		@cryabdo = $bot.find_emoji("cryabdo")
		puts "SavedEmojis initialized"
	end
end

# Used to keep track of certain individuals' IDs
class UserIDs
	def self.owner
		return 328207275758059520
	end

	def self.bajkar
		return 358337749000126471
	end

	def self.abdo_laziz
		return 202420992801243136
	end
end



$last_copypasta = ""
$last_gde_body = Time.now - 60


$bot.ready() do |event|
	$EmojiManager = SavedEmojis.new
end

# Help-related commands
$bot.command(:help) 		    { |event| Help.handle_help(event) }
$bot.command(:help_school) 	{ |event| Help.handle_school_help(event) }
$bot.command(:help_random) 	{ |event| Help.handle_help_random(event) }
$bot.command(:big_boi_help) { |event| Help.handle_big_boi_help(event, UserIDs.owner) }


# School-related commands
$bot.command(:add_subject) 		     { |event, subject| School_related.handle_add_subject(event, subject) }
$bot.command(:subjects) 		       { |event| School_related.handle_subjects(event) }
$bot.command(:get_definition) 	   { |event| School_related.handle_get_definition(event) }
$bot.command(:FIT_video_link) 	   { |event| School_related.handle_FIT_video_link(event) }
$bot.command(:FIT_zaznamy_link)    { |event| School_related.handle_FIT_zaznamy_link(event) }
$bot.command(:subject_definitions) { |event, subject|
 	School_related.handle_subject_definitions(event, subject) }
$bot.command(:add_definition) 	   { |event, subject, name, *args| 
	School_related.handle_add_definition(event, subject, name, *args, $log) }


# TODO
$bot.reaction_add(emoji: "\u2b50") do |event|
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
    nil
  end
end

# Add priviledges to user
$bot.command(:whitelist) do |event, user|
  if event.author.id != UserIDs.owner
    event.respod "Not permitted"
    return nil
  end
  whitelist = File.open("./whitelist.txt", "a+")
  id = get_userid_from_tag(user)
  whitelist.write(id + "\n")
  event.respond "User has been added to whitelist"
end

$bot.command(:somebody) do |event|
  event.respond "<https://youtu.be/L_jWHffIx5E?t=36>"
end

$bot.message(from: UserIDs.abdo_laziz, contains: /so ?sad ?a?bout ?th[ia][st]/i) do |event|
	event.message.create_reaction($EmojiManager.cryabdo)
end

$bot.message(from: UserIDs.abdo_laziz, contains: /so ?happy ?a?bout ?th[ia][st]/i) do |event|
	event.message.create_reaction($EmojiManager.abdoHappy)
end

$bot.message(from: UserIDs.bajkar) do |event|
  event.message.create_reaction($EmojiManager.coolStory)
  event.message.create_reaction($EmojiManager.hahaa)
end

$bot.command(:flip) do |event|
  num = rand 0..1
  event.respond num == 0 ? "Ano" : "Ne"
end

$bot.command(:quote) do |event|
	event.respond File.read("./quote.txt")
end

$bot.command(:set_quote) do |event, *args|
	quote_file = File.new("./quote.txt", "w")
	args.each do |arg|
		quote_file.write("#{arg} ")
	end
	quote_file.close
	event.respond "Quote set!"
end

$bot.command(:bajkalarka) do |event|
  event.respond "=== UVOD ===\n\n-by Bajkar"
end

$bot.command(:karma) do |event|
  msg = "Sice nejsi nejkrásnější, ani nejchytřejší, ani dobrý sportovec, ale my tě máme stejně rádi :heart:\n"
  event.respond msg
end

$bot.command(:ping) do |event|
  event.respond "#{Time.now - event.timestamp} s"
end

$bot.command(:pastas) do |event|
  msg = ""
  content = Dir["./copypastas/**.txt"]
  content.each do |file|
    msg += "#{file.split(".txt")[-1].split("/")[-1]}, "
  end
  event.respond msg
end

$bot.command(:pasta, max_args: 2) do |event, *args|
  $log.info create_log_message("pasta", event)
  if args.length == 0
    event.respond get_random_pasta
  else
    event.respond File.read("./copypastas/#{args[0]}.txt")
  end
end

$bot.message(start_with: "!kasparek") do |event|
  event.respond "Neposlouchej MEE6, i s tvým kašpárkem se dá zahrát ... mírně nadprůměrné divadlo"
end

$bot.message(contains: [/gde ?body/i, /body ?gde/i, ":GDEBODY:"]) do |event|
  if $last_gde_body + 5 < Time.now
    $log.info create_log_message("gde body", event)
    event.respond "Pal do piče"
  end
end

$bot.command(:why_ruby) do |event|
  $log.info create_log_message("why_ruby", event)
  event.respond "Ruby is a big dick language and here's why: <https://www.youtube.com/watch?v=dQw4w9WgXcQ>"
end

$bot.command(:exams) do |event|
  $log.info create_log_message("exams", event)
  event.respond File.read("./copypastas/exams.txt")
end


$bot.command(:linux) do |event|
  $log.info create_log_message("linux interjection", event)
  event.respond File.read("./copypastas/gnu_interjection.txt")
end

$bot.command(:JonLajoie) do |event|
  event << "h!idgaf => Fuck Everything"
  event << "h!eng => Everyday Normal Guy"
  event << "h!eng2 => Everyday Normal Guy 2"
  event << "h!ikp => I Kill People"
end

$bot.command(:ikp) do |event|
  event.respond "https://www.youtube.com/watch?v=xC03hmS1Brk"
end

$bot.command(:idgaf) do |event|
  event.respond "https://www.youtube.com/watch?v=ulIOrQasR18"
end

$bot.command(:eng) do |event|
  event.respond "https://www.youtube.com/watch?v=5PsnxDQvQpw"
end

$bot.command(:eng2) do |event|
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

$bot.message(contains: /dobrou noc holo/i) do |event|
  if event.author.id != UserIDs.owner
    return
  end
  event.respond "Dobrou noc"
  exit
end

$bot.message(contains: [/thank you holo/i, /thanks holo/i, /d[ií]ky holo/i, /d[eě]kuj[iu] holo/i]) do |event|
	event.message.react("❤️")
end

$bot.command(:gender) do |event|
  event.respond "I am a beautiful and strong female!"
end

$bot.message(contains: /kdyby se mi cht[eě]lo/i) do |event|
  event.respond "jak se ti nechce"
end

$bot.message(contains: [/am i right\??/i, /amirite\??/i]) do |event|
	if rand(0..1) == 0
		event.respond "Yes, you are right."
	else
		event.respond "No, you are wrong."
	end
end

$bot.message(contains: /nem[aá]m pravdu\??/i) do |event|
  if event.author.id == UserIDs.owner  # in case it's me
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
$bot.command(:random, min_args: 0, usage: 'random [min/max] [max]') do  |event, min, max|
  if max
    rand(min.to_i..max.to_i)
  elsif min
    rand(0..min.to_i)
  else
    rand
  end
end


$bot.run