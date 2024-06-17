extends Node2D

var checkboxes: Array
var bike: BikeResource

export var paper_sfx: AudioStream

func show_wo(client: ClientResource):
	bike = client.bike
	var bike_details: String
	$Control/VBoxContainer/HBoxContainer/Name.text = client.name
	
	if bike.chain:
		bike_details = "Has chain."
	else:
		bike_details = "Missing chain."
	$Control/VBoxContainer/HBoxContainer3/Chain.text = bike_details
	if bike.back_tire == 0:
		bike_details = "Back tire is fine."
	elif bike.back_tire == 1:
		bike_details = "Back tire is flat."
	else:
		bike_details = "Back tire is dented."
	$Control/VBoxContainer/HBoxContainer4/BackTire.text = bike_details
	if bike.front_tire == 0:
		bike_details = "Front tire is fine."
	elif bike.front_tire == 1:
		bike_details = "Front tire is flat."
	else:
		bike_details = "Front tire is dented."
	$Control/VBoxContainer/HBoxContainer5/FrontTire.text = bike_details
	$Control/VBoxContainer/Price.text = String(client.price) + Global.currency
	if paper_sfx != null:
		Global.play_sfx(paper_sfx)
	show()


func _on_NameCheckBox_toggled(button_pressed):
	if button_pressed and $Control/VBoxContainer/HBoxContainer3/ChainCheckBox.pressed and $Control/VBoxContainer/HBoxContainer4/BackTireCheckBox.pressed and $Control/VBoxContainer/HBoxContainer5/FrontTireCheckBox.pressed:
		$Control/Button.show()
	else:
		$Control/Button.hide()


func _on_ChainCheckBox_toggled(button_pressed):
	if button_pressed and $Control/VBoxContainer/HBoxContainer/NameCheckBox.pressed and $Control/VBoxContainer/HBoxContainer4/BackTireCheckBox.pressed and $Control/VBoxContainer/HBoxContainer5/FrontTireCheckBox.pressed:
		$Control/Button.show()
	else:
		$Control/Button.hide()


func _on_BackTireCheckBox_toggled(button_pressed):
	if button_pressed and $Control/VBoxContainer/HBoxContainer/NameCheckBox.pressed and $Control/VBoxContainer/HBoxContainer3/ChainCheckBox.pressed and $Control/VBoxContainer/HBoxContainer5/FrontTireCheckBox.pressed:
		$Control/Button.show()
	else:
		$Control/Button.hide()


func _on_FrontTireCheckBox_toggled(button_pressed):
	if button_pressed and $Control/VBoxContainer/HBoxContainer/NameCheckBox.pressed and $Control/VBoxContainer/HBoxContainer3/ChainCheckBox.pressed and $Control/VBoxContainer/HBoxContainer4/BackTireCheckBox.pressed:
		$Control/Button.show()
	else:
		$Control/Button.hide()


func _on_Button_pressed():
	Global.repair_queue.append(bike)
	Global.emit_signal("wo_approved")
	Global.play_paper()
	hide()
