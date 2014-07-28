module TavernKeeper::Dice
  class Number < Die
    def initialize(params)
      self.total = params.to_i
    end

    def roll
      roll_die
    end

    private
    def roll_die
      {
        type: 'Number',
        values: [self.total],
        total: self.total
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
