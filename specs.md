##MentorMe


###What do we absolutely need?

* prototype of the data model, personas
* functioning protype of that model matching people and a 3 way video
* recommendation of mentor/mentee, then you apply for a mentor
* embedded google doc
* mentor has time blocks when he's available and the mentee picks
* 15 min blocks
* emails translator when a meeting is taking place to see if theyre free, then they can claim it

###Technologies

* talkbox
* heroku
* postgres
* facebook login

###Data Models

* User
	* pictures
	* tags for knowledge you have (predetermined list)
	* tags for knowledge you want
	* location (country + city) - associated time zone
	* languages spoken (english, arabic)
	* times where you could mentor
	* bio
* Skill
	* learn_skill
	* teach_skill
* Language
* Time Slot
	* save timestamp
	* 15 min


###Interface

* graph of mentor-mentee relationships


###v3 

* reminders of mentorship sessions
* 1 to many conversation
* endorse mentor
* review conversation and mentor