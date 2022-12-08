require 'faker'

puts "dropping database entries"

QuestionsAssessment.destroy_all
Option.destroy_all
Question.destroy_all
Response.destroy_all
Assessment.destroy_all
User.destroy_all

puts "creating assessments, questions & their options, question_assessments, answers, responses and users"

# 4 Maturity Assessments
  company_culture = Assessment.create(
  name: "Company Culture Maturity Assessment",
  description: "This maturity assessment helps us understand how well you will fit into our company culture.",
  state: false
  )

  okr_assessment = Assessment.create(
    name: "OKR Maturity Assessment",
    description: "This is an OKR maturity assessment to see how far you are in the implementation of this methodology
    and where we can support.",
    state: false
  )

  recruiting = Assessment.create(
    name: "Recruiting Maturity Assessment",
    description: "This maturity assessment helps us understand how your whole recruiting process is structured and where
    improvements can be made.",
    state: false
  )



  hr_strategy = Assessment.create(
    name: "HR Strategy Maturity Assessment",
    description: "This maturity assessment helps us understand how well you will fit into our company culture.",
    state: false
  )

# OKR Maturity Assessment
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

# Recruiting Maturity Assessment
recruiting_questions = [
  Question.create(
      question_text: "If you have a week time to train two monkeys do your job, do you think they are able to replace you without anyone noticing?",
      question_type: "Multiple Choice"
    ),
    Question.create(
      question_text: "You are so funny that you will most certainly be awarded the office jokester award.",
      question_type: "Multiple Choice"
    ),
    Question.create(
      question_text: "You are given the super powers of Superman, so you decide to fry some eggs with your eyes for the whole team.",
      question_type: "Multiple Choice"
    ),
    Question.create(
      question_text: "When I'm working from home, I wear my pyjamas.",
      question_type: "Multiple Choice"
    )
]

  recruiting_questions.each do |question|
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
      assessment: recruiting
    )
  end

# 5 clients created + 1 admin
  earl = User.create(
    name: "Earl E. Bird",
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

  User.create(
    email: "admin@example.com",
    password: "123456",
    admin: true
  )

# Responses per user and per assessment

  Response.create(
    user: dena,
    assessment: company_culture
  )

  Response.create(
    user: matilda,
    assessment: hr_strategy
  )

  Response.create(
    user: brandie,
    assessment: okr_assessment
  )

  Response.create(
    user: tommy,
    assessment: recruiting
  )



# Score calculation
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

# 3 responses created for dena, brandie and tommy

puts "finished!"
