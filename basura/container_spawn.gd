extends Node2D

@onready var spawn_pos: Button = $Spawn
@export var container_to_spawn:Resource
var container_scene:PackedScene=preload("res://Joel/scenes/container.tscn")

var container_in_spawner:bool

func spawn_container():
	if container_to_spawn.group == "servidores":
		var duplicate_res = container_to_spawn.duplicate()
		var new_container = container_scene.instantiate()
		add_child(new_container)
		new_container.global_position = spawn_pos.global_position + spawn_pos.pivot_offset
		new_container.set_info(duplicate_res)

func _on_spawn_pressed() -> void:
	print("CLICK")
	if container_in_spawner:
		return
	else:
		spawn_container()


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.get_parent().is_in_group("item"):
		container_in_spawner = true


func _on_area_2d_area_exited(area: Area2D) -> void:
	if area.get_parent().is_in_group("item"):
		container_in_spawner = false
