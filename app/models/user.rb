class User < ApplicationRecord
    has_secure_password

    has_many :ideas, dependent: :destroy
    has_many :reviews, dependent: :destroy

    has_many :likes, dependent: :destroy
    has_many :liked_ideas, through: :likes, source: :idea

    validates :email, presence: true, uniqueness: true
    validates :password, presence: true, length: {minimum: 3}
end
