extends CharacterBody2D

@onready var _animated_sprite = $AnimatedSprite2D
@onready var _animation_player = $AnimatedSprite2D/AnimationPlayer
@onready var _audio_player = $AudioStreamPlayer2D
@onready var _audio_player_2 = $AudioStreamPlayer2D2

const FILE_BEGIN = "res://scenes/level_0"

@export var speed = 100
var gravity = 5
var jumpspeed = -250
var health = 3
var amount = 1
var isHit = false
var can_control: bool = true
var can_enter_portal := false

func _physics_process(_delta):
	if not can_control: return
	if not is_on_floor():
		velocity.y += gravity
	else:
		velocity.y = 0
	
	if Input.is_action_just_pressed("move_up") and is_on_floor():
		velocity.y = jumpspeed
	
	if Input.is_action_pressed("move_left"):
		velocity.x = -speed
	elif Input.is_action_pressed("move_right"):
		velocity.x = speed
	else:
		velocity.x = 0
	move_and_slide()

func _process(_delta):
	var is_moving_right = Input.is_action_pressed("move_right")
	var is_jumping = not is_on_floor()
	var is_moving_left = Input.is_action_pressed("move_left")
	var is_attacking = Input.is_action_pressed("hit")
	
	if Input.is_action_just_pressed("hit") and can_enter_portal:
		await get_tree().create_timer(2).timeout
		_change_scene()
	if isHit:
		_animated_sprite.play("hit")
	if is_jumping:
		_audio_player.play()
		_animated_sprite.play("jump")
	elif is_moving_right:
		_animated_sprite.play("run")
		_animated_sprite.flip_h = false
	elif is_moving_left:
		_animated_sprite.play("run")
		_animated_sprite.flip_h = true
	elif is_attacking:
		_audio_player_2.play()
		_animated_sprite.play("attack")
	else:
		_animated_sprite.play("still")

func hit():
	health -= 1
	isHit = true

func hurt():
	health -= amount
	_animation_player.play("flash")

func handle_danger() -> void:
	print("Dead")
	visible = false
	can_control = false
	
	await get_tree().create_timer(1).timeout
	reset_player()
	
func reset_player() -> void:
	visible = true
	can_control = true

func _change_scene():
	var current_scene_file = get_tree().current_scene.scene_file_path
	var next_level_number = current_scene_file.to_int() + 1
	
	var next_level_path = FILE_BEGIN + str(next_level_number) + ".tscn"
	get_tree().change_scene_to_file(next_level_path)


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menu.tscn")
