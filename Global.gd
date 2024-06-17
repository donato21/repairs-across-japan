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
var repair_queue: Array

var click_sfx: AudioStream = load("res://assets/sfx/click.wav")
var page_sfx: AudioStream = load("res://assets/sfx/zapsplat_office_design_folder_a2_size_plastic_page_turn_005_99838.mp3")
var repair_scene: PackedScene = load("res://levels/RepairGarage.tscn")
var player_name = ""
var currency = " ¥"

signal fade
signal hub_loaded
signal dialog_interrupt
signal next_client
signal show_wo
signal wo_approved
signal hide_client
signal load_repair
signal repair_loaded

func _ready():
	connect("load_repair",self,"change_scene",[repair_scene])

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
	music.set_stream(song)
	music.play(time)

func play_sfx(effect: AudioStream, time = 0):
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
