class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one :profile, dependent: :destroy
  after_create :build_profile # before_create? 
  # after_create :init_profile
  accepts_nested_attributes_for :profile

  def build_profile
    Profile.create(user: self) 
    # @proflie = Profile.new(params[:id]) # how about this? 
    # @profile.save()
  end

  # def init_profile
  #   self.create_profile!
  # end
end

