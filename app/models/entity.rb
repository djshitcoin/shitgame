require Rails.root.join 'lib/entity_proto.js.rb'

class Entity < ApplicationRecord
  include EntityProto

  belongs_to :blueprint, polymorphic: true, optional: true

  before_create do
    self.last_hp = self.max_hp
    self.last_hp_updated_at = Time.unix
    self.last_combat_at = 0
  end

  before_update :broadcast_changes
  after_destroy :broadcast_changes
  after_create :broadcast_created
  
  def broadcast_changes
    ActionCable.server.broadcast 'entities', [:UPDATE_ENTITY, changes_as_json]
  end

  def broadcast_created
    ActionCable.server.broadcast 'entities', [:UPDATE_ENTITY, as_json]
  end

  def changes_as_json  
    result = {id: id, destroyed: destroyed?}
    changed.map { |c| result[c] = send c }
    result
  end

  def friendly?(target)
    self == target
  end

  def attack!(target)
    return unless self.alive
    target.last_hp = target.hp - 6
    target.last_hp_updated_at = Time.unix
    target.last_combat_at = Time.unix
    if target.last_hp <= 0
      target.destroy!
      self.stats['exp'] += 5
      self.stats_will_change!
    else
      target.save!
    end

    self.last_hp = self.hp - 6
    self.last_hp_updated_at = Time.unix
    self.last_combat_at = Time.unix
    self.save!
  end
end
