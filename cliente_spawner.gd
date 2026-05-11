extends Node2D

var cliente_scene:PackedScene=preload("res://scenes/cliente.tscn")

@export var cliente_resource:Resource

@onready var spawn_pos: ColorRect = $SpawnPos

func _ready() -> void:
	spawn_cliente()

func spawn_cliente():
	var duplicate_res=cliente_resource.duplicate()
	var new_cliente=cliente_scene.instantiate()
	add_child(new_cliente)
	ClienteManager.clientes.append(new_cliente)
	new_cliente.global_position=spawn_pos.global_position
	new_cliente.set_info(cliente_resource)
	#print(ClienteManager.clientes[0].customer.name)
