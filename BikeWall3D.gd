extends Spatial

var bike: BikeResource
onready var parts: Array = [$FWheel,$BWheel]
var current_part: Area
var hover: bool = false

func _ready():
	for part in parts:
		var part_area: Area = part
		part_area.connect("mouse_entered",self,"mouse_entered",[part])
		part_area.connect("mouse_exited",self,"mouse_exited",[part])
	if Global.bike_queue != null and Global.bike_queue.size() > 0:
		bike = Global.bike_queue[0]
		assemble_bike()

func _input(event):
	if event is InputEventMouseButton and bike != null and Global.player_hand.size() > 0:
		if event.is_pressed() and event.button_index == BUTTON_LEFT and current_part != null:
			if current_part.is_wheel:
				if current_part.get_index() == 1 and Global.player_hand[0].name == "pump":
					Global.play_pump()
					current_part.show_index(0)
					if current_part == $FWheel:
						bike.front_tire = 0
					else:
						bike.back_tire = 0
				elif current_part.get_index() == 2 and Global.player_hand[0].name == "wrench":
					Global.play_wrench()
					current_part.hide_all()
					if current_part == $FWheel:
						bike.front_tire = 3
					else:
						bike.back_tire = 3
				elif current_part.get_index() == 3 and Global.player_hand[0].name == "wheel":
					Global.play_wrench()
					current_part.show_index(0)
					if current_part == $FWheel:
						bike.front_tire = 0
					else:
						bike.back_tire = 0
			check_fixed()

func check_fixed():
	if bike.front_tire == 0 and bike.back_tire == 0:
		yield(get_tree().create_timer(0.5),"timeout")
		Global.emit_signal("bike_repaired")
		Global.bike_queue.pop_front()
		Global.play_bike()
		self.hide()
		# next_bike()
		if Global.bike_queue.size() == 0:
			Global.emit_signal("repairs_done")
		else:
			yield(get_tree().create_timer(0.5),"timeout")
			bike = Global.bike_queue[0]
			assemble_bike()
			self.show()

func assemble_bike():
	$Body.get_mesh().get_material().set_albedo(bike.color)
	if bike.chain:
		$Chain.visible = true
	if bike.gear:
		$Gear.visible = true
	# Tires
	if bike.front_tire == 0:
		$FWheel/New.visible = true
	elif bike.front_tire == 1:
		$FWheel/Flat.visible = true
	elif bike.front_tire == 2:
		$FWheel/Dented.visible = true
	if bike.back_tire == 0:
		$BWheel/New.visible = true
	elif bike.back_tire == 1:
		$BWheel/Flat.visible = true
	elif bike.back_tire == 2:
		$BWheel/Dented.visible = true

func mouse_entered(area: Area):
	var mat = find_mat(area)
	if mat != null:
		#mat.set_albedo(Color.yellow)
		mat.set_flag(0,true)
		current_part = area
		hover = true

func mouse_exited(area: Area):
	var mat = find_mat(area)
	if mat != null:
		#mat.set_albedo(Color.white)
		mat.set_flag(0,false)
		current_part = null
		hover = false

func find_mat(area: Area):
	var visible_child: MeshInstance
	for child in area.get_children():
		if child.is_visible() and child is MeshInstance:
			visible_child = child
	if visible_child != null:
		if visible_child.get_mesh().get_material() != null:
			return visible_child.get_mesh().get_material()
		else:
			return visible_child.get_active_material(0)
	else:
		return null
