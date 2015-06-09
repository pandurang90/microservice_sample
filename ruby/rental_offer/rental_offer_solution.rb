#!/usr/bin/env ruby
# encoding: utf-8

# Docker run command:
#   docker run --name='need' -it -v /c/Users/fred/src/microservice_workshop/ruby:/workshop -w /workshop/rental_offer fredgeorge/ruby_microservice bash
# To run monitor at prompt:
#   ruby rental_car_need.rb 192.168.59.103 bugs

require_relative 'rental_offer_need_packet'
require_relative 'connection'

# Expresses a need for rental car offers
class RentalOfferSolution

  def initialize(host, bus_name,need)
    @host = host
    @bus_name = bus_name
    @need = need
  end

  def start
    Connection.with_open(@host, @bus_name) {|ch, ex| publish_solution(ch, ex)}
  end

  private

  def publish_solution(channel, exchange)
    exchange.publish RentalOfferNeedPacket.new.to_json(@need)
    puts " [x] Published a rental offer solution on the #{@bus_name} bus"
  end

end

RentalOfferSolution.new(ARGV.shift, ARGV.shift,ARGV.shift).start
