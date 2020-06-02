class Company < ApplicationRecord
    has_many :company_likes, dependent: :destroy
    has_many :liking_users, through: :company_likes, source: :profile
end
