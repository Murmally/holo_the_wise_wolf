require_relative 'init'
include Bot

# To avoid repeatedly searching DC servers' emojis
class SavedEmojis
	def self.init
		@hahaa = bot.find_emoji("HAhaa")
		@coolStory = bot.find_emoji("CoolStory")
		@abdoHappy = bot.find_emoji("AbdoHappy")
		@cryabdo = bot.find_emoji("cryabdo")
    	@abdobruh = bot.find_emoji("abdobruh")
    	@kekabdo = bot.find_emoji("kekabdo")
		puts "SavedEmojis initialized"
	end

	def self.hahaa; 	@hahaa; 	end
	def self.coolStory; @coolStory; end
	def self.abdoHappy; @abdoHappy; end
	def self.cryabdo; 	@cryabdo; 	end
	def self.abdobruh; 	@abdobruh; 	end
	def self.kekabdo; 	@kekabdo; 	end
end

bot.message(contains: /so ?sad ?a?bout ?th[ia][st]/i) do |event|
	event.message.create_reaction(SavedEmojis.cryabdo)
end

bot.message(contains: /so ?happy ?a?bout ?th[ia][st]/i) do |event|
	event.message.create_reaction(SavedEmojis.abdoHappy)
end

bot.message(contains: /bru+h/i) do |event|
	next nil if event.server.id != 672080924095152128
  event.message.create_reaction(SavedEmojis.abdobruh)
end

# deprecated - too much spam
# bot.message(contains: [/kekw?/i, /lmf?ao/i, /lol/i]) do |event|
# 	next if event.server.id != 672080924095152128
#   event.message.create_reaction(SavedEmojis.kekabdo)
# end

bot.message(from: UserIDs.bajkar) do |event|
  event.message.create_reaction(SavedEmojis.coolStory)
  event.message.create_reaction(SavedEmojis.hahaa)
end

bot.message(contains: [/thank you holo/i, /thanks holo/i, /d[ií]ky holo/i, /d[eě]kuj[iu] holo/i]) do |event|
  event.message.react("❤️")
end