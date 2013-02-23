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

law_id = Skill.find_by_name('law').id
max = User.create(first_name: 'Max', last_name: 'Stoller')
Language.create(name: 'English', user_id: max.id)
LearnSkill.create(user_id: max.id, skill_id: law_id)

alex = User.create(first_name: 'Alex')
Language.create(name: 'Arabic', user_id: alex.id)
Language.create(name: 'English', user_id: alex.id)
TeachSkill.create(user_id: alex.id, skill_id: law_id)

bob = User.create(first_name: 'Bob')
Language.create(name: 'Arabic', user_id: bob.id)
TeachSkill.create(user_id: bob.id, skill_id: law_id)

health_id = Skill.find_by_name('health').id
steve = User.create(first_name: 'Steve')
Language.create(name: 'Arabic', user_id: steve.id)
TeachSkill.create(user_id: steve.id, skill_id: health_id)

seth = User.create(first_name: 'Seth')
Language.create(name: 'Arabic', user_id: seth.id)
TeachSkill.create(user_id: seth.id, skill_id: law_id)

jeff = User.create(first_name: 'Jeff')
Language.create(name: 'English', user_id: jeff.id)
TeachSkill.create(user_id: jeff.id, skill_id: law_id)

