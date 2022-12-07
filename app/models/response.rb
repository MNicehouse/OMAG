class Response < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :assessment
  has_many :answers, dependent: :destroy

  def has_one_question
    self.assessment.questions_assessments.length > 0
  end
end
