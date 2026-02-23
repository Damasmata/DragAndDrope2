extends Node2D

@onready var spawn_pos: ColorRect = %SpawnPos

@export var item_to_spawn:Resource
var item_scene:PackedScene = preload("res://scenes/item_scene.tscn")

var item_in_spawner:bool = false

func spawn_item():
	var duplicate_res = item_to_spawn.duplicate()
	var new_item = item_scene.instantiate() 
	add_child(new_item)
	new_item.global_position = spawn_pos.global_position + spawn_pos.pivot_offset
	new_item.initialpos = new_item.global_position
	new_item.new_pos = new_item.initialpos
	new_item.set_info(duplicate_res)
	print("asd: ", new_item.initialpos)
	

func _on_spawn_pressed() -> void:
	if item_in_spawner:
		return
	else:
		spawn_item()


func _on_spawn_area_area_entered(area: Area2D) -> void:
	if area.get_parent().is_in_group("item"):
		item_in_spawner = true


func _on_spawn_area_area_exited(area: Area2D) -> void:
	if area.get_parent().is_in_group("item"):
		item_in_spawner = false
