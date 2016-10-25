class Semester < ApplicationRecord
  validates :name, presence: true
  validates :year, presence: true
  before_create :inactivate_semester

  has_and_belongs_to_many :courses
  has_many :users
  has_many :courses_users

  private
  def inactivate_semester
    Semester.update(active: "false")

  end
end
