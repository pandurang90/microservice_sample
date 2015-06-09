#!/usr/bin/env ruby
# encoding: utf-8

require_relative 'connection'
require 'json'

# Expresses a need for rental car offers
class Solution1

  NEED_SOLUTION = {'car_rental_offer' => 'YoYo',
                   'y' => 'HoneySingh',
                   'z' => 'Hurrey!'}

  def initialize(host, bus_name)
    @host = host
    @bus_name = bus_name
  end

  def get_solution(need)
    NEED_SOLUTION[need] rescue 'unknown need'
  end

  def start
    Connection.with_open(@host, @bus_name) {|ch, ex| publish_need(ch, ex)}
  end

  private

  def publish_need(channel, exchange)
    q = channel.queue('', exclusive: true)
    q.bind exchange

    q.subscribe(block: true) do |delivery_info, properties, body|
      body = JSON.parse(body)

      if !body['solutions'].nil?
        need = body['need']
        body['solutions'] = get_solution(need)

        exchange.publish body
        puts " [x] Published a solution #{body['solutions']} on the #{@bus_name} bus, CTRL + C To close."
      end

    end

  end

end

Solution1.new(ARGV.shift, ARGV.shift).start
