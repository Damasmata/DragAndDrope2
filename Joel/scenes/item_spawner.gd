extends Node2D

@onready var spawn_pos: ColorRect = %SpawnPos

@export var item_to_spawn:Resource
var item_scene:PackedScene = preload("res://scenes/item_scene.tscn")
var container_scene:PackedScene=preload("res://Joel/scenes/container.tscn")
var salsa_scene:PackedScene = preload("res://scenes/salsa_scene.tscn")

var item_in_spawner:bool = false

func spawn_item():
	if item_to_spawn.group == "items dropeables":
		var duplicate_res = item_to_spawn.duplicate()
		var new_item = item_scene.instantiate()
		add_child(new_item)
		new_item.global_position = spawn_pos.global_position + spawn_pos.pivot_offset
		new_item.initialpos = new_item.global_position
		new_item.new_pos = new_item.initialpos
		new_item.set_info(duplicate_res)
		
	elif item_to_spawn.group == "servidores":
		var duplicate_res = item_to_spawn.duplicate()
		var new_container = container_scene.instantiate()
		get_parent().add_child.call_deferred(new_container)
		new_container.global_position = global_position
		new_container.set_info(duplicate_res)
		#new_container.name = container.name
		
	elif item_to_spawn.group == "salsa":
		var duplicate_res = item_to_spawn.duplicate()
		var new_salsa = salsa_scene.instantiate()
		add_child(new_salsa)
		new_salsa.global_position = spawn_pos.global_position + spawn_pos.pivot_offset
		new_salsa.initialpos = new_salsa.global_position
		new_salsa.new_pos = new_salsa.initialpos
		new_salsa.set_info(duplicate_res)
		#var duplicate_res = item_to_spawn.duplicate()
		#var new_extra = extra_scene.instantiate()
		#add_child(new_extra)
		#new_extra.global_position = spawn_pos.global_position + spawn_pos.pivot_offset
		#new_extra.initialpos = new_extra.global_position
		#new_extra.new_pos = new_extra.initialpos
		#new_extra.set_info(duplicate_res)
		#print("asd: ", new_extra.initialpos)
		#print(item_to_spawn.name)

func _on_spawn_pressed() -> void:
	if item_in_spawner:
		return
	else:
		spawn_item()

func _on_spawn_area_area_entered(area: Area2D) -> void:
	if area.get_parent().is_in_group("item") or area.get_parent().is_in_group("servidores") or area.get_parent().is_in_group("salsa"):
		item_in_spawner = true

func _on_spawn_area_area_exited(area: Area2D) -> void:
	if area.get_parent().is_in_group("item") or area.get_parent().is_in_group("servidores") or area.get_parent().is_in_group("salsa"):
		item_in_spawner = false
