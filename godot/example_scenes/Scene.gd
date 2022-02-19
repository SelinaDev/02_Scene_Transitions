extends Control

signal scene_change_requested(next_scene)

export (String, FILE, "*.tscn") var next_scene


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		emit_signal("scene_change_requested", next_scene)
