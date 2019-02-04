module FactoryBotHelpers
  extend self

  def random_values_rfc
    "#{random_letter}#{random_number(99)}#{random_number(12)}#{random_number(27)}A#{random_letter}A"
  end

  private

  def random_letter
    ('A'..'Z').to_a.sample
  end

  def random_number max
    '%02d'%(1..max).to_a.sample
  end
end
