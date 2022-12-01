require 'faker'

puts "dropping database entries"

QuestionsAssessment.destroy_all
Option.destroy_all
Question.destroy_all
Response.destroy_all
Assessment.destroy_all
User.destroy_all

puts "creating assessments, questions & their options, question_assessments, answers, responses"

# Real Maturity Assessment
okr_assessment = Assessment.create(
  name: "OKR Assessment",
  description: "This is an OKR maturity assessment to see how far you are in the implementation of this methodology
  and where we can support."
)

Question.create(
  question_text: "I know what OKRs are.",
  question_type: "Multiple Choice"
)
Question.create(
  question_text: "I understand the OKR cycle.",
  question_type: "Multiple Choice"
)
Question.create(
  question_text: "I understand the OKR principles.",
  question_type: "Multiple Choice"
)
Question.create(
  question_text: "I am able to explain the main OKR principles to others.",
  question_type: "Multiple Choice"
)
Question.create(
  question_text: "I am a certified OKR coach.",
  question_type: "Multiple Choice"
)
Question.create(
  question_text: "I can coach others in the OKR methodology.",
  question_type: "Multiple Choice"
)
Question.create(
  question_text: "I have experience in coaching others in the OKR methodology",
  question_type: "Multiple Choice"
)
Question.create(
  question_text: "I am able to apply the OKR methodology in practice.",
  question_type: "Multiple Choice"
)
Question.create(
  question_text: "I am able to teach others in how to apply the OKR methodology.",
  question_type: "Multiple Choice"
)
Question.create(
  question_text: "I understand the OKR cycle.",
  question_type: "Multiple Choice"
)

Question.all.each do |question|
  Option.create(
    option_text: "Strongly agree",
    value: 2,
    question: question
  )
  Option.create(
    option_text: "Agree",
    value: 1,
    question: question
  )
  Option.create(
    option_text: "Disagree",
    value: 0,
    question: question
  )
  QuestionsAssessment.create(
    weight: rand(1..8),
    question: question,
    assessment: okr_assessment
  )
end

10.times do
  User.create(
    email: Faker::Internet.email,
    password: "password",
    consultant: false
  )
end

User.all.each do |user|
  Response.create(
    score: 0,
    user: user,
    assessment: okr_assessment
  )
end

Question.all.each do |question|
  Answer.create(
    option: question.options.first,
    response: Response.last
  )
end

options = Response.last.answers.map(&:option)
values = []
Response.last.assessment.questions_assessments.each_with_index do |qa, i|
  score_weight = qa.weight
  values << (score_weight * options[i].value)
end
Response.last.update(score: values.sum)
Response.last.save!

puts "finished!"
