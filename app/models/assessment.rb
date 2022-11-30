class Assessment < ApplicationRecord
  has_many :responses,  dependent: :destroy
  has_many :questions,  dependent: :destroy
end
