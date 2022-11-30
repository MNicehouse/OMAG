class Assessment < ApplicationRecord
  has_many :responses,  dependent: :destroy
  has_many :questions_assessments,  dependent: :destroy
end
