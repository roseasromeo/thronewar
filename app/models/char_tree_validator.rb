class CharTreeValidator < ActiveModel::Validator
  include Rules

  def validate(tree)
    valid = true

    final_character = tree.final_character

    if final_character.submitting?
      ranks = final_character.ranks
      abilities_collection = tree.abilities_all(false)
      abilities = tree.abilities

      # First, check for unavailable abilities added to character
      abilities.each do |ability|
        if abilities_collection.where(id: ability.id).empty?
          valid = false
          tree.errors[:abilities] << "The ability tree for this character includes an ability they do not have access to and has now been deleted."
        end
      end

      # Second, check number of abilities
      gifts = [ :command, :change, :illusion, :gutter_magic ]
      levels = [:basic, :intermediate, :advanced]
      count_hash = ability_count_hash(final_character)
      gifts.each do |gift|
        levels.each do |level|
          if abilities.where(gift: gift, level: level, automatic: false).count > count_hash[gift][level].to_i
            valid = false
            tree.errors[:abilities] << "The ability tree for this character includes too many #{level} abilities for #{gift.to_s.humanize.titlecase}."
          end
        end
      end

      # Third, check ability dependencies
      abilities.each do |ability|
        dependencies = ability.dependencies
        dependencies.each do |dependency|
          puts dependency.name
          if abilities.where(id: dependency.id).empty?
            valid = false
            tree.errors[:abilities] << "The ability tree for this character does not include all dependencies for #{ability.name}."
          end
        end
      end
    end
    valid
  end
end
