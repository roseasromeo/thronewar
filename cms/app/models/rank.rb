class Rank < ActiveRecord::Base
  belongs_to :final_character
  before_save :set_half, :set_private_points

  enum item: [ :battle, :cunning, :destiny, :ego, :flesh, :command, :change, :illusion, :gutter_magic ]

  validates_presence_of :final_character, :item
  validates :half, :inclusion => { :in => [true, false] }

  def aspect?
    if self.item == :battle || self.item == :cunning || self.item == :destiny || self.item == :ego || self.item == :flesh
      aspect = true
    else
      aspect = false
    end
    aspect
  end

  private
    def set_half
      if private_rank != public_rank
        self.half = true
      else
        self.half = false
      end
      true
    end

    def set_private_points
      new_rank = final_character.character_system.ranks.where(item: Rank.items[item], public_rank: private_rank).first
      self.private_points = new_rank.public_points
    end

end
