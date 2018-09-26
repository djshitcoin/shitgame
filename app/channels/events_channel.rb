# require Rails.root.join 'app/models/entity.rb'

class EventsChannel < ApplicationCable::Channel
  def subscribed
    if params[:subject] == "me"
      stream_for current_user
    else
      stream_from 'entities'
    end
  end
  
  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
  
  def attack params
    attacker = Entity.find(params['attacker_id'])
    return unless attacker.hodler.owner_id == current_user.id
    
    target = Entity.find(params['target_id'])
    return if attacker.friendly?(target)
    
    attacker.attack!(target)
  end

  def retrieve_entity params
    entity = Entity.find(params['id'])
    self.class.broadcast_to current_user, [:UPDATE_ENTITY, entity.as_json]
  end

  def retrieve_all_entities
    for entity in Entity.where(hodler_id: nil)
      self.class.broadcast_to current_user, [:UPDATE_ENTITY, entity.as_json]
    end
  end
end
