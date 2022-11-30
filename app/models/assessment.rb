class Assessment < ApplicationRecord
  has_many :responses
  has_many :questions_assessments
  has_many :questions, through: :questions_assessments
end
