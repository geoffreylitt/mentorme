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

LANGUAGES = [
  "English",
  "Arabic"
]

LANGUAGES.each do |language|
  Language.create(name: language)
end

SKILLS.each do |skill|
  Skill.create(name: skill)
end

english = Language.find_by_name('English')
arabic = Language.find_by_name('Arabic')
law_id = Skill.find_by_name('law').id

max = User.create(first_name: 'Max', last_name: 'Stoller')
max.languages << english
max.languages << arabic
LearnSkill.create(user_id: max.id, skill_id: law_id)
max.save

alex = User.create(first_name: 'Alex')
alex.languages << english
TeachSkill.create(user_id: alex.id, skill_id: law_id)
alex.save

bob = User.create(first_name: 'Bob')
bob.languages << arabic
TeachSkill.create(user_id: bob.id, skill_id: law_id)
bob.save

health_id = Skill.find_by_name('health').id
steve = User.create(first_name: 'Steve')
steve.languages << arabic
TeachSkill.create(user_id: steve.id, skill_id: health_id)
steve.save

seth = User.create(first_name: 'Seth')
seth.languages << arabic
TeachSkill.create(user_id: seth.id, skill_id: law_id)
seth.save

jeff = User.create(first_name: 'Jeff')
jeff.languages << arabic
TeachSkill.create(user_id: jeff.id, skill_id: law_id)
jeff.save
