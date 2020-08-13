class User < ApplicationRecord
    has_many :reviews 
    has_many :comments 
    has_many :restaurants, through: :reviews 

    validates :username, presence: true, uniqueness: { case_sensitive: false }
    validates :name, presence: true
    #validates :location, presence: true

    has_secure_password
end
