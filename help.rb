bot.command(:help_school) do |event|
  msg = ""
  msg += "`h!get_definition [SUBJECT] [term]` => get definition, eg. `h!get_definition ISA Tok`\n"
  msg += "`h!add_definition [SUBJECT] [term] [definition...]` => add definition to a subject (Helper/Mod only)\n"
  msg += "`h!add_subject [SUBJECT]` => add a subject to list of subjects, eg. `h!add_subject IZP` (Helper/Mod only)\n"
  msg += "`h!subject_definitions [SUBJECT]` => get all definitions from given subject, eg. `h!subject_definitions IZP`\n"
  msg += "`h!subjects` => get list of subjects\n\n"

  msg += "h!FIT_zaznamy\n"
  msg += "h!FIT_video\n\n"

  msg += "h!help => list of several useless (although mildly entertaining) commands\n"
  embed = Discordrb::Webhooks::Embed.new(title: "School Help", description: msg)
  event.channel.send_embed("", embed)
end

bot.command(:help_random) do |event|
  msg = "h!pasta => get random copypasta\n"
  msg += "h!pastas => list of all copypastas\n"
  msg += "h!set_quote => set this bot's quote\n"
  msg += "h!quote => get this bot's quote\n"
  msg += "h!why_ruby => the decision-making behind choosing Ruby\n\n"
  msg += "h!karma\n"
  msg += "h!cbt\n"
  msg += "h!exams\n"
  msg += "h!linux\n"
  msg += "h!racism\n"
  msg += "h!flip\n"
  msg += "h!JonLajoie\n"
  msg += "h!somebody\n"
  msg += "h!gender\n"
  msg += "h!unsee\n"
  embed = Discordrb::Webhooks::Embed.new(title: "Random Help", description: msg)
  event.channel.send_embed("", embed)
end

bot.command(:help) do |event|
  msg = "h!help_random => Collection of very random features\n"
  msg += "h!help_school => VUT FIT related\n"
  embed = Discordrb::Webhooks::Embed.new(title: "Help", description: msg)
  event.channel.send_embed("", embed)
end

bot.command(:big_boi_help) do |event|
  msg = "h!windmill\n"
  msg += "h!whitelist\n"
  msg += "h!JonLajoie\n"
  msg += "h!bajkalarka\n"
  msg += "h!somebody\n"
  msg += "h!set_log\n"
  msg += "h!kybl\n"
  msg += "h!plna_taska\n"
  msg += "h!gender\n"

  msg = "You don't have permisson!" if event.author.id != UserIDs.owner
  embed = Discordrb::Webhooks::Embed.new(title: "BIG BOI HELP", description: msg)
  event.channel.send_embed("", embed)
end
