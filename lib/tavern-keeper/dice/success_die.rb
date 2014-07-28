module TavernKeeper::Dice
  class SuccessDie < NumberDie
    attr_accessor :target, :mode, :modifier

    def initialize(params)
      super(params)
      self.mode = sides.include?('>') ? '>' : '<'
      self.target = sides.split(self.mode).last.to_i
      self.sides = sides.split(self.mode).first.to_i
      self.modifier = self.total
      self.total = 0
    end


    private
    def update_total(values = [])
      self.total = 0

      values.each do |value|
        self.total += 1 if success?(value)
      end

      self.total
    end

    def success?(value)
      if mode == '>'
        value > target
      else
        value < target
      end
    end
  end
end
