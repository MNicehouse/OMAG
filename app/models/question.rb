class Question < ApplicationRecord
  belongs_to :assessment
  has_many :options
end
