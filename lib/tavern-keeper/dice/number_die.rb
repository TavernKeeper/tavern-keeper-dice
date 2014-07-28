module TavernKeeper::Dice
  class NumberDie < Die
    def roll_die
      values = []

      quantity.times do
        again = true
        while again
          dice_roll = random(1, sides.to_i)
          values <<  dice_roll
          again = dice_roll == sides.to_i && explode
        end
      end
      {
        type: "D#{sides}",
        values: values,
        total: total
      }
    end
  end
end
