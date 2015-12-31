class FinalCharacter < ActiveRecord::Base
  belongs_to :character_system
  belongs_to :user
  has_many :ranks, dependent: :destroy
  #has_many :tools, dependent: :destroy
  #has_many :regencies, dependent: :destroy
  belongs_to :flaw1, :class_name => 'Flaw', :foreign_key => 'flaw1_id'
  belongs_to :flaw2, :class_name => 'Flaw', :foreign_key => 'flaw2_id'

  enum approval: [:not_submitted, :submitted, :rejected, :approved]

  validates_presence_of :character_system, :user, :approval
  validates_numericality_of :luck, :less_than_or_equal_to => 10, :greater_than_or_equal_to => -10, :only_integer => true

  accepts_nested_attributes_for :ranks, reject_if: :all_blank, allow_destroy: false
end
