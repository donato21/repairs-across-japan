extends Node2D

var TIME = 0.2

func _on_HubMapButton_pressed():
	Global.play_paper()
	$Tween.stop_all()
	$Tween.interpolate_property($MapSprite,"position",$MapSprite.position, Vector2(0,0),TIME)
	yield(get_tree().create_timer(0.5),"timeout")
	$Tween.start()
	$HubMapButton.disabled = true

func _on_ExitMapButton_pressed():
	Global.play_paper()
	$AnimationPlayer.play("click")
	$Tween.stop_all()
	$Tween.interpolate_property($MapSprite,"position",$MapSprite.position, Vector2(0,1100),TIME)
	yield(get_tree().create_timer(0.5),"timeout")
	$Tween.start()
	yield($Tween,"tween_completed")
	$HubMapButton.disabled = false
