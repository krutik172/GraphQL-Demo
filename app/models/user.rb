class User < ApplicationRecord
    has_secure_password
    attr_accessor :token

    validates :name, presence: true
    validates :email, presence: true, uniqueness: true
   
    has_many :posts
    has_many :comments
end
