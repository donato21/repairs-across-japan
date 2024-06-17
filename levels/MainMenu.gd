extends Control

export var starting_level: PackedScene
export var song: AudioStream

func _ready():
	if song != null:
		Global.play_music(song,9.4)

func _on_PlayButton_pressed():
	if starting_level != null:
		Global.play_button_click()
		Global.change_scene(starting_level)

func _on_OptionsButton_pressed():
	Global.play_button_click()
	$ColorRect.visible = true
	$ColorRect.modulate.a = 255
	yield(get_tree().create_timer(2),"timeout")
	$ColorRect.modulate.a = 0
	$ColorRect.visible = false
