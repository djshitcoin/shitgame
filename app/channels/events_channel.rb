class EventsChannel < ApplicationCable::Channel
  
  def subscribed
    stream_for current_user
  end
  
  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
  
  def dispatch action, payload
    self.class.broadcast_to current_user, [action, payload]
  end

  def get_initial_state
    dispatch :INITIAL_STATE, {
      hodler: {
        last_hp: 30,
        last_hp_updated_at: Time.now,
        exp: 410
      }
    }
  end

  def dorp
  end
end
