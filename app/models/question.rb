class Question < ApplicationRecord
  has_many :options
  has_many :questions_assessments
  has_many :assessments, through: :questions_assessments
  accepts_nested_attributes_for :options
end
