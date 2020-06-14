class Memo < ApplicationRecord
    belongs_to :profile
    belongs_to :article
end
