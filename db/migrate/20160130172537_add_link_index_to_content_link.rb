class AddLinkIndexToContentLink < ActiveRecord::Migration[5.2]
  def change
    add_reference :content_links, :link_index, index: true, null:false
  end
end
