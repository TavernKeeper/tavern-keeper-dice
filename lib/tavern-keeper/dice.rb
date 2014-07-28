require "tavern-keeper/dice/version"
require "tavern-keeper/dice/die"
require "tavern-keeper/dice/fudge_die"
require "tavern-keeper/dice/number"
require "tavern-keeper/dice/number_die"
require "tavern-keeper/dice/success_die"
require "tavern-keeper/dice/zero_die"

module TavernKeeper
  module Dice
    def self.roll(roll_string)
    rolls = []
    roll_string.split(',').each do |roll|
      label = roll.include?(':') ? roll.split(':').first : ''
      value = roll.split(':').last.upcase.scan(/[1234567890+-DFZKP!,\}\{]/).join('')
      key = value
      index = 0
      total = 0

      roll_data = []
      value.gsub('-', "+-").split('+').each do |match|
        # puts match
        die = case
        when match.include?('D') && match.include?('F')
          ::TavernKeeper::Dice::FudgeDie.new(match)
        when match.include?('D') && match.include?('Z')
          ::TavernKeeper::Dice::ZeroDie.new(match)
        when match.include?('D') && (match.include?('<') || match.include?('>'))
          ::TavernKeeper::Dice::SuccessDie.new(match)
        when match.include?('D')
          ::TavernKeeper::Dice::NumberDie.new(match)
        else
          ::TavernKeeper::Dice::Number.new(match)
        end

        if die.negative
          key = key.sub(match, "-|#{index}|")
        else
          key = key.sub(match, "|#{index}|") if match.include?('D')
        end
        roll_data << die.roll
        index += 1
        total += roll_data.last[:total]
      end

      rolls<< {
        data: roll_data,
        roll: value,
        key: key,
        total: total,
        label: label.strip
      }
    end
    {rolls: rolls}
  end
  end
end
