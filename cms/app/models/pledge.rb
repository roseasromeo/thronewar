class Pledge < ActiveRecord::Base
  belongs_to :character
  belongs_to :round
  belongs_to :item
end
