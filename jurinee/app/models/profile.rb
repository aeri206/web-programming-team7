class Profile < ApplicationRecord
    belongs_to :user
    validates :user, uniqueness: true, presence: true
    has_many :article_likes, dependent: :destroy
    has_many :liked_articles, through: :article_likes, source: :article
end

