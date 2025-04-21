class_name PuzzleButton extends Area2D

signal pressed
signal unpressed


@export var is_single_use: bool = false

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D


var _bodies_on_top := 0


func _ready() -> void:
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("pushable") or body is Player:
		pressed.emit()
		_bodies_on_top += 1
		animated_sprite.play("pressed")


func _on_body_exited(body: Node2D) -> void:
	if is_single_use:
		return

	if body.is_in_group("pushable") or body is Player:
		_bodies_on_top -= 1
		if _bodies_on_top == 0:
			unpressed.emit()
			animated_sprite.play("unpressed")
