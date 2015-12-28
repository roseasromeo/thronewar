class FinalCharacter < ActiveRecord::Base
  belongs_to :character_system
  belongs_to :user
  has_many :start_ranks
  has_many :final_ranks
  has_many :tools
  has_many :regencies
  belongs_to :flaw1, :class_name => 'Flaw', :foreign_key => 'flaw1_id'
  belongs_to :flaw2, :class_name => 'Flaw', :foreign_key => 'flaw2_id'

  enum approval: [:not_submitted, :submitted, :rejected, :approved]

  validates_presence_of :character_system, :user, :approval
  validates_numericality_of :luck, :less_than_or_equal_to => 10, :greater_than_or_equal_to => -10, :only_integer => true

end
