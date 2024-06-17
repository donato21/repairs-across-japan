extends Node2D

var client_list: Array

func _ready():
	Global.connect("next_client",self,"next_client")
	client_list.append(load("res://res/connor1.tres"))
	Global.connect("hide_client",self,"hide_client")

func hide_client():
	if Global.main.get_child(0).client != null:
		Global.main.get_child(0).hide_client()

func next_client():
	if client_list.size() > 0:
		if is_hub():
			Global.main.get_child(0).load_client(client_list[0])
			Global.current_client = client_list[0]
			client_list.pop_front()
		else:
			print("ERROR: Attempting to call client outside of hub scene")
	else:
		print("ERROR: Attempting to call next client with no clients in queue")

func is_hub():
	return Global.main.get_child(0).has_method("load_client")
