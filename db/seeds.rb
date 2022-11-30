require 'faker'
require 'open-uri'
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
puts "dropping database entries"

Answer.delete_all
Option.delete_all
QuestionsAssessment.delete_all
Response.delete_all
Question.delete_all
Assessment.delete_all
User.delete_all

puts "creating users, assessments, responses"
# add user
5.times do |i|
    file = ""
    user = User.new(
      email: Faker::Internet.email,
      password: "password",
      name: Faker::Name.name,
      consultant: true,
      about: "Lorel ipsum dolor",
      location: Faker::Address.full_address
    )
    # user.photo.attach(io: file, filename: "user_#{i}_0.jpeg", content_type: "image/jpeg")
    user.save!
  end
# add assessment
assessment = Assessment.new(
    name: "Test for IT admins",
    description: "This test is designed to hekpt system administrators evaluate their qualification"
  )
assessment.save!
assessment = Assessment.new(
    name: "Test for HR managers",
    description: "This test is designed to help human resources managers evaluate their qualification"
  )
assessment.save!
assessment = Assessment.new(
    name: "Test for sales managers",
    description: "This test is designed to help sales managers evaluate their qualification"
  )
assessment.save!
# add response
response = Response.new(
    user: User.take,
    assessment: Assessment.take,
    score: nil
  )
response.save!
response = Response.new(
    user: User.take,
    assessment: Assessment.take,
    score: nil
  )
response.save!
response = Response.new(
    user: User.take,
    assessment: Assessment.take,
    score: nil
  )
response.save!
# add
40.times do |i|
  question = Question.new(
    question_type: "MC",
    question_text: "Lorel ipsum dolor #{i}"
  )
  # 
  question.save!
end
# add questions_assessments
20.times do |i|
  questions_assessment = QuestionsAssessment.new(
    assessment: Assessment.first,
    question: Question.where("id = ?", Question.first.id + i).first,
    weight: 4
  )
  # 
  questions_assessment.save!
  #

end
20.times do |i|
  questions_assessment = QuestionsAssessment.new(
    assessment: Assessment.last,
    question: Question.where("id = ?", Question.first.id + i).first,
    weight: 4
  )
  # 
  questions_assessment.save!
end
# populate answers to eacj questions
Question.all.each do |question|
  4.times do |i|
    option = Option.new(
      question: question,
      option_text: "Lorel ipsum dolor response #{i}",
      value: rand(5)
    )
    # 
    option.save!
  end
end
# add answer
  4.times do |i|
    answer = Answer.new(
      response: Response.first,
      option: Option.take
    )
   answer.save!
  end