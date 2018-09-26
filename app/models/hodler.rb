require Rails.root.join 'lib/entity_proto.js.rb'

class Hodler < ApplicationRecord
  def create_playable_entity!
    Entity.where(hodler: self).first_or_create!({
      name: name,
      last_hp: last_hp,
      last_hp_updated_at: last_hp_updated_at,
      last_combat_at: last_combat_at,
      controlled_by_id: owner_id,
      stats: stats
    })
  end

  def destroy!
    # I can't be destroyed!
    save!
  end

  def stats
    return {
      constitution: 6,
      exp: 0
    }
  end
end
