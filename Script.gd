extends Node

var dict = {
	"TUTORIAL": [
		{"await": "hub_loaded"},
		{"dialog": [
			"BB", "Welcome new employee to Monkey Wrench Incorporated!",
			"As of today, you are the proud owner and sole employee of our new mobile bicycle repair franchise!",
			"As part of your job, you will need to travel across Japan to prove that this business model is a great asset for our investors.",
			"We're running a short trial period for the viability of this venture.",
			"So if you hit our quotas for the next four days, then on behalf of Monkey Wrench Inc. I will reward you with an amazing prize!",
			"By the way...",
			"We heard that there's a foreigner making a rukus about cycling. We hope to take advantage of this event as well to boost sales!"
		]},
		{"trigger": "next_client"},
		{"timer": 1},
		{"dialog": [
			"Speak of the devil, here he is!", "Go on, say something!"]},
		{"timer": 0.5},
		{"dialog": [
			"P","Hello! How can I help you?", 
			"CD","Hi! I wanted to get my bike checked.",
			"We just finished wrapping up cycling all day and I admit, I may have abused the bike a bit.",
			"Could you have it by tomorrow morning?", 
			"P", "Of course! We'll have it ready for pickup bright and early.", 
			"CD", "Great! Here's the work order for my bike."
		]},
		{"trigger": "show_wo"},
		{"timer": 1},
		{"dialog": ["BB", "Look at you! Already making influential customers!", "With the amount of money from this work order alone we're set!",
			"We'll need to keep a closer eye on Mr. Con Air and make sure that you're always nearby to accept his generosity.",
			"But before that, make sure the work order is properly filled out.",
			"If a customer can't bother doing their paperwork right, then we don't want their business!"]},
		{"dialog":["Make sure to check the checkboxes on the work order."]},
		{"await": "wo_approved"},
		{"dialog":["P","Everything looks good Mr. Connor! We'll have your bike here for you in the morning."]},
		{"dialog": ["CD","Thanks again!"]},
		{"trigger": "hide_client"},
		{"timer": 1},
		{"dialog": ["BB","All right! Let's close up shop and get you situated with our repair rooms."]},
		{"trigger": "load_repair"},
		{"await": "repair_loaded"},
		{"dialog": [
			"BB", "At every location you stop across Japan, Monkey Wrench Inc. will have a local repair shop you can use.",
			"During your day shift, you will process work orders, and at night you will come to a local shop and fix people's bikes.",
			"Let's get started, to your left is the tool wall."
		]},
		{"await": "looking_at_tools"},
		{"dialog": ["Looks like this place is a bit rundown...", "Go ahead and grab the air pump, then fix the flats."]},
		{"trigger": "audio_scare"},
		{"timer": 1},
		{"dialog": ["P","What was that?","BB","I don't know, check behind you..."]},
		{"await": "looking_at_hall"},
		{"trigger": "start_scare"},
		{"dialog": ["BB","Quick! Shine your flashlight on that thing! Dear GOD!!!","NR","Press F to use your flashlight"]},
		{"await": "mouse_dead"},
		{"dialog": ["Jeez, well now that she's scurried off finish up with the repair!"]},
		{"await": "repairs_done"},
		{"timer":1},
		{"dialog": [
			"And that's it! Since we have today's quota done, make sure to get ready to move out tomorrow!",
			"As you make quota, we'll provide the funds for traveling to your next destination.",
			"But remember, you won't get your special prize unless you complete each quota on the first day that you're on location!!",
			"Good luck!","NR","And that's the end of the Demo","This was pain ;-;",
			"We hope to have more in the near future!","Thanks for playing! :D"
		]}
	],
	"SKIPPY_JONES": {
		"test": "test"
	}
}
