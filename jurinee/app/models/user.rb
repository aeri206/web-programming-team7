class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :email, uniqueness: true, presence: true
  validates :name, uniqueness: true, presence: true
  has_one :profile, dependent: :destroy
  after_create :build_profile
  accepts_nested_attributes_for :profile

  def build_profile
    Profile.create(user: self) 
  end

end

