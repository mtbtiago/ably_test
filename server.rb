#!/usr/bin/env ruby
# Ably messaging test
require 'ably'

puts 'Ably server'
EventMachine.run do
  client = Ably::Realtime.new(key: ENV['ABLY_KEY'])

  client.connection.connect do
    puts 'Connected!'
  end

  # connection_result = client.connection.connect
  # connection_result.errback = proc do
  #   puts 'failed connection'
  # end

  client.connection.on do |state_change|
    puts state_change.current #=> :connected
    puts state_change.previous #=> :connecting
  end

  channel = client.channels.get('ruby_test')

  channel.subscribe do |message|
    puts '=' * 80
    puts "Received message from #{message.name}: #{message.data}"
    # puts message.name #=> "greeting"
    # puts message.data #=> "Hello World!"
    puts '=' * 80
  end

  # channel.publish('greeting', 'Hello World!')
end
