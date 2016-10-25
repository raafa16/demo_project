class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :courses_users
  has_many :courses, :through => :courses_users

  mount_uploader :avatar, AvatarUploader
  belongs_to :semester

  #User Avatar Validation
  validates_integrity_of :avatar
  validates_processing_of :avatar

  private
  def avatar_size_validation
    errors[:avatar]<< 'Should be less than 500kb' if avatar.size >0.5.megabytes
  end

end
