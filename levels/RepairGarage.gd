extends Spatial


export var music: AudioStream
var direction: Vector2 = Vector2()
var current_bike: BikeResource

func _ready():
	if music != null and Global.music != null:
		Global.play_music(music)
	load_next_bike()
	yield(get_tree().create_timer(1),"timeout")
	Global.emit_signal("repair_loaded")
	if current_bike:
		$CanvasLayer/BikeRepair.gen_bike()

func load_next_bike():
	current_bike = Global.repair_queue.pop_front()

func _on_Hallway_pressed():
	direction.x += 1


func _on_Tools_pressed():
	direction.x -= 1


func _on_Storage_pressed():
	direction.y += 1
