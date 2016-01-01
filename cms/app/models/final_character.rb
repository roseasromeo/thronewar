class FinalCharacter < ActiveRecord::Base
  belongs_to :character_system
  belongs_to :user
  has_many :ranks, dependent: :destroy
  has_many :tools, dependent: :destroy
  has_many :regencies, dependent: :destroy
  belongs_to :flaw1, :class_name => 'Flaw'
  belongs_to :flaw2, :class_name => 'Flaw'

  after_save :calculate_points

  enum approval: [:not_submitted, :submitted, :rejected, :approved]

  validates_presence_of :character_system, :user, :approval
  validates_numericality_of :luck, :less_than_or_equal_to => 10, :greater_than_or_equal_to => -10, :only_integer => true

  accepts_nested_attributes_for :ranks, reject_if: :all_blank, allow_destroy: false

  private
    def calculate_points
      puts "calculation"
      point_total = 0

      #Ranks
      rank_total = 0
      self.ranks.each do |rank|
        rank_total = rank_total + rank.private_points
      end

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
      # Subtract 10 free Asset points
      if asset_total >= 10 # will need flaw condition
        asset_total = asset_total - 10
      else # will need flaw condition
        asset_total = 0
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

      point_total = rank_total + asset_total + luck_total +flaw_total

      leftover_points = 100 - point_total
      if leftover_points != self.leftover_points
        self.update_attributes(leftover_points: leftover_points)
      end
      true
    end
end
