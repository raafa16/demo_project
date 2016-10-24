class Semester < ApplicationRecord
  validates :name, presence: true
  validates :year, presence: true
  before_create :inactivate_semester

  has_and_belongs_to_many :courses

  private
  def inactivate_semester
    Semester.update(active: "false")

  end
end
