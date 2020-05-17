class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one :profile, dependent: :destroy
  after_create :build_profile

  def build_profile
    Profile.create(user: self) # Associations must be defined correctly for this syntax, avoids using ID's directly.
    console.log("user profile created")
  end
end

