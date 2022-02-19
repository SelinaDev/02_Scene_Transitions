class_name SceneChanger1
extends CanvasLayer

export (String, FILE, "*.tscn") var target_scene
export (float) var fade_duration := 0.5

onready var color_rect: ColorRect = $ColorRect
onready var tween: Tween = $Tween


func _ready() -> void:
	tween.interpolate_property(color_rect, "modulate:a", 1, 0, fade_duration)
	tween.interpolate_callback(color_rect, fade_duration, "hide")
	tween.start()


func transition_to(_next_scene := target_scene) -> void:
	color_rect.show()
	tween.interpolate_property(color_rect, "modulate:a", 0, 1, fade_duration)
	tween.start()
	yield(tween, "tween_all_completed")
	get_tree().change_scene(_next_scene)
