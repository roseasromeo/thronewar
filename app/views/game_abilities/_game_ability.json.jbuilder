json.extract! game_ability, :id, :name, :long_text, :item, :targets_another, :time_base, :time_function, :rounds_base, :rounds_function, :secret_action, :disruptable, :fate_cost_base, :fate_cost_function, :cooldown, :ability, :created_at, :updated_at
json.url game_ability_url(game_ability, format: :json)
