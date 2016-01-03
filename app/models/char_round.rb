class CharRound < ActiveRecord::Base
  belongs_to :character
  belongs_to :round
  has_many :pledges, dependent: :destroy

  validates_presence_of :character, :round
  accepts_nested_attributes_for :pledges, reject_if: :all_blank, allow_destroy: true
end
