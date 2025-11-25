extends Area2D

@onready var _animated_sprite = $AnimatedSprite2D

var player_in_portal := false

const FILE_BEGIN = "res://scenes/level_0"

func _ready():
	_animated_sprite.play("default")

func _on_body_entered(body):
	if body.is_in_group("Player"):
		player_in_portal = true
		body.can_enter_portal = true

func _on_body_exited(body):
	if body.is_in_group("Player"):
		player_in_portal = false
		body.can_enter_portal = false
