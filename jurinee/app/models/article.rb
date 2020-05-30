class Article < ApplicationRecord
    has_many :article_likes
    has_many :liking_users, through: :article_likes, source: :profile
end
