class_name SceneManager
extends Node

export (String, FILE, "*.tscn") var start_scene
export (float) var duration := 2.0

onready var back_viewport: Viewport = $BackLayer/Viewport
onready var front_viewport: Viewport = $FrontLayer/Viewport
onready var front_scene: Node = $FrontLayer/Viewport/ColorRect
onready var shader_material: ShaderMaterial = $FrontLayer.material
onready var tween: Tween = $Tween


func _change_scene(next_scene: String) -> void:
	var back_scene: Node = load(next_scene).instance()
	back_viewport.add_child(back_scene)
	tween.interpolate_method(self, "_set_transition_progress", 0, 1, duration)
	tween.start()
	yield(tween, "tween_all_completed")
	back_viewport.remove_child(back_scene)
	front_scene.queue_free()
	front_scene = back_scene
	front_viewport.add_child(front_scene)
	shader_material.set_shader_param("progress", 0)
	front_scene.connect("scene_change_requested", self, "_change_scene")


func _ready() -> void:
	shader_material.set_shader_param("progress", 0)
	_change_scene(start_scene)


func _set_transition_progress(progress: float) -> void:
	shader_material.set_shader_param("progress", progress)
