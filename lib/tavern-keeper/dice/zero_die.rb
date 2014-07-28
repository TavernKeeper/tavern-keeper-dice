module TavernKeeper::Dice
  class ZeroDie < Die
    def roll_die
      values = []
      again = true
      quantity.times do
        dice_roll =  random(0, sides.to_i - 1)
        values <<  dice_roll
        again = dice_roll == (sides.to_i - 1) && explode
      end
      {
        type: "D#{sides}",
        values: values,
        total: total
      }
    end
  end
end
