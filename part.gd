extends Area


export var is_wheel: bool
var meshis: Array

func _ready():
	for child in get_children():
		if child is MeshInstance:
			meshis.append(child)

func hide_all():
	for meshi in meshis:
		meshi.hide()

func get_index():
	for i in meshis.size():
		if meshis[i].visible:
			return i
	if is_wheel:
		return 3

func show_index(index: int):
	hide_all()
	meshis[index].show()
