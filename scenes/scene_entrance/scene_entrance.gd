class_name SceneEntrance extends Area2D


## Path to the next scene to load
@export var next_scene: String
## Position where player should spawn in next scene
@export var player_spawn_position: Vector2


func _on_body_entered(body: Node2D) -> void:
	if not body is Player:
		return

	SceneManager.player_spawn_position = player_spawn_position
	get_tree().change_scene_to_file.call_deferred(next_scene)


func _on_body_exited(body: Node2D) -> void:
	pass # Replace with function body.
