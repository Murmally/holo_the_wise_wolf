require 'discordrb'
require 'logger'

module Bot
  @@bot = Discordrb::Commands::CommandBot.new token: File.read("./token.txt"), prefix: 'h!'

  def bot; @@bot; end

  @@log = Logger.new(File.open('log.txt', File::WRONLY | File::APPEND), formatter: proc{
  	|severity, datetime, progname, msg| "#{severity} #{datetime} || #{msg}\n"
  })

  def log; @@log; end

  @@personal_log = Logger.new(File.open('holo_mentions.txt', File::WRONLY | File::APPEND), formatter: proc{
  	|severity, datetime, progname, msg| "#{datetime} || #{msg}\n"})

  def personal_log; @@personal_log; end
end