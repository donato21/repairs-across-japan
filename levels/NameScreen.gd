extends Node2D

export var main_level: PackedScene

func _on_Button_pressed():
	Global.play_button_click()
	if $CanvasLayer/ColorRect/LineEdit.text != "" and $CanvasLayer/ColorRect/LineEdit.text != null:
		Global.player_name = $CanvasLayer/ColorRect/LineEdit.text
	if main_level != null:
		Global.change_scene(main_level)

func _input(_event):
	if Input.is_action_just_pressed("ui_accept"):
		Global.play_button_click()
		if $CanvasLayer/ColorRect/LineEdit.text != "" and $CanvasLayer/ColorRect/LineEdit.text != null:
			Global.player_name = $CanvasLayer/ColorRect/LineEdit.text
		if main_level != null:
			Global.change_scene(main_level)
