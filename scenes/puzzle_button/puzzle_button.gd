class_name PuzzleButton extends Area2D

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D


var _bodies_on_top := 0


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("pushable") or body is Player:
		_bodies_on_top += 1
		animated_sprite.play("pressed")



func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("pushable") or body is Player:
		_bodies_on_top -= 1
		if _bodies_on_top == 0:
			animated_sprite.play("unpressed")
