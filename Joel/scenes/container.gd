extends Node2D

@onready var color_r: ColorRect = %ColorR

var item_scene:PackedScene = preload("uid://chpe5fim08ihd")

var ocupado:bool
var duplicar:bool
var container_resource:Resource
var _item_resource:Resource
var item_node:Node2D

var item_duplicated:Node2D

func _ready() -> void:
	color_r.color = container_resource.colorrect

func _process(delta: float) -> void:
	if duplicar:
		segunda_pantalla(_item_resource)
		duplicar = false


func set_info(resource:Resource):
	container_resource = resource
	

func puede_duplicar():
	if !ocupado:
		duplicar = true
		ocupado = true

func segunda_pantalla(item_to_duplicate:Resource):
	item_node.global_position = Vector2((get_viewport_rect().size.x/2)+1152,get_viewport_rect().size.y/2)
	item_node.button_stopper.show()
	
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
		if _item_resource.cooked_time != _item_resource.cooking_time:
			_item_node.connect("duplicar",puede_duplicar)
			_item_node.can_be_dropped = true
			_item_node.new_pos = self.global_position
			item_node = _item_node




func _on_area_container_area_exited(area: Area2D) -> void:
	var _item_node = area.get_parent()
	if _item_node.item_resource == _item_resource:
		_item_node.can_be_dropped = false
		ocupado = false
		_item_node.disconnect("duplicar",puede_duplicar)
		_item_resource = null
		item_node = null
	if item_duplicated == null:
		return
	else:
		item_duplicated.queue_free()
