extends Node2D

@export var level_start_pos: Node2D

func _ready():
	GlobalAudioStreamPlayer.play_level_music()
