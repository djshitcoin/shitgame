class EventsChannel < ApplicationCable::Channel
  
  def subscribed
    stream_for current_user
  end
  
  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
  
  def dispatch action, payload = nil
    self.class.broadcast_to current_user, [action, payload]
  end

  def get_initial_state
    dispatch :UPDATE_ENTITY, {
      id: 1,
      cached: {
        hp: 10,
        hp_updated_at: Time.now.to_i,
        last_combat_at: Time.now.to_i,
        constitution: 10
      }
    }
  end
end
