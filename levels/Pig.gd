extends Node2D

export var money_sfx: AudioStream

func _on_Button_pressed():
	if not $AnimationPlayer.is_playing():
		if money_sfx != null:
			Global.play_sfx(money_sfx)
		$AnimationPlayer.play("show")


func _on_Button_mouse_entered():
	create_tween().tween_property($Pig,"scale",Vector2(1.01,1.01),0.2)


func _on_Button_mouse_exited():
	create_tween().tween_property($Pig,"scale",Vector2(1,1),0.2)
