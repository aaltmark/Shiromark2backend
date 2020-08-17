class User < ApplicationRecord
    has_many :reviews 
    has_many :comments 
    has_many :restaurants, through: :reviews 

    has_many :active_relationships, class_name: 'Relationship', foreign_key: "follower_id", dependent: :destroy
    has_many :passive_relationships, class_name: 'Relationship', foreign_key: "followed_id", dependent: :destroy

    has_many :followed_users, through: :active_relationships, source: :followed_user
    has_many :follower_users, through: :passive_relationships, source: :follower_user

    validates :username, presence: true, uniqueness: { case_sensitive: false }
    validates :name, presence: true
    #validates :location, presence: true

    has_secure_password
end
