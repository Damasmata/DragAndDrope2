extends Node2D

@onready var color_rect: ColorRect = %ColorRect

var item_scene:PackedScene = preload("uid://chpe5fim08ihd")

var ocupado:bool
var duplicar:bool
var container_resource:Resource
var _item_resource:Resource
var item_node:Node2D

var item_duplicated:Node2D

var item_on:Node2D

func _ready() -> void:
	color_rect.color = container_resource.colorrect

func _process(delta: float) -> void:
	if duplicar and !DishManager.dish_on_second_screen:
		segunda_pantalla(_item_resource)
		duplicar = false
		DishManager.dish_on_second_screen = true

func set_info(resource:Resource):
	container_resource = resource
	#color_r.color = resource.colorrect
	#add_to_group(resource.group)

func puede_duplicar():
	if !ocupado:
		duplicar = true
		ocupado = true

func segunda_pantalla(item_to_duplicate:Resource):
	var child_node = item_node
	#para que se cree un container solo, modificar para que funcione como el item
	if child_node.get_parent():
		child_node.get_parent().remove_child(child_node)
	add_child(child_node)
	global_position = Vector2((get_viewport_rect().size.x/2)+1152,get_viewport_rect().size.y/2)
	child_node.global_position = global_position
	#item_node.global_position = Vector2((get_viewport_rect().size.x/2)+1152,get_viewport_rect().size.y/2)
	#self.global_position = Vector2((get_viewport_rect().size.x/2)+1152,get_viewport_rect().size.y/2)
	item_node.button_stopper.show()
	item_on=item_node
	
	#Codigo para duplicar el obj y mandarlo a la segunda pantalla
	
	#var new_item = item_scene.instantiate()
	#add_child(new_item)
	#new_item.global_position = Vector2((get_viewport_rect().size.x/2)+1152,get_viewport_rect().size.y/2)
	#new_item.set_info(item_to_duplicate)
	#new_item.button_stopper.show()
	#item_duplicated = new_item

func _on_area_container_area_entered(area: Area2D) -> void:
	var _item_node = area.get_parent()
	if _item_node.is_in_group("item") and !ocupado:
		_item_resource = _item_node.item_resource
		print(_item_resource.cooked_time, " ", _item_resource.cooking_time)
		if _item_resource.cooked_time < _item_resource.cooking_time:
			_item_node.connect("duplicar",puede_duplicar)
			_item_node.can_be_dropped = true
			_item_node.new_pos = self.global_position
			item_node = _item_node

func _on_area_container_area_exited(area: Area2D) -> void:
	var _item_node = area.get_parent()
	print(_item_node.name)
	#print(_item_node.item_resource)
	#print(_item_resource)
	if _item_node.is_in_group("item"):
		if _item_node.item_resource == _item_resource and _item_node.is_connected("duplicar",puede_duplicar) == true:  #and _item_resource.cooked_time != _item_resource.cooking_time:
			_item_node.can_be_dropped = false
			ocupado = false
			_item_node.disconnect("duplicar",puede_duplicar)
			_item_resource = null
			item_node = null

		if item_duplicated == null:
			return
		else:
			item_duplicated.queue_free()

#arreglar el error marcado ahi
#parece ser relacionado al resource, que por alguna razon detecta un colorrect
#se puede arreglar modificando todo los _item_node por item_node, quitarle el guion
#buscar otras soluciones
