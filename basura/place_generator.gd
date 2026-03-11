extends Button

@export var place_scene:PackedScene
@export var select_place:int
@export var sprite:Texture2D

@export var place_to_generate:Array[Resource] = [] #hace un array, que item genera, en base al resource

func _ready() -> void: #hace algo al inicio
	#for ingridient in all_items:
	create_place(place_to_generate[select_place])

func create_place(_resource:Resource):
	var new_place = place_scene.instantiate()#instanciar el item creado
	add_child(new_place) #crea un nuevo item
	new_place.set_info(_resource) #la info del nuevo item es la del resource
	new_place.global_position = self.position#Vector2(randf_range(100,400),randf_range(100,400) #posicion)

func _on_pressed() -> void:
	create_place(place_to_generate[select_place]) #al presionar el boton va a crear un item
