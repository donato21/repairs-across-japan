extends Node2D


func gen_bike(bike_res: BikeResource):
	for child in $Bike/BackTires.get_children():
		child.hide()
	for child in $Bike/Tires.get_children():
		child.hide()
	$Bike/Body.set_modulate(bike_res.color)
	$Bike/Chain.visible = bike_res.chain
	if bike_res.back_tire == 0:
		$Bike/BackTires/Tire.show()
	elif bike_res.back_tire == 1:
		$Bike/BackTires/Flat.show()
	else:
		$Bike/BackTires/Dented.show()
	if bike_res.front_tire == 0:
		$Bike/Tires/Tire.show()
	elif bike_res.back_tire == 1:
		$Bike/Tires/Flat.show()
	else:
		$Bike/Tires/Dented.show()

