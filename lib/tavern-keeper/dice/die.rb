module TavernKeeper::Dice
  class Die
    attr_accessor :quantity, :sides, :total, :explode, :keep, :bonus, :negative
    def initialize(params)
      self.negative = params.starts_with?('-')
      params = params.sub('-', '') if self.negative
      params = params.upcase.split('D', 2)
      self.quantity = params.first.empty? ? 1 : params.first.to_i
      self.sides = params.last
      self.explode = self.sides.include?('!')
      self.sides = self.sides.gsub('!', '')


      self.keep = self.quantity
      if self.sides.include?('K')
        value = self.sides.match(/K[1234567890]+/).to_a.first
        self.sides = self.sides.sub(value, '')
        self.keep = value.sub('K', '').to_i
      elsif self.sides.include?('D')
        value = self.sides.match(/D[1234567890]+/).to_a.first
        self.sides = self.sides.sub(value, '')
        self.keep = self.keep - value.sub('D', '').to_i
      end


      self.bonus = self.sides.match(/[+-][+-1234567890]+/).to_a.first
      self.sides = self.sides.sub(self.bonus, '') if self.bonus
      self.bonus = self.bonus ? eval("0#{self.bonus}") : 0
      self.total = 0
    end

    def roll
      temp = roll_die

      if quantity != keep
        rolls = temp[:values]
        rolls = rolls.sort.reverse
        # puts rolls.join(',')

        rolls.drop(keep).each do |value|
          index = temp[:values].index(value)
          temp[:values].delete_at(index)
        end
      end





      temp[:total] = update_total(temp[:values])


      temp
    end

    def drop
      quantity - keep
    end

    private
    def update_total(values = [])
      self.total = self.bonus

      values.each do |value|
        self.total = self.total + value
      end

      self.total = self.total * -1 if self.negative

      self.total
    end

    def roll_die
      {
        type: 'D0',
        values: [],
        total: 0
      }
    end

    def random(min, max)
      distance = (min..max).count
      mod = 0 - min
      value = SecureRandom.random_number(distance)
      value - mod
    end
  end
end
