# Copyright 2014 by Fred George. May be copied with this notice, but not used in training.

require 'json'

class Packet

  def initialize(json_hash)
    @json_hash = json_hash
    @visit_count = (@json_hash['visit_count'] || 0) + 1
    @used_keys = ['visit_count']
  end

  def used_key(key)
    @used_keys << key
  end

  def to_json
    @used_keys.each { |key| @json_hash[key] = instance_variable_get("@#{key}".to_sym) }
    @json_hash.to_json
  end

end


# Understands valid JSON micros-service messages
# Implements the GoF Builder design pattern
class PacketBuilder

  def initialize(json_string = '{}')
    @json_hash = JSON.parse json_string
    @used_keys = []
    @problems = []
    @packet = Packet.new(@json_hash)
  end

  def require(*keys)
    keys.each do |key|
      validate_required(key)
      create_accessors(key)
    end
    self
  end

  def forbid(*keys)
    keys.each do |key|
      validate_missing(key)
      create_accessors(key)
    end
    self
  end

  def interested_in(*keys)
    keys.each { |key| create_accessors(key) }
    self
  end

  def valid?
    @problems.empty?
  end

  def result
    raise "Problems with the packet:\n#{@problems}" unless @problems.empty?
    @packet
  end

  private

    def validate_required(key)
      return @problems << "Missing required key #{key}" unless @json_hash[key]
      return @problems << "Empty required key #{key}" if @json_hash[key].empty?
    end

    def validate_missing(key)
      return unless @json_hash.key? key
      return if @json_hash[key].empty?
      @problems << "Forbidden key #{key} detected"
    end

    def create_accessors(key)
      @packet.used_key key
      establish_variable key, @json_hash[key]
      define_getter key
      define_setter key
    end

    def establish_variable(key, value = nil)
      @packet.instance_variable_set variable(key), value
    end

    def define_getter(key)
      variable = variable(key)
      @packet.define_singleton_method(key.to_sym) do
        instance_variable_get variable
      end
    end

    def define_setter(key)
      variable = variable(key)
      @packet.define_singleton_method((key + '=').to_sym) do |new_value|
        instance_variable_set variable, new_value
      end
    end

    def variable(key)
      ('@' + key.to_s).to_sym
    end

end
