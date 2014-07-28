module TavernKeeper::Dice
  class FudgeDie < Die
    def roll_die
      values = []
      quantity.times do
        values << random(-1, 1)
      end
      {
        type: "DF",
        values: values,
        total: total
      }
    end
  end
end
