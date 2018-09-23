class User < ApplicationRecord
  has_many :hodlers, foreign_key: 'owner_id'
  has_many :authorizations
end