# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

SKILLS = [
  "programming",
  "design",
  "finance",
  "business",
  "interviewing",
  "law",
  "health",
  "industry",
  "higher education",
  "entertainment"
]



SKILLS.each do |skill|
  Skill.create(name: skill)
end