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
      level = :none
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
      level = :none
    end
  end

  def approval(final_character)
    # Overspending
    notices = []
    if final_character.leftover_points < 0
      notices << "Purchases have exceeded maximum point expenditure. Please add Flaws, decrease Luck, decrease buy-ups, or remove other purchases."
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

    #check for blanks
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
    if check_blank(final_character.standardform)
      notices << "Standard Form must be completed before submission."
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
end
