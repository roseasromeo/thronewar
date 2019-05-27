class ContentLink < ApplicationRecord
  belongs_to :link_index

  validates_presence_of :name, :link, :order, :level
end
