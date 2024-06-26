extends Spatial

export var spook_time = 30
export var state_time: int = 10
var stop: bool = false
var current_pose: int
var current_state: int
var timer: Timer

func _ready():
	timer = Timer.new()
	timer.set_wait_time(state_time)
	get_tree().get_root().add_child(timer)
	Global.connect("repairs_done",self,"repairs_done")
	Global.connect("audio_scare",self,"audio_scare")
	Global.connect("start_scare",self,"forced_scare")
	if Global.day > 1 or Global.day == 0:
		yield(get_tree().create_timer(spook_time / spook_time),"timeout")
		start_scares()

func _input(_event):
	if Input.is_action_just_pressed("flash") and current_pose != null:
		$SpotLight.show()
		mouse_die()
		yield(get_tree().create_timer(0.5),"timeout")
		$SpotLight.hide()

func start_scares():
	var time = rand_range(8, spook_time * 2)
	print(time)
	yield(get_tree().create_timer(time),"timeout")
	if randi() % 2 == 1:
		show_mouse()
		stop = true
	$AudioStreamPlayer3D.set_stream(Global.get_mouse_sfx())
	print("Mouse said something!")
	$AudioStreamPlayer3D.play()
	yield($AudioStreamPlayer3D,"finished")
	if not stop:
		start_scares()

func audio_scare():
	$AudioStreamPlayer3D.set_stream(Global.get_mouse_sfx())
	print("Mouse said something!")
	$AudioStreamPlayer3D.play()
	yield($AudioStreamPlayer3D,"finished")

func forced_scare():
	show_mouse()

func show_mouse():
	current_pose = 1 + randi() % 3
	change_current_state(0)

func mouse_die():
	timer.stop()
	hide_mice()
	$AudioStreamPlayer3D.set_stream(Global.jumpscare_sfx)
	$AudioStreamPlayer3D.play()
	yield($AudioStreamPlayer3D,"finished")
	Global.emit_signal("mouse_dead")

func change_current_state(index: int):
	current_state = index
	show_state(index)
	timer.start()
	yield(timer,"timeout")
	var new_index = index + 1
	if new_index == 3:
		jumpscare()
	elif new_index < 3:
		change_current_state(index + 1)

func jumpscare():
	current_state = -1
	current_pose = -1
	Global.play_jumpscare()
	# TODO add jumpscare

func show_state(index: int):
	hide_mice()
	get_child(current_pose).get_child(index).show()

func hide_mice():
	print(get_child(current_pose))
	for child in get_child(current_pose).get_children():
		child.hide()

func repairs_done():
	stop = true
