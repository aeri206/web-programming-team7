class Article < ApplicationRecord
    has_many :article_likes, dependent: :destroy
    has_many :liking_users, through: :article_likes, source: :profile
end
