extends Node2D

const characters: Dictionary = {"BB": "The Big Boss", "P": "", "CD": "Connor Dog", "CB": "Bris Chrod", "IM": "Tungsten Rat", "NR": ""}

func _ready():
	parse_script(GScript.dict.TUTORIAL)

func _input(event):
	if event is InputEventJoypadButton and event.is_pressed() or event is InputEventKey and event.is_pressed() or event is InputEventScreenTouch and event.is_pressed():
		Global.emit_signal("dialog_interrupt")

func parse_script(script: Array):
	for dict in script:
		dict = dict as Dictionary
		if dict.keys()[0] == "await":
			if Global.has_signal(dict.values()[0]):
				yield(Global,dict.values()[0])
			else:
				print("ERROR: ", dict.values()[0], " Global signal not found!")
				break
		elif dict.keys()[0] == "trigger":
			if Global.has_signal(dict.values()[0]):
				Global.emit_signal(dict.values()[0])
			else:
				print("ERROR: ", dict.values()[0], " Global signal not found!")
				break
		elif dict.keys()[0] == "dialog":
			Global.dialog.clear()
			for string in dict.values()[0]:
				if characters.has(string):
					if string == "P":
						Global.dialog.set_title(Global.player_name)
					else:
						Global.dialog.set_title(characters[string])
				else:
					Global.dialog.show_rect()
					Global.dialog.set_text(string)
					yield(Global,"dialog_interrupt")
			Global.dialog.hide_rect()
		elif dict.keys()[0] == "timer":
			yield(get_tree().create_timer(dict.values()[0]),"timeout")
