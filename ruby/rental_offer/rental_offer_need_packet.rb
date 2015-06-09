require 'json'

# Understands solutions to a need for a rental car offer
class RentalOfferNeedPacket
  

  NEED = 'car_rental_offer'

  def initialize
    @solutions = nil
  end

  def to_json(*args)
    {
      'json_class' => self.class.name,
      'need' => NEED,
      'solutions' => @solutions,
      'user_id' => args[0]
    }.to_json
  end

  def propose_solution(solution)
    @solutions << solution
  end

end
