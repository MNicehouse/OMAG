class Question < ApplicationRecord
  has_many :questions_assessments,  dependent: :destroy
  has_many :options,  dependent: :destroy
end
