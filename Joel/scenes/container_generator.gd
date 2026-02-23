extends Node2D

@export var container_scene:PackedScene


@export var all_containers:ResourceGroup
var _all_containers:Array[Resource]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	all_containers.load_all_into(_all_containers)
	for container in _all_containers:
		create_container(container)

func create_container(container:Resource):
	var new_container = container_scene.instantiate()
	get_parent().add_child.call_deferred(new_container)
	new_container.global_position = global_position
	new_container.set_info(container.duplicate())
	new_container.name = container.name
	global_position.x += 190
