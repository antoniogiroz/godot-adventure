class_name Player extends CharacterBody2D

## Movement speed in pixels per second
@export var speed: float = 100.0
## Strength applied when pushing objects
@export var push_strength: float = 300.0

@onready var _animated_sprite: AnimatedSprite2D = $AnimatedSprite2D


func _ready() -> void:
	if SceneManager.player_spawn_position:
		position = SceneManager.player_spawn_position


func _physics_process(delta: float) -> void:
	var direction := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction * speed

	_update_animation()
	_handle_collisions()

	move_and_slide()


func _update_animation() -> void:
	if velocity.x > 0:
		_animated_sprite.play("move_right")
	elif velocity.x < 0:
		_animated_sprite.play("move_left")
	elif velocity.y > 0:
		_animated_sprite.play("move_down")
	elif velocity.y < 0:
		_animated_sprite.play("move_up")
	else:
		_animated_sprite.stop()


func _handle_collisions() -> void:
	var collision = get_last_slide_collision()
	if not collision:
		return

	var collider := collision.get_collider()
	if collider and collider.is_in_group("pushable"):
		_push_object(collider, collision.get_normal())


func _push_object(object: Node, normal: Vector2) -> void:
	if object.has_method("apply_central_force"):
		object.apply_central_force(-normal * push_strength)
