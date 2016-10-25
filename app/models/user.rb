class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_and_belongs_to_many :courses

  mount_uploader :avatar, AvatarUploader
  belongs_to :semester

  #User Avatar Validation
  validates_integrity_of :avatar
  validates_processing_of :avatar

  private
  def avatar_size_valdiation
    errors[:avatar]<< 'Should be less than 500kb' if avatar.size >0.5.megabytes
  end

end
