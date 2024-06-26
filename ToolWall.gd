extends Spatial

var hover = false
var current_tool: Area
var equipped_tool: Area
onready var tools: Array = [$Pump, $Wrench]

func _ready():
	for child in tools:
		var tool_area: Area = child
		tool_area.connect("mouse_entered",self,"on_mouse_entered",[tool_area])
		tool_area.connect("mouse_exited",self,"on_mouse_exited",[tool_area])
	if Global.day <= 1:
		$Wrench.hide()

func on_mouse_entered(toola: Area):
	var meshi = toola.get_child(1)
	if meshi != null:
		meshi.get_mesh().get_material().set_flag(0,true)
		hover = true
		current_tool = toola

func on_mouse_exited(toola: Area):
	var meshi = toola.get_child(1)
	if meshi != null:
		if toola != equipped_tool:
			meshi.get_mesh().get_material().set_flag(0,false)
		hover = false
		current_tool = null

func _input(event):
	if event is InputEventMouseButton:
		if event.is_pressed() and event.button_index == BUTTON_LEFT:
			if hover and equipped_tool == null:
				equip(current_tool)
			elif hover and equipped_tool != null:
				unequip(equipped_tool)

func equip(toola: Area):
	Global.play_tool()
	equipped_tool = toola
	Global.player_hand.append(toola.resource)
	toola.get_child(1).get_mesh().get_material().set_flag(0,true)
	$CanvasLayer/Sprite.set_texture(toola.resource.sprite)

func unequip(toola: Area):
	Global.play_tool()
	equipped_tool = null
	Global.player_hand.erase(toola.resource)
	toola.get_child(1).get_mesh().get_material().set_flag(0,false)
	$CanvasLayer/Sprite.set_texture(Texture)

func swap(toola: Area, toolb: Area):
	# equip A unequip B
	unequip(toolb)
	equip(toola)
