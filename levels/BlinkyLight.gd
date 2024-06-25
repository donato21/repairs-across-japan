extends SpotLight


func _ready():
	blink()

func blink():
	yield(get_tree().create_timer(rand_range(0.01,5)),"timeout")
	var tween = create_tween()
	tween.tween_property(self,"light_energy",0.3,.3)
	yield(tween,"finished")
	light_energy = 1.05
	blink()
