extends Node2D

var cliente_scene:PackedScene=preload("res://scenes/cliente.tscn")

@export var cliente_resource:Resource

@onready var spawn_pos: ColorRect = $SpawnPos

@export var _clientes_del_dia:ResourceGroup
var clientes_del_dia:Array[Resource]=[]

@onready var timer: Timer = $Timer

func _ready() -> void:
	_clientes_del_dia.load_all_into(clientes_del_dia)
	#_clientes_del_dia.load_all_into(ClienteManager.clientes)
	for clientela in clientes_del_dia:
		spawn_cliente(clientela)

func spawn_cliente(_cliente:Resource):
	var duplicate_res=_cliente.duplicate()
	var new_cliente=cliente_scene.instantiate()
	add_child(new_cliente)
	ClienteManager.clientes.append(new_cliente)
	new_cliente.global_position=spawn_pos.global_position
	new_cliente.set_info(duplicate_res)
	#print(ClienteManager.clientes[0].customer.name)



func _on_timer_timeout() -> void:
	pass # Replace with function body.
