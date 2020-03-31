include Bot


$last_copypasta = ""
$last_gde_body = Time.now - 60



bot.command(:flip) do |event|
  num = rand 0..1
  event.respond num == 0 ? "true" : "false"
end

bot.command(:quote) do |event|
	event.respond File.read("./quote.txt")
end

bot.command(:set_quote) do |event, *args|
	quote_file = File.new("./quote.txt", "w")
	args.each do |arg|
		quote_file.write("#{arg} ")
	end
	quote_file.close
	event.respond "Quote set!"
end

bot.command(:bajkalarka) do |event|
  "=== UVOD ===\n\n-by Bajkar"
end

bot.command(:karma) do |event|
  "Sice nejsi nejkrásnější, ani nejchytřejší, ani dobrý sportovec, ale my tě máme stejně rádi :heart:\n"
end

bot.command(:ping) do |event|
  "#{Time.now - event.timestamp} s"
end

bot.command(:dan) do |event|
	"The depicted character is over 18 years old, as explained in their respective backstory and therefore falls under pettanko (adults with bodies that **look** young), not loli (children)."
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
  log.info Utils.create_log_message("pasta", event)
  if args.length == 0
    event.respond get_random_pasta
  else
    event.respond File.read("./copypastas/#{args[0]}.txt")
  end
end

bot.message(start_with: "!kasparek") do |event|
  event.respond "Neposlouchej MEE6, i s tvým kašpárkem se dá zahrát ... mírně nadprůměrné divadlo"
end

bot.message(contains: [/gde ?body/i, /body ?gde/i, ":GDEBODY:"]) do |event|
  if $last_gde_body + 5 < Time.now
    log.info Utils.create_log_message("gde body", event)
    event.respond "Pal do piče"
  end
end

bot.command(:why_ruby) do |event|
  log.info Utils.create_log_message("why_ruby", event)
  event.respond "Ruby is a big dick language and here's why: <https://www.youtube.com/watch?v=dQw4w9WgXcQ>"
end

bot.command(:exams) do |event|
  log.info Utils.create_log_message("exams", event)
  event.respond File.read("./copypastas/exams.txt")
end

bot.command(:linux) do |event|
  log.info Utils.create_log_message("linux interjection", event)
  event.respond File.read("./copypastas/gnu_interjection.txt")
end

bot.command(:JonLajoie) do |event|
  event << "h!idgaf => Fuck Everything"
  event << "h!eng => Everyday Normal Guy"
  event << "h!eng2 => Everyday Normal Guy 2"
  event << "h!ikp => I Kill People"
end

bot.command(:gender) do |event|
  event.respond "I am a beautiful and strong female!"
end

bot.message(contains: /kdyby se mi cht[eě]lo/i) do |event|
  event.respond "jak se ti nechce"
end

bot.message(contains: [/am i right\??/i, /amirite\??/i]) do |event|
  if rand(0..1) == 0
    event.respond "Yes, you are right."
  else
    event.respond "No, you are wrong."
  end
end

bot.command(:unsee) do |event|
  event.respond File.read("./unsee.txt")
end

bot.message(contains: /nem[aá]m pravdu\??/i) do |event|
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
bot.command(:random, min_args: 0, usage: 'random [min/max] [max]') do  |event, min, max|
  if max
    rand(min.to_i..max.to_i)
  elsif min
    rand(0..min.to_i)
  else
    rand
  end
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