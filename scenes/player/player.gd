class_name Player extends CharacterBody2D

## Movement speed in pixels per second
@export var speed: float = 100.0
## Strength applied when pushing objects
@export var push_strength: float = 300.0

@onready var _animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var interaction_area: Area2D = $InteractionArea


func _ready() -> void:
	interaction_area.body_entered.connect(_on_interaction_area_entered)
	interaction_area.body_exited.connect(_on_interaction_area_exited)
	if SceneManager.player_spawn_position:
		position = SceneManager.player_spawn_position


func _physics_process(delta: float) -> void:
	_move_player()
	_push_blocks()
	move_and_slide()


func _move_player() -> void:
	var direction := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction * speed

	if velocity.x > 0:
		_animated_sprite.play("move_right")
		interaction_area.position = Vector2(5, 2)
	elif velocity.x < 0:
		_animated_sprite.play("move_left")
		interaction_area.position = Vector2(-5, 2)
	elif velocity.y > 0:
		_animated_sprite.play("move_down")
		interaction_area.position = Vector2(0, 8)
	elif velocity.y < 0:
		_animated_sprite.play("move_up")
		interaction_area.position = Vector2(0, -4)
	else:
		_animated_sprite.stop()


func _push_blocks() -> void:
	var collision = get_last_slide_collision()
	if not collision:
		return

	var collider := collision.get_collider()
	if collider and collider.is_in_group("pushable"):
		_push_object(collider, collision.get_normal())


func _push_object(object: Node, normal: Vector2) -> void:
	if object.has_method("apply_central_force"):
		object.apply_central_force(-normal * push_strength)


func _on_interaction_area_entered(body: Node2D) -> void:
	if body.is_in_group("interactable"):
		body.can_interact = true


func _on_interaction_area_exited(body: Node2D) -> void:
	if body.is_in_group("interactable"):
		body.can_interact = false
