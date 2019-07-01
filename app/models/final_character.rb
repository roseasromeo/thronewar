class FinalCharacter < ApplicationRecord
  belongs_to :character_system
  belongs_to :user
  has_many :ranks, dependent: :destroy
  has_many :tools, dependent: :destroy
  has_many :regencies, dependent: :destroy
  has_one :char_tree, dependent: :destroy
  has_many :creature_forms
  belongs_to :flaw1, :class_name => 'Flaw', foreign_key: 'flaw1', optional: true
  belongs_to :flaw2, :class_name => 'Flaw', foreign_key: 'flaw2', optional: true

  before_save :calculate_points
  after_save :calculate_points

  enum approval: [:not_submitted, :submitting, :submitted, :rejected, :approved]

  validates_presence_of :character_system, :user, :approval
  validates_numericality_of :luck, :less_than_or_equal_to => 10, :greater_than_or_equal_to => -10, :only_integer => true
  validates_numericality_of :extra_wishes, :greater_than_or_equal_to => 0, :only_integer => true

  accepts_nested_attributes_for :ranks, reject_if: :all_blank, allow_destroy: false

  def asset_points
    #Tools
    tool_total = 0
    self.tools.each do |tool|
      tool_total = tool_total + tool.points
    end

    #Regencies
    regency_total = 0
    self.regencies.each do |regency|
      regency_total = regency_total + regency.points
    end

    # Sum assets
    asset_total = tool_total + regency_total
  end

  private
    def calculate_points
      point_total = 0

      #Ranks
      rank_total = 0
      self.ranks.each do |rank|
        rank_total = rank_total + rank.private_points
      end

      # Sum assets
      asset_total = asset_points
      #Check if has flaw Primal Magic
      no_primal_magic = true
      if self.flaw1 != nil && self.flaw1.name == "Primal Magic"
        no_primal_magic = false
      end
      if self.flaw2 != nil && self.flaw2.name == "Primal Magic"
        no_primal_magic = false
      end
      # Subtract 10 free Asset points
      if no_primal_magic
        if asset_total >= 10
          asset_total = asset_total - 10
        else
          asset_total = 0
        end
      end

      #Luck
      luck_total = self.luck

      #flaws
      flaw_total = 0
      if self.flaw1 != nil
        flaw_total = flaw_total - 5
      end
      if self.flaw2 != nil
        flaw_total = flaw_total - 5
      end

      # Extra Wishes
      wish_total = self.extra_wishes == nil ? 0 : self.extra_wishes

      point_total = rank_total + asset_total + luck_total + flaw_total + wish_total

      leftover_points = 100 - point_total
      if leftover_points != self.leftover_points
        self.update_attributes(leftover_points: leftover_points)
      end
      true
    end

end
