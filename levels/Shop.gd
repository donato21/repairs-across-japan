extends Node2D

var client: ClientResource

func _ready():
	yield(get_tree().create_timer(1),"timeout")
	Global.emit_signal("hub_loaded")
	Global.connect("show_wo",self,"show_wo")
	Global.day += 1

func hide_client():
	$Client.hide_visible()

func show_wo():
	if client != null:
		$Clipboard/Clipboard/WorkOrder.show_wo(client)
	$BikeWall.gen_bike(client.bike)

func hide_wo():
	$Clipboard/Clipboard/WorkOrder.hide()

func load_client(client_res: ClientResource):
	client = client_res
	if client_res.appearance == 0:
		$Client.random()
	elif client_res.appearance == 1:
		$Client.connor_1()
	elif client_res.appearance == 2:
		$Client.connor_2()
	elif client_res.appearance == 3:
		$Client.connor_3()
	elif client_res.appearance == 4:
		$Client.chris_1()
	elif client_res.appearance == 5:
		$Client.chris_2()
	elif client_res.appearance == 6:
		$Client.chris_3()
	elif client_res.appearance == 7:
		$Client.mouse()
