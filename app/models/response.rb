class Response < ApplicationRecord
  belongs_to :user
  belongs_to :assessment
  has_many :answers,  dependent: :destroy
end
