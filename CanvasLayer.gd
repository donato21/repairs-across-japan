extends CanvasLayer

var fade_time = 1

func _ready():
	$Dialog.hide()
	$ColorRect.show()
	fadein()

func fadeout():
	$Tween.stop_all()
	$Tween.interpolate_property($ColorRect,"modulate:a",$ColorRect.modulate.a,1,fade_time)
	$Tween.start()
	yield($Tween,"tween_completed")
	Global.emit_signal("fade","out")

func fadein():
	$Tween.stop_all()
	$Tween.interpolate_property($ColorRect,"modulate:a",$ColorRect.modulate.a,0,fade_time)
	$Tween.start()
	yield($Tween,"tween_completed")
	Global.emit_signal("fade","in")

func clear():
	$Dialog/Text.text = ""

func set_title(text: String):
	$Dialog/Title.text = text

func show_rect():
	$Dialog.show()

func set_text(text: String):
	$Dialog/Text.text = text

func hide_rect():
	$Dialog.hide()
