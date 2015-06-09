#!/usr/bin/env ruby
# encoding: utf-8

# Docker run command:
#   docker run --name='need' -it -v /c/Users/fred/src/microservice_workshop/ruby:/workshop -w /workshop/rental_offer fredgeorge/ruby_microservice bash
# To run monitor at prompt:
#   ruby rental_car_need.rb 192.168.59.103 bugs

require_relative 'rental_offer_need_packet'
require_relative 'connection'

# Expresses a need for rental car offers
class RentalOfferNeed
  IDS = (1..10).to_a

  def initialize(host, bus_name)
    @host = host
    @bus_name = bus_name
  end

  def start
    while true
      Connection.with_open(@host, @bus_name) {|ch, ex| publish_need(ch, ex)}
      sleep 10  
    end
  end

  private

  def publish_need(channel, exchange)
    exchange.publish RentalOfferNeedPacket.new.to_json(IDS.sample)
    puts " [x] Published a rental offer need on the #{@bus_name} bus"
  end

end

RentalOfferNeed.new("10.5.10.151", "goofy").start
