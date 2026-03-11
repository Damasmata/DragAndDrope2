extends Button

@export var item_scene:PackedScene
@export var select_item:int
@export var sprite:Texture2D

@export var item_to_generate:Array[Resource] = [] #hace un array, que item genera, en base al resource

func _ready() -> void: #hace algo al inicio
	#for ingridient in all_items:
	create_item(item_to_generate[select_item])

func create_item(_resource:Resource):
	var new_item = item_scene.instantiate()#instanciar el item creado
	add_child(new_item) #crea un nuevo item
	new_item.set_info(_resource) #la info del nuevo item es la del resource
	new_item.global_position = self.position#Vector2(randf_range(100,400),randf_range(100,400) #posicion)

func _on_pressed() -> void:
	create_item(item_to_generate[select_item])
