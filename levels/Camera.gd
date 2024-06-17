extends Spatial

var bobAmp: float = 0.15
var Speed2D: float = 16.0
var bobTime: float = 1.0
var originalOffset: Vector3
var returnTimer: float = 0
var returnDuration: float = 1.5
var offsetX = 1
var offsetY = 0

func _physics_process(delta):
	rotation_degrees.x = calculateBobOffset(offsetX * delta) * 10
	rotation_degrees.y = calculateBobOffset(offsetY * delta) * 10
	offsetX += 1
	offsetY += .5

func calculateBobOffset(t: float) -> float:
	return sin(t) * bobAmp
