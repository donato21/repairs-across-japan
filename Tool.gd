extends Area2D


export var tool_name: String
var can_drag = false
onready var origin = global_position

func _ready():
	connect("mouse_entered",self,"mouse_entered")
	connect("mouse_exited",self,"mouse_exited")

func mouse_entered():
	can_drag = true
	scale = Vector2(1.1,1.1)

func mouse_exited():
	can_drag = false
	scale = Vector2(1,1)

func _input(_event):
	if Input.is_action_pressed("click") and can_drag:
		global_position = get_global_mouse_position()

func _process(_delta):
	if global_position != origin:
			if not Input.is_action_pressed("click"):
				global_position = lerp(global_position, origin, 0.3)
