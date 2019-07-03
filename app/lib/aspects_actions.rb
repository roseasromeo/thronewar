module AspectsActions
  include Rules

  #Battle start
  #########

  # Clash
  def clash(attacker_level,defender_level)
    result = ''
    attacker_num = level_into_num(attacker_level)
    defender_num = level_into_num(defender_level)
    difference = attacker_num - defender_num
    if difference == 0
      result = 'Hit'
    elsif difference == 1 || difference == 2
      result = 'Hit + 1'
    elsif difference == 3 || difference == 4
      result = 'Hit + 2'
    elsif difference == -1
      result = 'Hit - 1'
    elsif difference == -2 || difference == -3 || difference == -4
      result = 'Miss'
    end
    result
  end

  # Movement
  def movement_out_of_combat(level)
    time = 0 #minutes
    if level == :max
      time = 0
    elsif level == :high
      time = 1
    elsif level == :med
      time = 5
    elsif level == :low
      time = 10
    elsif level == :no
      time = 20
    end
    time
  end

  def movement_in_combat(level)
    stages = 1
    if level == :max
      stages = 4
    elsif level == :high
      stages = 3
    elsif level == :med
      stages = 2
    elsif level == :low
      stages = 1
    elsif level == :no
      stages = 0 # 1 but grants Edge, needed different result as trigger
    end
    stages
  end

  # Ready is a characteristic

  # Planning
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

  def planning_charges(final_character)
    item = :battle
    private_rank = final_character.ranks.where(item: Rank.items[item]).first.private_rank
    lowest_rank = final_character.character_system.ranks.where(item: Rank.items[item]).maximum(:public_rank)
    charges = lowest_rank - private_rank + 1
    charges
  end

  #Battle end
  #########

  #Cunning start
  #########

  # Anticipation
  def anticipation_distance(level)
    if level == :max
      distance = :region
    elsif level == :high
      distance = :farther
    elsif level == :med
      distance = :close
    elsif level == :low
      distance = :closest
    elsif level == :no
      distance = :impossible
    end
    distance
  end

  def anticipation_aim(level)
    # number of attacks get Edge on Battle Clash
    if level == :max
      attacks = 4
    elsif level == :high
      attacks = 3
    elsif level == :med
      attacks = 2
    elsif level == :low
      attacks = 1
    elsif level == :no
      attacks = 0
    end
    attacks
  end

  # Deception
  def deception_actions(level)
    # number of actions stay hidden for
    if level == :max
      actions = 4
    elsif level == :high
      actions = 3
    elsif level == :med
      actions = 2
    elsif level == :low
      actions = 1
    elsif level == :no
      actions = 0
    end
    actions
  end

  # Perceive
  def perceive_distance(deception_level,perceive_level)
    deception_num = level_into_num(deception_level)
    perceive_num = level_into_num(perceive_level)
    difference = deception_num - perceive_num
    if difference == 0
      distance = :closer
    elsif difference == 1 || difference == 2
      distance = :closest
    elsif difference == 3 || difference == 4
      distance = :impossible
    elsif difference == -1 || difference == -2
      distance = :close
    elsif difference == -3 || difference == -4
      distance = :far
    end
    distance
  end

  #Cunning end
  #########

  #Destiny start
  #############

  #Meddle
  def meddle_rounds(attacker_level,defender_level)
    attacker_num = level_into_num(attacker_level)
    defender_num = level_into_num(defender_level)
    difference = attacker_num - defender_num
    if difference == 0 || difference == -1
      rounds = 1
    elsif difference == 1
      rounds = 2
    elsif difference == 2
      rounds = 3
    elsif difference == 3
      rounds = 4
    elsif difference == 4
      rounds = 5
    elsif difference == -2 || difference == -3 || difference == -4
      rounds = 0
    end
    rounds
  end

  #Agency
  def agency_fate(agency_level,natural_level)
    agency_num = level_into_num(agency_level)
    natural_num = level_into_num(natural_level)
    difference = agency_num - natural_num
    fate = 3 - difference
    fate
  end

  #Narrate
  def narrate_cooldown(level)
    if level == :max
      rounds = 0
    elsif level == :high
      rounds = 1
    elsif level == :med
      rounds = 2
    elsif level == :low
      rounds = 3
    elsif level == :no
      rounds = :impossible
    end
    rounds
  end

  #Destiny end
  ##############

  #Ego start
  ##############

  #Impress
  def impress_distance(level)
    if level == :max
      distance = :farthest
    elsif level == :high
      distance = :far
    elsif level == :med
      distance = :closer
    elsif level == :low
      distance = :contact
    elsif level == :no
      distance = :impossible
    end
    distance
  end

  #Push
  def push_damage(attacker_level,defender_level)
    attacker_num = level_into_num(attacker_level)
    defender_num = level_into_num(defender_level)
    difference = attacker_num - defender_num
    if difference == 0 || difference == 1 || difference == -1
      damage = 1
    elsif difference == 2
      damage = 2
    elsif difference == 3 || difference == 4
      damage = 3
    elsif difference == -2 || difference == -3 || difference == -4
      damage = 0
    end
    damage
  end

  #Intimidate
  #Doesn't have any math


  #Ego end
  #############

  # Flesh start
  ############

  # Brawn
  def brawn_damage(attacker_level,defender_level)
    attacker_num = level_into_num(attacker_level)
    defender_num = level_into_num(defender_level)
    difference = attacker_num - defender_num
    if difference == 0 || difference == 1 || difference == -1
      damage = 1
    elsif difference == 2
      damage = 2
    elsif difference == 3 || difference == 4
      damage = 3
    elsif difference == -2 || difference == -3 || difference == -4
      damage = 0
    end
    damage
  end

  # Form

  def shifting_time(level)
    if level == :high || level == :max
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

  def form_flaw?(final_character)
    flaw = false
    if final_character.flaw1 != nil && final_character.flaw1.name == "Static"
      flaw = true
    end
    if final_character.flaw2 != nil && final_character.flaw2.name == "Static"
      flaw = true
    end
    flaw
  end

  def flesh_forms(private_rank, lowest_rank, form_flaw)
    forms = 1
    if private_rank > 0
      forms = forms + 1 + lowest_rank - private_rank
    end
    if form_flaw
      forms = forms - 1
    end
    forms
  end

  def form_count(final_character)
    item = :flesh
    private_rank = final_character.ranks.where(item: Rank.items[item]).first.private_rank
    lowest_rank = final_character.character_system.ranks.where(item: Rank.items[item]).maximum(:public_rank)
    flaw = form_flaw?(final_character)
    count = flesh_forms(private_rank,lowest_rank,flaw)
    count
  end

  def perks
    collection = []
    i = 0
    # Standard
    collection << ["None", i]
    i = i + 1
    collection << ["Amphibian", i]
    i = i + 1
    collection << ["Extra Eyes", i]
    i = i + 1
    collection << ["Extra Sense", i]
    i = i + 1
    collection << ["Four Legged", i]
    i = i + 1
    collection << ["Wings", i]
    i = i + 1
    collection << ["Cold", i]
    i = i + 1
    collection << ["Hands", i]
    i = i + 1
    # Aquatic
    collection << ["Amphibian", i]
    i = i + 1
    collection << ["Luminescent", i]
    i = i + 1
    collection << ["Extra Sense", i]
    i = i + 1
    collection << ["Big Fins", i]
    i = i + 1
    collection << ["Camouflage", i]
    i = i + 1
    collection << ["Shell", i]
    i = i + 1
    collection << ["Hands", i]
    i = i + 1

    collection
  end

  def standard_perk?(perk)
    standard_environment_perk = false
    if perk <= 7
      standard_environment_perk = true
    end
  end

  def aquatic_perk?(perk)
    aquatic_environment_perk = false
    if perk >= 8
      aquatic_environment_perk = true
    end
  end

  # Survival
  def survival_rounds(level)
    if level == :max
      rounds = 4
    elsif level == :high
      rounds = 3
    elsif level == :med
      rounds = 2
    elsif level == :low
      rounds = 1
    elsif level == :no
      rounds = 0
    end
    rounds
  end

  def disruption_attacks(level,wound)
    # Attacks in a single round to be Disrupted (alternate condition to 3 damage in single attack)
    num = level_into_num(level)
    if wounds
      num = num - 1
    end
    if num == 4 # max no serious wound
      attacks = 7
    elsif num == 3 #high or max with serious wound
      attacks = 6
    elsif num == 2 #med or high with serious wound
      attacks = 5
    elsif num == 1 #low or med with serious wound
      attacks = 4
    elsif num == 0 #no flesh or low with serious wound
      attacks = 3
    elsif num == -1 #no flesh with serious wound
      attacks = 2
    end
    attacks
  end

  # Flesh end
  ##############

end
