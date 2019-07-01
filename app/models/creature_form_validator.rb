class CreatureFormValidator < ActiveModel::Validator
  include Rules

  def validate(form)
    final_character = form.final_character
    valid = true

    if form.standard_form?
      if form.perk != 0
        valid = false
        form.errors[:perk] << "Standard Forms must not have any perks."
      end
    end
    if !(form.standard_extra?)
      if !(dual_existence?(final_character))
        valid = false
        form.errors[:extra_environment] << "Only characters with Dual Existence can specify an extra environment."
      end
      if !(form.standard_form?)
        valid = false
        form.errors[:extra_environment] << "Extra environments can only be specified for a Standard Form."
      end
    end
    if standard_perk?(form.perk)
      if !(form.standard?)
        valid = false
        form.errors[:environment] << "Please do not tinker with the code--the environment is specified by the perk."
      end
    end
    if aquatic_perk?(form.perk)
      if !(form.aquatic?)
        valid = false
        form.errors[:environment] << "Please do not tinker with the code--the environment is specified by the perk."
      end
    end
    puts form.environment

    valid
  end
end
