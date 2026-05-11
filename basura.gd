extends StaticBody2D

@export var image:Texture2D

@onready var texture: Sprite2D = %texture

var objeto:Node2D

func _ready() -> void:
	#modulate=Color(Color.RED,0.7)
	texture.texture=image

func _process(delta: float) -> void:
	if objeto != null and Input.is_action_just_released("Click"):
		destruir()

func destruir():
	if objeto.is_in_group("Bebida"):
		DishManager.drink_on_screen=false
	objeto.queue_free()
	objeto=null

func _on_area_2d_area_entered(area: Area2D) -> void:
	var _item_node = area.get_parent()
	if (_item_node.is_in_group("item") and _item_node.item_resource.cooked_time != _item_node.item_resource.cooking_time) or (_item_node.is_in_group("Bebida")):
		objeto = area.get_parent()
		print(objeto)

func _on_area_2d_area_exited(area: Area2D) -> void:
	if area.get_parent().is_in_group("item") or area.get_parent().is_in_group("Bebida") :
		objeto = null
		print("SALE")
