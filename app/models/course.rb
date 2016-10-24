class Course < ApplicationRecord
  validates :name, presence: true, length: {maximum: 7}, uniqueness: true
  validates :description, presence: true, length: {maximum: 100}
  validates :credit, numericality: {only_integer: true}
 # validates :credit_between_1_and_3, on: :create
  has_and_belongs_to_many :users
  has_and_belongs_to_many :semesters


      def credit_between_1_and_3
        if credit<1||credit>3
          errors.add(:credit, "can't be less than 1 or greater than 3")
        else
          true
        end
      end
end
