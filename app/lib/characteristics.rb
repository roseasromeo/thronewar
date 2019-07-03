module Characteristics

  #Battle start
  #########

  # Ready
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
      eff_range = :farthest
    elsif level == :med
      eff_range = :farther
    elsif level == :low
      eff_range = :far
    else
      eff_range = :close
    end
    eff_range
  end

  def ready_max_range(level)
    if level == :high
      max_range = :region
    elsif level == :med
      max_range = :farthest
    elsif level == :low
      max_range = :farther
    else
      max_range = :far
    end
    max_range
  end

  #Battle End
  #########

  #Cunning Start
  ##########

  # Initiative
  def initiative(rank)
    rank
  end

  #Cunning End
  ##########

  #Destiny Start
  ##########

  # Fate
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

  def fate_count(final_character)
    item = :destiny
    private_rank = final_character.ranks.where(item: Rank.items[item]).first.private_rank
    lowest_rank = final_character.character_system.ranks.where(item: Rank.items[item]).maximum(:public_rank)
    flaw = fate_flaw?(final_character)
    count = fate(private_rank,lowest_rank,flaw)
    count
  end

  def fate_flaw?(final_character)
    flaw = false
    if final_character.flaw1 != nil && final_character.flaw1.name == "All the World's a Stage"
      flaw = true
    end
    if final_character.flaw2 != nil && final_character.flaw2.name == "All the World's a Stage"
      flaw = true
    end
    flaw
  end

  #Destiny End
  ##########

  # Ego start
  #############

  def talent(final_character)
    item = :ego
    private_rank = final_character.ranks.where(item: Rank.items[item]).first.private_rank
    lowest_rank = final_character.character_system.ranks.where(item: Rank.items[item]).maximum(:public_rank)
    count = talent_math(private_rank,lowest_rank)
    count
  end

  def talent_math(private_rank, lowest_rank)
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

  # Ego end
  ############

  #Flesh start
  ##############

  # Restore
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

  # Flesh end
  ##############


end
