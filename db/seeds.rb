# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Gift abilities

#define ability initializer for Gift abilities
def initialize_game_ability(ability_name)
  game_ability = GameAbility.find_or_initialize_by(ability: ability_name)
  if !(Ability.where(name: ability_name).empty?)
    ability = Ability.where(name: ability_name).first
    game_ability.long_text = ability.long_text
    game_ability.item = ability.gift
  end
  game_ability
end


# Command

# Summon Arcadia
ability_name = "Summon Arcadia"
game_ability = initialize_game_ability(ability_name)
game_ability.name = ability_name
game_ability.targets_another = false
game_ability.time_base = 0
game_ability.time_function = 'none'
game_ability.rounds_base = 1
game_ability.rounds_function = 'none'
game_ability.fate_cost_base = 2
game_ability.fate_cost_function = 'none'
game_ability.damage_base = 0
game_ability.damage_function = 'none'
game_ability.secret_action = true
game_ability.cooldown = false
game_ability.cooldown_base = 0
game_ability.cooldown_function = 'none'
game_ability.disruptable = true
game_ability.disruption_cost_self = 0
game_ability.disruption_cost_effect = 0
game_ability.duration_time_base = 10
game_ability.duration_time_function = 'none'
game_ability.duration_rounds_base = 5
game_ability.duration_rounds_function = 'none'
game_ability.upkeep_cost = 1
game_ability.other_requirements = 'none'
game_ability.other_costs = 'none'
game_ability.contests = 'none'
game_ability.edge_function = 'none'
game_ability.save!

# Stable Form is part of Potent Forms

# Fortify Arcadia has two In-Game abilities
# Physical Fortify Arcadia
ability_name = "Fortify Arcadia"
game_ability = initialize_game_ability(ability_name)
game_ability.name = "Physical Fortify Arcadia"
game_ability.targets_another = false
game_ability.time_base = 0
game_ability.time_function = 'none'
game_ability.rounds_base = 1
game_ability.rounds_function = 'none'
game_ability.fate_cost_base = 0
game_ability.fate_cost_function = 'none'
game_ability.damage_base = 0
game_ability.damage_function = 'none'
game_ability.secret_action = true
game_ability.cooldown = false
game_ability.cooldown_base = 0
game_ability.cooldown_function = 'none'
game_ability.disruptable = true
game_ability.disruption_cost_self = 1
game_ability.disruption_cost_effect = 2
game_ability.duration_time_base = 0
game_ability.duration_time_function = 'none'
game_ability.duration_rounds_base = 0
game_ability.duration_rounds_function = 'none'
game_ability.upkeep_cost = 0
game_ability.other_requirements = 'summoned_arcadia'
game_ability.other_costs = 'none'
game_ability.contests = '#command_level=battle_clash_level|defensive##command_level=flesh_survival_level|disruption'
game_ability.edge_function = 'none'
game_ability.save!

ability_function = AbilityFunction.find_or_initialize_by(name: "summoned_arcadia")
ability_function.operation = "check_arcadia(user)"
ability_function.save!

# Physical Fortify Arcadia
ability_name = "Fortify Arcadia"
game_ability = initialize_game_ability(ability_name)
game_ability.name = "Mystical Fortify Arcadia"
game_ability.targets_another = false
game_ability.time_base = 0
game_ability.time_function = 'none'
game_ability.rounds_base = 1
game_ability.rounds_function = 'none'
game_ability.fate_cost_base = 0
game_ability.fate_cost_function = 'none'
game_ability.damage_base = 0
game_ability.damage_function = 'none'
game_ability.secret_action = true
game_ability.cooldown = false
game_ability.cooldown_base = 0
game_ability.cooldown_function = 'none'
game_ability.disruptable = true
game_ability.disruption_cost_self = 1
game_ability.disruption_cost_effect = 0
game_ability.duration_time_base = 0
game_ability.duration_time_function = 'none'
game_ability.duration_rounds_base = 0
game_ability.duration_rounds_function = 'none'
game_ability.upkeep_cost = 0
game_ability.other_requirements = 'summoned_arcadia'
game_ability.other_costs = 'none'
game_ability.contests = 'none'
game_ability.edge_function = 'mystical_fortify_arcadia_edge'
game_ability.save!

# Search the Realms has three In-Game abilities
# Travel the Realms
ability_name = "Search the Realms"
game_ability = initialize_game_ability(ability_name)
game_ability.name = "Travel the Realms"
game_ability.targets_another = false
game_ability.time_base = 10
game_ability.time_function = 'none'
game_ability.rounds_base = 0
game_ability.rounds_function = 'none'
game_ability.fate_cost_base = 0
game_ability.fate_cost_function = 'none'
game_ability.damage_base = 0
game_ability.damage_function = 'none'
game_ability.secret_action = true
game_ability.cooldown = false
game_ability.cooldown_base = 0
game_ability.cooldown_function = 'none'
game_ability.disruptable = true
game_ability.disruption_cost_self = 0
game_ability.disruption_cost_effect = 0
game_ability.duration_time_base = 0
game_ability.duration_time_function = 'none'
game_ability.duration_rounds_base = 0
game_ability.duration_rounds_function = 'none'
game_ability.upkeep_cost = 0
game_ability.other_requirements = 'summoned_arcadia'
game_ability.other_costs = 'disperse_summoned_arcadia'
game_ability.contests = '#command_levelxnatural_level##command_levelxgift_level#'
game_ability.edge_function = 'none'
game_ability.save!

ability_function = AbilityFunction.find_or_initialize_by(name: "disperse_summoned_arcadia")
ability_function.operation = "remove_summoned_arcadia(user)"
ability_function.save!

# Pilfer the Realms non-Fae
ability_name = "Search the Realms"
game_ability = initialize_game_ability(ability_name)
game_ability.name = "Pilfer the Realms non-Fae"
game_ability.targets_another = false
game_ability.time_base = 10
game_ability.time_function = 'none'
game_ability.rounds_base = 0
game_ability.rounds_function = 'none'
game_ability.fate_cost_base = 0
game_ability.fate_cost_function = 'none'
game_ability.damage_base = 0
game_ability.damage_function = 'none'
game_ability.secret_action = true
game_ability.cooldown = false
game_ability.cooldown_base = 0
game_ability.cooldown_function = 'none'
game_ability.disruptable = true
game_ability.disruption_cost_self = 0
game_ability.disruption_cost_effect = 0
game_ability.duration_time_base = 0
game_ability.duration_time_function = 'none'
game_ability.duration_rounds_base = 0
game_ability.duration_rounds_function = 'none'
game_ability.upkeep_cost = 0
game_ability.other_requirements = 'summoned_arcadia'
game_ability.other_costs = 'disperse_summoned_arcadia'
game_ability.contests = '#command_levelxnatural_level##command_levelxgift_level#'
game_ability.edge_function = 'pilfer_the_realms_edge'
game_ability.save!

# Pilfer the Realms Fae
ability_name = "Search the Realms"
game_ability = initialize_game_ability(ability_name)
game_ability.name = "Pilfer the Realms Fae"
game_ability.targets_another = false
game_ability.time_base = 10
game_ability.time_function = 'none'
game_ability.rounds_base = 0
game_ability.rounds_function = 'none'
game_ability.fate_cost_base = 0
game_ability.fate_cost_function = 'none'
game_ability.damage_base = 0
game_ability.damage_function = 'none'
game_ability.secret_action = true
game_ability.cooldown = false
game_ability.cooldown_base = 0
game_ability.cooldown_function = 'none'
game_ability.disruptable = true
game_ability.disruption_cost_self = 0
game_ability.disruption_cost_effect = 0
game_ability.duration_time_base = 0
game_ability.duration_time_function = 'none'
game_ability.duration_rounds_base = 0
game_ability.duration_rounds_function = 'none'
game_ability.upkeep_cost = 0
game_ability.other_requirements = 'summoned_arcadia'
game_ability.other_costs = 'disperse_summoned_arcadia'
game_ability.contests = '#command_levelxnatural_level##command_levelxgift_level#'
game_ability.edge_function = 'pilfer_the_realms_edge'
game_ability.save!

# Sense Regency is on all the time, taken care of in Tracker

# Lesser Realm Command
ability_name = "Lesser Realm Command"
game_ability = initialize_game_ability(ability_name)
game_ability.name = ability_name
game_ability.targets_another = false
game_ability.time_base = 10
game_ability.time_function = 'none'
game_ability.rounds_base = 0
game_ability.rounds_function = 'none'
game_ability.fate_cost_base = 0
game_ability.fate_cost_function = 'lesser_realm_command_fate'
game_ability.damage_base = 0
game_ability.damage_function = 'none'
game_ability.secret_action = true
game_ability.cooldown = false
game_ability.cooldown_base = 0
game_ability.cooldown_function = 'none'
game_ability.disruptable = true
game_ability.disruption_cost_self = 0
game_ability.disruption_cost_effect = 0
game_ability.duration_time_base = 0
game_ability.duration_time_function = 'none'
game_ability.duration_rounds_base = 0
game_ability.duration_rounds_function = 'none'
game_ability.upkeep_cost = 0
game_ability.other_requirements = 'summoned_arcadia'
game_ability.other_costs = 'none'
game_ability.contests = 'none'
game_ability.edge_function = 'none'
game_ability.save!

ability_function = AbilityFunction.find_or_initialize_by(name: "lesser_realm_command_fate")
ability_function.operation = "regency_ability_cost"
ability_function.save!

prompt1 = Prompt.find_or_initialize_by(name: "regency_ability_cost", ability_function: ability_function)
prompt1.save!

# Arcadian Multitasking limits number of summmoned_arcadia abilities --> in tracker

# Arcadian Sight
ability_name = "Arcadian Sight"
game_ability = initialize_game_ability(ability_name)
game_ability.name = ability_name
game_ability.targets_another = false
game_ability.time_base = 0
game_ability.time_function = 'none'
game_ability.rounds_base = 2
game_ability.rounds_function = 'none'
game_ability.fate_cost_base = 1
game_ability.fate_cost_function = 'none'
game_ability.damage_base = 0
game_ability.damage_function = 'none'
game_ability.secret_action = true
game_ability.cooldown = false
game_ability.cooldown_base = 0
game_ability.cooldown_function = 'none'
game_ability.disruptable = true
game_ability.disruption_cost_self = 0
game_ability.disruption_cost_effect = 0
game_ability.duration_time_base = 0
game_ability.duration_time_function = 'none'
game_ability.duration_rounds_base = 0
game_ability.duration_rounds_function = 'none'
game_ability.upkeep_cost = 0
game_ability.other_requirements = 'summoned_arcadia'
game_ability.other_costs = 'none'
game_ability.contests = '#command_levelxcunning_aniticipation_level|detection'
game_ability.edge_function = 'none'
game_ability.save!

# Command Form should be taken care of in Potent Forms

# Greater Realm Command
ability_name = "Greater Realm Command"
game_ability = initialize_game_ability(ability_name)
game_ability.name = ability_name
game_ability.targets_another = false
game_ability.time_base = 0
game_ability.time_function = 'none'
game_ability.rounds_base = 3
game_ability.rounds_function = 'greater_realm_command_rounds'
game_ability.fate_cost_base = 0
game_ability.fate_cost_function = 'greater_realm_command_fate'
game_ability.damage_base = 0
game_ability.damage_function = 'none'
game_ability.secret_action = true
game_ability.cooldown = false
game_ability.cooldown_base = 0
game_ability.cooldown_function = 'none'
game_ability.disruptable = true
game_ability.disruption_cost_self = 0
game_ability.disruption_cost_effect = 0
game_ability.duration_time_base = 0
game_ability.duration_time_function = 'none'
game_ability.duration_rounds_base = 0
game_ability.duration_rounds_function = 'none'
game_ability.upkeep_cost = 0
game_ability.other_requirements = 'summoned_arcadia'
game_ability.other_costs = 'none'
game_ability.contests = 'none'
game_ability.edge_function = 'none'
game_ability.save!

ability_function = AbilityFunction.find_or_initialize_by(name: "greater_realm_command_rounds")
ability_function.operation = "-fate_spent"
ability_function.save!

prompt1 = Prompt.find_or_initialize_by(name: "fate_spent", ability_function: ability_function)
prompt1.save!

ability_function = AbilityFunction.find_or_initialize_by(name: "greater_realm_command_fate")
ability_function.operation = "regency_ability_cost+fate_spent"
ability_function.save!

prompt1 = Prompt.find_or_initialize_by(name: "fate_spent", ability_function: ability_function)
prompt1.save!
prompt1 = Prompt.find_or_initialize_by(name: "regency_ability_cost", ability_function: ability_function)
prompt1.save!

# Stabilize non-Fae
ability_name = "Stabilize"
game_ability = initialize_game_ability(ability_name)
game_ability.name = ability_name + " non_Fae"
game_ability.targets_another = false
game_ability.time_base = 0
game_ability.time_function = 'none'
game_ability.rounds_base = 1
game_ability.rounds_function = 'none'
game_ability.fate_cost_base = 2
game_ability.fate_cost_function = 'none'
game_ability.damage_base = 0
game_ability.damage_function = 'none'
game_ability.secret_action = false
game_ability.cooldown = true
game_ability.cooldown_base = 1
game_ability.cooldown_function = 'stabilize_rounds'
game_ability.disruptable = true
game_ability.disruption_cost_self = 0
game_ability.disruption_cost_effect = 0
game_ability.duration_time_base = 0
game_ability.duration_time_function = 'none'
game_ability.duration_rounds_base = 0
game_ability.duration_rounds_function = 'stabilize_rounds'
game_ability.upkeep_cost = 0
game_ability.other_requirements = 'none'
game_ability.other_costs = 'none'
game_ability.contests = 'none'
game_ability.edge_function = 'none'
game_ability.save!

ability_function = AbilityFunction.find_or_initialize_by(name: "stabilize_rounds")
ability_function.operation = "3-rounded_command_rank(user)"
ability_function.save!

# Stabilize Fae
ability_name = "Stabilize"
game_ability = initialize_game_ability(ability_name)
game_ability.name = ability_name + " Fae"
game_ability.targets_another = true
game_ability.time_base = 0
game_ability.time_function = 'none'
game_ability.rounds_base = 1
game_ability.rounds_function = 'none'
game_ability.fate_cost_base = 2
game_ability.fate_cost_function = 'none'
game_ability.damage_base = 0
game_ability.damage_function = 'none'
game_ability.secret_action = false
game_ability.cooldown = true
game_ability.cooldown_base = 1
game_ability.cooldown_function = 'stabilize_rounds'
game_ability.disruptable = true
game_ability.disruption_cost_self = 0
game_ability.disruption_cost_effect = 0
game_ability.duration_time_base = 0
game_ability.duration_time_function = 'none'
game_ability.duration_rounds_base = 0
game_ability.duration_rounds_function = 'stabilize_rounds'
game_ability.upkeep_cost = 0
game_ability.other_requirements = 'none'
game_ability.other_costs = 'none'
game_ability.contests = 'none'
game_ability.edge_function = 'none'
game_ability.save!

# Stabilize Fae
ability_name = "Summon the Blood"
game_ability = initialize_game_ability(ability_name)
game_ability.name = ability_name
game_ability.targets_another = true
game_ability.time_base = 0
game_ability.time_function = 'summon_the_blood_time'
game_ability.rounds_base = 0
game_ability.rounds_function = 'none'
game_ability.fate_cost_base = 3
game_ability.fate_cost_function = 'none'
game_ability.damage_base = 0
game_ability.damage_function = 'none'
game_ability.secret_action = false
game_ability.cooldown = false
game_ability.cooldown_base = 0
game_ability.cooldown_function = 'none'
game_ability.disruptable = false
game_ability.disruption_cost_self = 0
game_ability.disruption_cost_effect = 0
game_ability.duration_time_base = 0
game_ability.duration_time_function = 'none'
game_ability.duration_rounds_base = 0
game_ability.duration_rounds_function = 'none'
game_ability.upkeep_cost = 0
game_ability.other_requirements = 'none'
game_ability.other_costs = 'none'
game_ability.contests = 'none'
game_ability.edge_function = 'summon_the_blood_edge'
game_ability.save!

ability_function = AbilityFunction.find_or_initialize_by(name: "summon_the_blood_time")
ability_function.operation = "rounded_command_rank(user)*10"
ability_function.save!

# # Change
# # Summon Arcadia
# ability_name = "Run Among the Realms"
# game_ability = initialize_game_ability(ability_name)
# game_ability.name = ability_name
# game_ability.targets_another = false
# game_ability.time_base = 0
# game_ability.time_function = 'none'
# game_ability.rounds_base = 1
# game_ability.rounds_function = 'none'
# game_ability.fate_cost_base = 2
# game_ability.fate_cost_function = 'none'
# game_ability.damage_base = 0
# game_ability.damage_function = 'none'
# game_ability.secret_action = true
# game_ability.cooldown = false
# game_ability.cooldown_base = 0
# game_ability.cooldown_function = 'none'
# game_ability.disruptable = true
# game_ability.disruption_cost_self = 0
# game_ability.disruption_cost_effect = 0
# game_ability.duration_time_base = 10
# game_ability.duration_time_function = 'none'
# game_ability.duration_rounds_base = 5
# game_ability.duration_rounds_function = 'none'
# game_ability.upkeep_cost = 1
# game_ability.other_requirements = 'none'
# game_ability.other_costs = 'none'
# game_ability.contests = 'none'
# game_ability.edge_function = 'none'
# game_ability.save!
