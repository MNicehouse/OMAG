require 'faker'

puts "dropping database entries"

QuestionsAssessment.destroy_all
Option.destroy_all
Question.destroy_all
Response.destroy_all
Assessment.destroy_all
User.destroy_all

puts "creating assessments, questions & their options, question_assessments, answers, responses and users"

# Real Maturity Assessment

#company culture
company_culture = Assessment.create(
  name: "Company Culture Maturity Assessment",
  description: "This maturity assessment helps us understand how well you will fit into our company culture.",
  state: false
)
recruiting = Assessment.create(
  name: "Recruiting Maturity Assessment",
  description: "This maturity assessment helps us understand how your whole recruiting process is structured and where
  improvements can be made.",
  state: false
)
okr_assessment = Assessment.create(
  name: "OKR Maturity Assessment",
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
  question_text: "I can coach others in the OKR methodology.",
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
    weight: rand(1..4),
    question: question,
    assessment: okr_assessment
  )
end

earl = User.create(
  name: "Earl E. Bird",
  email: "earl@bird.chip",
  password: "password",
  admin: false

)

brandie = User.create(
  name: "Brandie Spears",
  email: "brandiespears@gmail.com",
  password: "password",
  admin: false
)

tommy = User.create(
  name: "Tommy Bray",
  email: "therealtommy@hotmail.com",
  password: "password",
  admin: false
)

dena = User.create(
  name: "Dena Sawyer",
  email: "nottomsawyerbutdena@outlook.de",
  password: "password",
  admin: false
)

matilda = User.create(
  name: "Matilda Cain",
  email: "frenchfries@outlook.fr",
  password: "password",
  admin: false
)

Response.create(
  user: brandie,
  assessment: okr_assessment
)

Response.create(
  user: tommy,
  assessment: recruiting
)

Response.create(
  user: dena,
  assessment: company_culture
)

User.create(
  email: "admin@example.com",
  password: "123456",
  admin: true
)

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

Response.create(
  user: dena,
  score: rand(1..30),
  completed: true,
  assessment_id: 1
)

Response.create(
  user: brandie,
  score: rand(35..60),
  completed: false,
  assessment_id: 2
)

Response.create(
  user: tommy,
  score: rand(70..100),
  completed: false,
  assessment_id: 3
)

puts "finished!"
