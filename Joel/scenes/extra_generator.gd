extends Node2D

@export var extra_scene:PackedScene

@export var all_extras:ResourceGroup
var _all_extras:Array[Resource]



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	all_extras.load_all_into(_all_extras)
	for extra in _all_extras:
		create_extras(extra)

func create_extras(extra:Resource):
	var new_extra_scene = extra_scene.instantiate()
	add_child(new_extra_scene)
	new_extra_scene.set_info(extra)
	print(extra.name)
		
