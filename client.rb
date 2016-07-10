#!/usr/bin/env ruby
# Ably messaging test
require 'ably'

puts 'Ably client'
puts 'Enter your name'
user = gets.chomp
unless user.empty?
  client = Ably::Rest.new(key: ENV['ABLY_KEY'])
  channel = client.channel('ruby_test')
  loop do
    puts 'Enter a message'
    message = gets.chomp
    break if message.empty?
    channel.publish(user, message)
  end
end
