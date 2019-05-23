class AddLinkIndexToContentLink < ActiveRecord::Migration
  def change
    add_reference :content_links, :link_index, index: true, null:false
  end
end
