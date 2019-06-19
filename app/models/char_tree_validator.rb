class CharTreeValidator < ActiveModel::Validator
  include Rules

  def validate(tree)
    valid = true

    final_character = tree.final_character
    ranks = final_character.ranks
    abilities_collection = tree.abilities_collection(false)
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
    gifts.each do |gift|
      private_rank = ranks.where(item: Rank.items[gift]).first.private_rank
      lowest_rank = final_character.character_system.ranks.where(item: Rank.items[gift]).maximum(:public_rank)
      basic_num = basic_abilities(private_rank, lowest_rank)
      int_num = int_abilities(private_rank, lowest_rank)
      adv_num = adv_abilities(private_rank, lowest_rank)

      if abilities.where(gift: gift, level: :low, automatic: false).count > basic_num
        valid = false
        #tree.abilities.delete(ability_num)
        tree.errors[:abilities] << "The ability tree for this character includes too many basic abilities for #{gift}."
      end
      if abilities.where(gift: gift, level: :med, automatic: false).count > int_num
        valid = false
        #tree.abilities.delete(ability_num)
        tree.errors[:abilities] << "The ability tree for this character includes too many intermediate abilities for #{gift}."
      end
      if abilities.where(gift: gift, level: :high, automatic: false).count > adv_num
        valid = false
        #tree.abilities.delete(ability_num)
        tree.errors[:abilities] << "The ability tree for this character includes too many advanced abilities for #{gift}."
      end
    end

    # Third, check ability dependencies
    abilities.each do |ability|
      dependencies = ability.dependencies
      dependencies.each do |dependency|
        if abilities.where(id: dependency.id).empty?
          valid = false
          tree.errors[:abilities] << "The ability tree for this character does not include all dependencies for #{ability.name}"
        end
      end
    end

    valid
  end
end
