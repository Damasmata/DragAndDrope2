extends Button

@export var extra_scene:PackedScene
@export var select_extra:int
@export var sprite:Texture2D

@export var extra_to_generate:Array[Resource] = []

func _ready() -> void:
	create_extra(extra_to_generate[select_extra])

func create_extra(_resource=Resource):
	var new_extra=extra_scene.instantiate()
	add_child(new_extra)
	new_extra.set_info(_resource)
	new_extra.global_position=self.position

func _on_pressed() -> void:
	create_extra(extra_to_generate[select_extra])
