require_relative 'init'
require_relative 'utils'
require_relative 'userIDs'
require_relative 'emojiManager'
require_relative 'links'
require_relative 'help'
require_relative 'school_related'
require_relative 'random_features'
require_relative 'big_boi_features' # stuff that is not meant for public's eyes



bot.ready() do |event|
	SavedEmojis.init
end

# Add priviledges to user
bot.command(:whitelist) do |event, user|
  if event.author.id != UserIDs.owner
    event.respod "Not permitted"
    return nil
  end
  whitelist = File.open("./whitelist.txt", "a+")
  id = Utils.get_userid_from_tag(user)
  whitelist.write(id + "\n")
  whitelist.close
  event.respond "User has been added to whitelist"
end

bot.run