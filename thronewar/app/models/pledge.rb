class Pledge < ActiveRecord::Base
  belongs_to :character
  belongs_to :char_round
  belongs_to :item

  validates_presence_of :rank, :value
  validates_presence_of :character, :char_round, :item
end
