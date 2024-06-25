extends Spatial


export var music: AudioStream
var direction: Vector2 = Vector2()
onready var current_camera = $CameraManager/BikeCamera
onready var buttons: Array = [$CanvasLayer/Storage, $CanvasLayer/Tools, $CanvasLayer/Hallway]

func _ready():
	if music != null and Global.music != null:
		Global.play_music(music)
	yield(get_tree().create_timer(1),"timeout")
	Global.emit_signal("repair_loaded")
	for item in buttons:
		var button: Button = item
		item.connect("mouse_entered",self,"button_mouse_entered",[item])
		item.connect("mouse_exited",self,"button_mouse_exited",[item])

func button_mouse_entered(button: Button):
	button.modulate = Color.yellow

func button_mouse_exited(button: Button):
	button.modulate = Color.white

func _on_Hallway_pressed():
	Global.play_walk()
	if current_camera == $CameraManager/ToolsCamera:
		Global.overlay.fadeout()
		yield(Global,"fade")
		$CameraManager/BikeCamera.make_current()
		current_camera = $CameraManager/BikeCamera
		$CanvasLayer/Tools.show()
		$CanvasLayer/Storage.show()
		Global.overlay.fadein()
		Global.emit_signal("looking_at_bike")
	elif current_camera == $CameraManager/BikeCamera:
		Global.overlay.fadeout()
		yield(Global,"fade")
		$CameraManager/HallCamera.make_current()
		current_camera = $CameraManager/HallCamera
		$CanvasLayer/Storage.hide()
		$CanvasLayer/Hallway.hide()
		Global.overlay.fadein()
		Global.emit_signal("looking_at_hall")

func _on_Tools_pressed():
	Global.play_walk()
	if current_camera == $CameraManager/BikeCamera:
		Global.overlay.fadeout()
		yield(Global,"fade")
		$CameraManager/ToolsCamera.make_current()
		current_camera = $CameraManager/ToolsCamera
		$CanvasLayer/Tools.hide()
		$CanvasLayer/Storage.hide()
		Global.overlay.fadein()
		Global.emit_signal("looking_at_tools")
	elif current_camera == $CameraManager/HallCamera:
		Global.overlay.fadeout()
		yield(Global,"fade")
		$CameraManager/BikeCamera.make_current()
		current_camera = $CameraManager/BikeCamera
		$CanvasLayer/Storage.show()
		$CanvasLayer/Hallway.show()
		Global.overlay.fadein()
		Global.emit_signal("looking_at_bike")
		

func _on_Storage_pressed():
	Global.play_walk()
	if current_camera == $CameraManager/BikeCamera:
		Global.overlay.fadeout()
		yield(Global,"fade")
		$CameraManager/StorageCamera.make_current()
		current_camera = $CameraManager/StorageCamera
		$CanvasLayer/Tools.hide()
		$CanvasLayer/Hallway.hide()
		Global.overlay.fadein()
		Global.emit_signal("looking_at_storage")
	elif current_camera == $CameraManager/StorageCamera:
		Global.overlay.fadeout()
		yield(Global,"fade")
		$CameraManager/BikeCamera.make_current()
		current_camera = $CameraManager/BikeCamera
		$CanvasLayer/Tools.show()
		$CanvasLayer/Hallway.show()
		Global.overlay.fadein()
		Global.emit_signal("looking_at_bike")
		
