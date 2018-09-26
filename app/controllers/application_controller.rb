class ApplicationController < ActionController::Base
  def index
    @played_entity = Hodler.find(params[:hodler]).create_playable_entity!
  end
end
