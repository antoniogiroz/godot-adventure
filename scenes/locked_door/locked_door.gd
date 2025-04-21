extends StaticBody2D

@export var buttons_needed: int = 1


@onready var collision_shape: CollisionShape2D = $CollisionShape2D


var buttons_pressed = 0


func _on_button_pressed() -> void:
	buttons_pressed += 1
	if buttons_pressed >= buttons_needed:
		visible = false
		collision_shape.set_deferred("disabled", true)


func _on_button_unpressed() -> void:
	buttons_pressed -= 1
	if buttons_pressed < buttons_needed:
		visible = true
		collision_shape.set_deferred("disabled", false)
