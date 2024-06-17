extends Node2D

export var starting_scene: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	if starting_scene != null:
		Global.music = $MusicStream
		Global.ambience = $AmbienceStream
		Global.voice = $VoiceStream
		Global.sfx = $SFXStream
		Global.sfx2 = $SFXStream2
		Global.overlay = $CanvasLayer
		Global.main = $MainScene
		Global.dialog = $CanvasLayer
		
		Global.change_scene(starting_scene)

