extends Node

var music: AudioStreamPlayer
var ambience: AudioStreamPlayer
var voice: AudioStreamPlayer
var sfx: AudioStreamPlayer
var sfx2: AudioStreamPlayer
var overlay: CanvasLayer
var dialog: CanvasLayer
var main: Node2D
var game_script: Dictionary
var current_client: ClientResource
var bike_queue: Array

var click_sfx: AudioStream = load("res://assets/sfx/click.wav")
var page_sfx: AudioStream = load("res://assets/sfx/zapsplat_office_design_folder_a2_size_plastic_page_turn_005_99838.mp3")
var tool_sfx: AudioStream = load("res://assets/sfx/zapsplat_foley_clothes_running_shorts_polyester_single_leg_move_walk_movement_018_31271.wav")
var bike_sfx: AudioStream = load("res://assets/sfx/zapsplat_transport_bicycle_bell_ring_001_14220.wav")
var pump_sfx: AudioStream = load("res://assets/sfx/transport_bicycle_hand_pump_operating_slow_speed_handle_piston_end.wav")
var wrench_sfx: AudioStream = load("res://assets/sfx/zapsplat_indutrial_wrench_adjustable_plastic_handle_set_down_metal_tool_box_002_56394.wav")
var walk_sfx: AudioStream = load("res://assets/sfx/Running on Gravel.wav")
var mouse_sfx: Array = ["res://assets/sfx/mouse/dosteroidsreally.wav","res://assets/sfx/mouse/ghostinmy.wav","res://assets/sfx/mouse/help.wav","res://assets/sfx/mouse/ithinkarrested.wav","res://assets/sfx/mouse/mymomtold.wav","res://assets/sfx/mouse/nice.wav","res://assets/sfx/mouse/werebackin.wav","res://assets/sfx/mouse/what.wav","res://assets/sfx/mouse/whenishakethis.wav","res://assets/sfx/mouse/yeah.wav"]
var jumpscare_sfx: AudioStream = load("res://assets/sfx/mouse/jumpscare/scream.wav")
var repair_scene: PackedScene = load("res://levels/RepairGarage.tscn")
var player_name = ""
var currency = " ¥"
var money = 0
var player_hand: Array = []
var day = 0

signal fade # Triggers every tween end of overlay's color rect modulation
signal hub_loaded # Triggers on hub load
signal dialog_interrupt # Handles dialog state
signal next_client
signal show_wo
signal wo_approved # Triggers on work order approval
signal hide_client 
signal load_repair
signal repair_loaded # Triggers on repair garage load
signal looking_at_tools # Triggers on looking at tools in garage
signal looking_at_bike # Triggers on looking at bike in garage
signal looking_at_hall # Triggers on looking at hall in garage
signal looking_at_storage # Triggers on looking at storage in garage
signal bike_repaired  # Triggers on bike repair done
signal repairs_done  # Triggers on all repairs for all bikes done
signal audio_scare # Triggers repair garage mouse audio
signal mouse_dead # Triggers when mouse gets blasted
signal start_scare # Triggers forced scare

func _ready():
	rand_seed(Time.get_unix_time_from_system())
	OS.set_window_maximized(true)
	connect("load_repair",self,"change_scene",[repair_scene])
	if overlay == null:
		overlay = load("res://CanvasLayer.tscn").instance()
		get_tree().get_root().call_deferred("add_child", overlay)

func change_scene(scene : PackedScene):
	if main != null:
		if main.get_child_count() != 0:
			overlay.fadeout()
			yield(self,"fade")
			main.get_child(0).queue_free()
			yield(main,"child_exiting_tree")
			main.add_child(scene.instance())
			yield(get_tree(),"idle_frame")
			overlay.fadein()
		else:
			overlay.fadeout()
			yield(self,"fade")
			main.add_child(scene.instance())
			yield(get_tree(),"idle_frame")
			overlay.fadein()

func play_music(song: AudioStream, time = 0):
	if music != null:
		music.set_stream(song)
		music.play(time)

func play_sfx(effect: AudioStream, time = 0):
	if sfx != null:
		if not sfx.is_playing():
			sfx.set_stream(effect)
			sfx.pitch_scale = rand_range(0.8,1.2)
			sfx.play(time)
		elif not sfx2.is_playing():
			sfx2.set_stream(effect)
			sfx2.pitch_scale = rand_range(0.8,1.2)
			sfx2.play(time)
		else:
			if sfx.get_playback_position() > sfx2.get_playback_position():
				sfx.set_stream(effect)
				sfx.pitch_scale = rand_range(0.8,1.2)
				sfx.play(time)
			else:
				sfx2.set_stream(effect)
				sfx2.pitch_scale = rand_range(0.8,1.2)
				sfx2.play(time)

func play_button_click():
	play_sfx(click_sfx)

func play_paper():
	play_sfx(page_sfx)

func play_tool():
	play_sfx(tool_sfx)

func play_bike():
	play_sfx(bike_sfx)

func play_pump():
	play_sfx(pump_sfx)

func play_wrench():
	play_sfx(wrench_sfx)

func play_walk():
	play_sfx(walk_sfx)

func get_mouse_sfx():
	if mouse_sfx.size() > 0:
		return load(mouse_sfx[int(rand_range(0,mouse_sfx.size()))])

func play_jumpscare():
	play_sfx(jumpscare_sfx)
