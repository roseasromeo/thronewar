module Rules

  def aspect_level(private_rank,lowest_rank)
    low_count = 0
    med_count = 0
    high_count = 0
    if lowest_rank == 1
      med_count = 1
    elsif lowest_rank == 2
      med_count = 1
      low_count = 1
    else
      counter = lowest_rank
      while counter > 0
        if counter % 3 == 1
          low_count = low_count + 1
        elsif counter % 3 == 2
          med_count = med_count + 1
        else
          high_count = high_count + 1
        end
        counter = counter - 1
      end
    end
    if private_rank == 0
      level = :no
    elsif private_rank <= high_count
      level = :high
    elsif private_rank <= (high_count + med_count)
      level = :med
    else
      level = :low
    end
    level
  end

  def healing_rest(level)
    if level == :high
      wounds = 9
    elsif level == :med
      wounds = 7
    elsif level == :low
      wounds = 5
    else
      wounds = 3
    end
    wounds
  end

  def combined_rest(level)
    if level == :high
      wounds = 7
    elsif level == :med
      wounds = 5
    elsif level == :low
      wounds = 3
    else
      wounds = 0
    end
    wounds
  end

  def shifting_time(level)
    if level == :high
      rounds = 1
    elsif level == :med
      rounds = 2
    elsif level == :low
      rounds = 3
    else
      rounds = 5
    end
    rounds
  end

  def ready_tool(level)
    if level == :high
      tools = 3
    elsif level == :med
      tools = 2
    elsif level == :low
      tools = 1
    else
      tools = 0
    end
    tools
  end

  def ready_eff_range(level)
    if level == :high
      eff_range = 30
    elsif level == :med
      eff_range = 20
    elsif level == :low
      eff_range = 12
    else
      eff_range = 6
    end
    eff_range
  end

  def ready_max_range(level)
    if level == :high
      max_range = :region
    elsif level == :med
      max_range = 30
    elsif level == :low
      max_range = 20
    else
      max_range = 12
    end
    max_range
  end

  def planning_targets(level)
    if level == :high
      targets = 3
    elsif level == :med
      targets = 2
    elsif level == :low
      targets = 1
    else
      targets = 0
    end
    targets
  end

  def fate(private_rank, lowest_rank, fate_flaw)
    fate_tokens = 5
    if private_rank > 0
      fate_tokens = fate_tokens + 1 + lowest_rank - private_rank
    end
    if fate_flaw
      fate_tokens = fate_tokens - 2
    end
    fate_tokens
  end

  def fate_flaw?(final_character)
    flaw = false
    if final_character.flaw1 != nil && final_character.flaw1.name == "All the World's a Stage"
      flaw = true
    end
    if final_character.flaw2 != nil && final_character.flaw2.name == "All the World's a Stage"
      puts "we found the stage flaw"
      flaw = true
    end
    flaw
  end

  def flesh_forms(private_rank, lowest_rank, form_flaw)
    forms = 1
    if private_rank > 0
      forms = forms + 1 + lowest_rank - private_rank
    end
    if forms
      forms = forms - 1
    end
    forms
  end

  def talent(private_rank, lowest_rank)
    one_count = 0
    two_count = 0
    three_count = 0
    four_count = 0
    five_count = 0
    if lowest_rank == 1
      three_count = 1
    elsif lowest_rank == 2
      three_count = 1
      two_count = 1
    elsif lowest_rank == 3
      four_count = 1
      three_count = 1
      two_count = 1
    else
      counter = lowest_rank
      while counter > 0
        if counter % 5 == 1
          one_count = one_count + 1
        elsif counter % 5 == 2
          two_count = two_count + 1
        elsif counter % 5 == 3
          three_count = three_count + 1
        elsif counter % 5 == 4
          four_count = four_count + 1
        else
          five_count = five_count + 1
        end
        counter = counter - 1
      end
    end
    if private_rank == 0
      talent = 0
    elsif private_rank <= five_count
      talent = 5
    elsif private_rank <= (five_count + four_count)
      talent = 4
    elsif private_rank <= (five_count + four_count + three_count)
      talent = 3
    elsif private_rank <= (five_count + four_count + three_count + two_count)
      talent = 2
    else
      talent = 1
    end
    talent
  end

  def basic_abilities(private_rank, lowest_rank)
    if lowest_rank <= 5
      basic_count = 3
    elsif lowest_rank <= 8
      if private_rank < lowest_rank
        basic_count = 3
      else
        basic_count = 2
      end
    else
      # lowest_rank > 9
      if private_rank >= 9
        basic_count = 1
      elsif private_rank == 8
        basic_count = 2
      else
        basic_count = 3
      end
    end
    if private_rank == 0
      basic_count = 0
    end
    basic_count
  end

  def int_abilities(private_rank, lowest_rank)
    if lowest_rank == 1
      int_count = 3
    elsif lowest_rank <= 3
      if private_rank < lowest_rank
        int_count = 3
      else
        int_count = 0
      end
    elsif lowest_rank == 4
      if private_rank <= 2
        int_count = 3
      elsif private_rank == 3
        int_count = 1
      else
        int_count = 0
      end
    elsif lowest_rank <=6
      if private_rank <= 3
        int_count = 3
      elsif private_rank == 4
        int_count = 1
      else
        int_count = 0
      end
    elsif lowest_rank == 7
      if private_rank <= 3
        int_count = 3
      elsif private_rank == 4
        int_count = 2
      elsif private_rank == 5
        int_count = 1
      else
        int_count = 0
      end
    else
      if private_rank <= 4
        int_count = 3
      elsif private_rank == 5
        int_count = 2
      elsif private_rank == 6
        int_count = 1
      else
        int_count = 0
      end
    end
    if private_rank == 0
      int_count = 0
    end
    int_count
  end

  def adv_abilities(private_rank, lowest_rank)
    if lowest_rank <= 2
      adv_count = 0
    elsif lowest_rank <= 4
      if private_rank == 1
        adv_count = 3
      else
        adv_count = 0
      end
    elsif lowest_rank <= 7
      if private_rank == 1
        adv_count = 3
      elsif private_rank == 2
        adv_count = 1
      else
        adv_count = 0
      end
    else
      if private_rank == 1
        adv_count = 3
      elsif private_rank == 2
        adv_count = 2
      elsif private_rank == 3
        adv_count = 1
      else
        adv_count = 0
      end
    end
    if private_rank == 0
      adv_count = 0
    end
    adv_count
  end

  def gift_level(private_rank,lowest_rank)
    if adv_abilities(private_rank, lowest_rank) > 0
      level = :high
    elsif int_abilities(private_rank, lowest_rank) > 0
      level = :med
    elsif basic_abilities(private_rank, lowest_rank) > 0
      level = :low
    else
      level = :no
    end
  end

  def approval(final_character)
    # Overspending
    notices = []
    if final_character.leftover_points < 0
      notices << "Purchases have exceeded maximum point expenditure. Please add Flaws, decrease Luck, decrease buy-ups, or remove other purchases."
    end
    if final_character.asset_points > 32
      notices << "Tool and Regency purchases have exceeded the 32 point maximum allowed."
    end

    # Buying up too much
    ego_rank = final_character.ranks.where(item: Rank.items[:ego]).first.private_rank
    lowest_rank = final_character.character_system.ranks.where(item: Rank.items[:ego]).maximum(:public_rank)
    talent_num = talent(ego_rank, lowest_rank)
    buy_up_total = 0
    final_character.ranks.each do |rank|
      buy_up_total = buy_up_total + (rank.public_rank - rank.private_rank)
    end
    if buy_up_total > talent_num
      notices << "Too many buy-ups for current Ego Talent. Please decrease number of ranks purchased."
    end

    # Invalid Tools
    if !final_character.tools.empty?
      final_character.tools.each do |tool|
        if !tool.save
          notices << "Tool #{tool.name} is invalid. Please check that the requirements for all abilities are met."
        end
      end
    end

    # Invalid Regencies
    if !final_character.regencies.empty?
      final_character.regencies.each do |regency|
        if !regency.save
          notices << "Regency #{regency.name} is invalid. Please check that the requirements for all abilities are met."
        end
      end
    end

    # check for blanks
    if check_blank(final_character.blurb)
      notices << "Blurb must be completed before submission."
    end
    if check_blank(final_character.background)
      notices << "Background must be completed before submission."
    end
    if check_blank(final_character.backstory_connections)
      notices << "Backstory Connections must be completed before submission."
    end
    if check_blank(final_character.name)
      notices << "Name must be completed before submission."
    end
    if check_blank(final_character.goal)
      notices << "Goal must be completed before submission."
    end
    if check_blank(final_character.curses)
      notices << "Curses must be completed before submission."
    end
    if check_blank(final_character.standard_form)
      notices << "Standard Form must be completed before submission."
    end

    # Check if need wishes
    gutter_rank = final_character.ranks.where(item: Rank.items[:gutter_magic]).first
    if gutter_rank.private_rank > 0
      gutter_magic = true
    else
      gutter_magic = false
    end
    if gutter_magic
      if check_blank(final_character.wishes)
        notices << "Wishes must be completed before submission."
      end
    end

    #check if flaws same
    if final_character.flaw1 != nil && (final_character.flaw1 == final_character.flaw2)
      notices << "Both flaws must not be the same."
    end
    notices
  end

  def check_blank(text)
    blank = false
    if text == nil || text == ""
      blank = true
    end
    blank
  end

  def font?(final_character)
    #This is not right--need to check for font ability
    ranks = final_character.ranks
    font = false
    if ranks.where(item: Rank.items[:gutter_magic]).first.private_rank > 0
      font = true
    end
    font
  end

  def tool_abilities_collection(final_character,all_abilities)
    ranks = final_character.ranks
    collection = []
    i = 0
    # Command basic abilities
    collection << ["Command Basic (1pt): Rational", i]
    i = i + 1
    collection << ["Command Basic (1pt): Armor", i]
    i = i + 1
    collection << ["Command Basic (1pt): Heroic", i]
    i = i + 1
    # Change basic abilities
    collection << ["Change Basic (1pt): Threatening", i]
    i = i + 1
    collection << ["Change Basic (1pt): Light-footed", i]
    i = i + 1
    collection << ["Change Basic (1pt): Sharp", i]
    i = i + 1
    # Illusion basic abilities
    collection << ["Illusion Basic (1pt): Inconspicuous", i]
    i = i + 1
    collection << ["Illusion Basic (1pt): Wisp", i]
    i = i + 1
    collection << ["Illusion Basic (1pt): Hidden", i]
    i = i + 1
    # Gutter Magic basic abilities
    if font?(final_character) || all_abilities
      collection << ["Gutter Magic Basic (1pt): Wand", i]
    end
    i = i + 1
    if font?(final_character) || all_abilities
      collection << ["Gutter Magic Basic (1pt): Dowsing", i]
    end
    i = i + 1
    if font?(final_character) || all_abilities
      collection << ["Gutter Magic Basic (1pt): Independent", i]
    end
    i = i + 1
    # Command intermediate abilities
    collection << ["Command Intermediate (2pt): Guard", i]
    i = i + 1
    collection << ["Command Intermediate (2pt): Analytic", i]
    i = i + 1
    # Change intermediate abilities
    collection << ["Change Intermediate (2pt): Precision", i]
    i = i + 1
    collection << ["Change Intermediate (2pt): Coercive", i]
    i = i + 1
    # Illusion intermediate abilities
    collection << ["Illusion Intermediate (2pt): Masked", i]
    i = i + 1
    collection << ["Illusion Intermediate (2pt): Telepathic", i]
    i = i + 1
    # Gutter Magic intermediate abilities
    if font?(final_character) || all_abilities
      collection << ["Gutter Magic Intermediate (2pt): Intuition", i]
    end
    i = i + 1
    if font?(final_character) || all_abilities
      collection << ["Gutter Magic Intermediate (2pt): Collar", i]
    end
    i = i + 1

    # Command advanced ability
    if ranks.where(item: Rank.items[:command]).first.private_rank > 0 || all_abilities
      collection << ["Command Advanced (3pt): Real", i]
    end
    i = i + 1
    # Change advanced ability
    if ranks.where(item: Rank.items[:change]).first.private_rank > 0 || all_abilities
      collection << ["Change Advanced (3pt): Alternate Form", i]
    end
    i = i + 1
    # Illusion advanced ability
    if ranks.where(item: Rank.items[:illusion]).first.private_rank > 0 || all_abilities
      collection << ["Illusion Advanced (3pt): Improved Wisp", i]
    end
    i = i + 1

    collection
  end

  # Ability Numbers
  def improved_wisp_num
    23
  end
  def collar_num
    19
  end
  def wisp_num
    7
  end

  def regency_abilities_collection
    collection = []
    i = 0
    # Basic abilities
    collection << ["Basic (1pt): Physical Walls", i]
    i = i + 1
    collection << ["Basic (1pt): Adherent", i]
    i = i + 1
    collection << ["Basic (1pt): Luxurious", i]
    i = i + 1
    # Intermediate abilities
    collection << ["Intermediate (2pt): Environment", i]
    i = i + 1
    collection << ["Intermediate (2pt): Metaphysical Walls", i]
    i = i + 1
    # Advanced abilities
    collection << ["Advanced (3pt): Keeper", i]
    i = i + 1
    collection << ["Advanced (3pt): Puzzle", i]
    i = i + 1
    collection << ["Advanced (3pt): Walking", i]
    i = i + 1

    collection
  end

  def keeper_abilities_collection
    collection = []
    i = 0
    # Command basic abilities
    collection << ["Command Basic (1pt): Rational", i]
    i = i + 1
    collection << ["Command Basic (1pt): Armor", i]
    i = i + 1
    collection << ["Command Basic (1pt): Heroic", i]
    i = i + 1
    # Change basic abilities
    collection << ["Change Basic (1pt): Threatening", i]
    i = i + 1
    collection << ["Change Basic (1pt): Light-footed", i]
    i = i + 1
    collection << ["Change Basic (1pt): Sharp", i]
    i = i + 1
    # Illusion basic abilities
    collection << ["Illusion Basic (1pt): Inconspicuous", i]
    i = i + 1
    collection << ["Illusion Basic (1pt): Wisp", i]
    i = i + 1
    collection << ["Illusion Basic (1pt): Hidden", i]
    i = i + 1

    # Command intermediate abilities
    collection << ["Command Intermediate (2pt): Guard", i]
    i = i + 1
    collection << ["Command Intermediate (2pt): Analytic", i]
    i = i + 1
    # Change intermediate abilities
    collection << ["Change Intermediate (2pt): Precision", i]
    i = i + 1
    collection << ["Change Intermediate (2pt): Coercive", i]
    i = i + 1
    # Illusion intermediate abilities
    collection << ["Illusion Intermediate (2pt): Masked", i]
    i = i + 1
    collection << ["Illusion Intermediate (2pt): Telepathic", i]
    i = i + 1

    collection
  end

  def gift_abilities_collection(final_character,all_abilities,abilities)
    ranks = final_character.ranks
    gifts = [ :command, :change, :illusion, :gutter_magic ]
    collection = Ability.none
    gifts.each do |gift|
      private_rank = ranks.where(item: Rank.items[gift]).first.private_rank
      lowest_rank = final_character.character_system.ranks.where(item: Rank.items[gift]).maximum(:public_rank)
      if all_abilities
        gift_level = :high
      else
        gift_level = gift_level(private_rank,lowest_rank)
      end
      if gift_level == :low
        collection = abilities.where(gift: gift, level: :low).or(collection)
      elsif gift_level == :med
        collection = abilities.where(gift: gift, level: :low).or(collection)
        collection = abilities.where(gift: gift, level: :med).or(collection)
      elsif gift_level == :high
        collection = abilities.where(gift: gift, level: :low).or(collection)
        collection = abilities.where(gift: gift, level: :med).or(collection)
        collection = abilities.where(gift: gift, level: :high).or(collection)
      end
    end
    collection = collection.distinct
    collection
  end
end
