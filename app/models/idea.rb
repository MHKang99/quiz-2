class Idea < ApplicationRecord
    belongs_to :user
    has_many :reviews, dependent: :destroy
    has_many :users, through: :reviews
    has_many :likes, dependent: :destroy
    has_many :users, through: :likes
end
