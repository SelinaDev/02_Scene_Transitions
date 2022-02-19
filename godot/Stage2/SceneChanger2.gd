class_name SceneChanger2
extends CanvasLayer

export (String, FILE, "*.tscn") var target_scene
export (float) var fade_duration := 1.5

onready var color_rect: ColorRect = $ColorRect
onready var tween: Tween = $Tween
onready var shader_material: ShaderMaterial = color_rect.material


func _ready() -> void:
	shader_material.set_shader_param("invert", true)
	shader_material.set_shader_param("progress", 0)
	tween.interpolate_method(self, "_set_progress", 0, 1, fade_duration)
	tween.interpolate_callback(color_rect, fade_duration, "hide")
	tween.start()


func transition_to(_next_scene := target_scene) -> void:
	color_rect.show()
	shader_material.set_shader_param("invert", false)
	shader_material.set_shader_param("progress", 0)
	tween.interpolate_method(self, "_set_progress", 0, 1, fade_duration)
	tween.start()
	yield(tween, "tween_all_completed")
	get_tree().change_scene(_next_scene)


func _set_progress(progress: float) -> void:
	shader_material.set_shader_param("progress", progress)
