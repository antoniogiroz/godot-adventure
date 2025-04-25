class_name NPC extends StaticBody2D

@export var dialogue_lines: Array[String] = []

@onready var canvas_layer: CanvasLayer = $CanvasLayer
@onready var dialog_label: Label = %DialogLabel


var can_interact: bool = false


var _dialogue_index = 0

func _ready() -> void:
	canvas_layer.visible = false


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("interact") and can_interact:
		if _dialogue_index < dialogue_lines.size():
			canvas_layer.visible = true
			get_tree().paused = true

			dialog_label.text = dialogue_lines[_dialogue_index]
			_dialogue_index += 1

		else:
			canvas_layer.visible = false
			get_tree().paused = false
			_dialogue_index = 0
