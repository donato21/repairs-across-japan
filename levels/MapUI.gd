extends Node2D

var TIME = 0.2
export var paper_sfx: AudioStream

func _on_HubMapButton_pressed():
	if paper_sfx != null:
		Global.play_sfx(paper_sfx)
	$Tween.stop_all()
	$Tween.interpolate_property($MapSprite,"position",$MapSprite.position, Vector2(0,0),TIME)
	yield(get_tree().create_timer(0.5),"timeout")
	$Tween.start()
	$HubMapButton.disabled = true

func _on_ExitMapButton_pressed():
	if paper_sfx != null:
		Global.play_sfx(paper_sfx)
	$AnimationPlayer.play("click")
	$Tween.stop_all()
	$Tween.interpolate_property($MapSprite,"position",$MapSprite.position, Vector2(0,1100),TIME)
	yield(get_tree().create_timer(0.5),"timeout")
	$Tween.start()
	yield($Tween,"tween_completed")
	$HubMapButton.disabled = false
