module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user
 
    def connect
      self.current_user = find_authorized_user
    end

    private
    def find_authorized_user
      # User.joins(:authorizations).where(authorizations: {token: cookies[:authorization]}).first
      cookies[:authorization]
    end
  end
end
