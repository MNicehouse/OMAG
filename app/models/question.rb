class Question < ApplicationRecord
  has_many :options, dependent: :destroy
  has_many :questions_assessments, dependent: :destroy
  has_many :assessments, through: :questions_assessments
  accepts_nested_attributes_for :options
end
