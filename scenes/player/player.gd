class_name Player extends CharacterBody2D

@export var speed: float = 100.0
@export var push_strength: float = 300.0

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D


func _ready() -> void:
	if SceneManager.player_spawn_position:
		position = SceneManager.player_spawn_position


func _physics_process(delta: float) -> void:
	var direction := Input.get_vector("move_left", "move_right", "move_up", "move_down")

	velocity = direction * speed

	_animate_player()

	_push_when_collide()

	move_and_slide()


func _animate_player() -> void:
	if velocity.x > 0:
		animated_sprite_2d.play("move_right")
	elif velocity.x < 0:
		animated_sprite_2d.play("move_left")
	elif velocity.y > 0:
		animated_sprite_2d.play("move_down")
	elif velocity.y < 0:
		animated_sprite_2d.play("move_up")
	else:
		animated_sprite_2d.stop()


func _push_when_collide() -> void:
	var collision = get_last_slide_collision()
	if not collision:
		return

	var collider_node = collision.get_collider()
	if collider_node.is_in_group("pushable"):
		var collision_normal := collision.get_normal()
		collider_node.apply_central_force(-collision_normal * push_strength)
