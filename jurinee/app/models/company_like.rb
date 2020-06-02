class CompanyLike < ApplicationRecord
  belongs_to :profile
  belongs_to :company
end
