extends Node2D


var current_visible: Sprite

func hide_visible():
	$AnimationPlayer.play("slide_out")
	yield(get_tree().create_timer(0.5),"timeout")
	if current_visible != null:
		current_visible.hide()
		current_visible = null

func random():
	$AnimationPlayer.play("slide_in")
	var index: int = rand_range(0,8)
	$Random.get_child(index).show()
	current_visible = $Random.get_child(index)

func mouse():
	$AnimationPlayer.play("slide_in")
	$Mouse.get_child(0).show()
	current_visible = $Mouse.get_child(0)

func connor_1():
	$AnimationPlayer.play("slide_in")
	$Connor.get_child(0).show()
	current_visible = $Connor.get_child(0)

func connor_2():
	$AnimationPlayer.play("slide_in")
	$Connor.get_child(1).show()
	current_visible = $Connor.get_child(1)

func connor_3():
	$AnimationPlayer.play("slide_in")
	$Connor.get_child(2).show()
	current_visible = $Connor.get_child(2)

func chris_1():
	$AnimationPlayer.play("slide_in")
	$Chris.get_child(0).show()
	current_visible = $Chris.get_child(0)

func chris_2():
	$AnimationPlayer.play("slide_in")
	$Chris.get_child(1).show()
	current_visible = $Chris.get_child(1)

func chris_3():
	$AnimationPlayer.play("slide_in")
	$Chris.get_child(2).show()
	current_visible = $Chris.get_child(2)
