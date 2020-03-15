include Bot

# bot.command(:yt) do |event|
# 	YOUTUBE_URL = /^(?:http(s)??\:\/\/)?(?:www\.)?(?:(?:youtube\.com\/watch\?v=)|(?:youtu.be\/))(?:[a-zA-Z0-9\-_])+/

# 	unless url =~ YOUTUBE_URL; return 'This is not a valid youtube url'; end

#     Dir.mktmpdir("#{event.server.id}-yt") do |dir|
#       result = `youtube-dl #{YOUTUBE_DL_OPTIONS} -o \"#{dir}/%(title)s.%(ext)s\" #{url}`
#       title = `youtube-dl --get-filename -o \"%(title)s\" #{url}`.chomp
      
#       return 'There was an issue downloading this song' unless title


#       event.send_embed do |embed|
#         embed.title = 'YouTube'
#         embed.description = title
#       end

#       10.times { sleep 1 unless File.exist? "#{dir}/#{title}.ogg" }

#       voice_bot.play_file("#{dir}/#{title}.ogg")
#     end

#     voice_bot.destroy
#     nil    
#   end

#   command :yt_stop do |event|
#     voice = event.bot.voice(event.server)
    
#     return 'Nothing is playing' unless voice
    
#     voice.stop_playing
#     voice.destroy
    
#     nil
#   end
# end

bot.command(:somebody) do |event|
  event.respond "<https://youtu.be/L_jWHffIx5E?t=36>"
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