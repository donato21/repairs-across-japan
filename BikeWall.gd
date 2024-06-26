extends Node2D

func _ready():
	Global.connect("wo_approved",$Wall,"hide")

func gen_bike(bike_res: BikeResource):
	for child in $Wall/Bike/BackTires.get_children():
		child.hide()
	for child in $Wall/Bike/Tires.get_children():
		child.hide()
	$Wall/Bike/Body.set_modulate(bike_res.color)
	$Wall/Bike/Chain.visible = bike_res.chain
	if bike_res.back_tire == 0:
		$Wall/Bike/BackTires/Tire.show()
	elif bike_res.back_tire == 1:
		$Wall/Bike/BackTires/Flat.show()
	else:
		$Wall/Bike/BackTires/Dented.show()
	if bike_res.front_tire == 0:
		$Wall/Bike/Tires/Tire.show()
	elif bike_res.back_tire == 1:
		$Wall/Bike/Tires/Flat.show()
	else:
		$Wall/Bike/Tires/Dented.show()


func _on_ExitButton_pressed():
	$Wall/Control/AnimationPlayer.play("press")
	$Wall.hide()


func _on_Button_pressed():
	if $Wall.visible:
		$Wall.hide()
	else:
		$Wall.show()
	pass # Replace with function body.
