class Response < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :assessment
  has_many :answers, dependent: :destroy
end
