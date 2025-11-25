extends CharacterBody2D

@onready var _animated_sprite = $AnimatedSprite2D

func _ready():
	_animated_sprite.play("enemy_run")

func _on_hurt_player_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		get_tree().change_scene_to_file("res://scenes/menu.tscn")
