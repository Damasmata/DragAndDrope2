extends Node2D

@onready var color_r: ColorRect = %ColorR

var item_scene:PackedScene = preload("uid://chpe5fim08ihd")

var ocupado:bool
var duplicar:bool
var container_resource:Resource
var _item_resource:Resource

var item_duplicated:Node2D
#@onready var color_r: ColorRect = %ColorR

func _ready() -> void:
	color_r.color = container_resource.colorrect

func _process(delta: float) -> void:
	if duplicar:
		segunda_pantalla(_item_resource)
		duplicar = false


func set_info(resource:Resource):
	#print(resource.name)
	container_resource = resource
	

func puede_duplicar():
	if !ocupado:
		duplicar = true
		ocupado = true

func segunda_pantalla(item_to_duplicate:Resource):
	var new_item = item_scene.instantiate()
	add_child(new_item)
	new_item.global_position.x = self.global_position.x + 1152
	new_item.set_info(item_to_duplicate)
	new_item.button_stopper.show()
	item_duplicated = new_item

func _on_area_container_area_entered(area: Area2D) -> void:
	var item_node = area.get_parent()
	if item_node.is_in_group("item") and !ocupado:
		_item_resource = item_node.item_resource
		item_node.connect("duplicar",puede_duplicar)
		item_node.can_be_dropped = true
		item_node.new_pos = self.global_position




func _on_area_container_area_exited(area: Area2D) -> void:
	var item_node = area.get_parent()
	if item_node.item_resource == _item_resource:
		item_node.can_be_dropped = false
		ocupado = false
		item_node.disconnect("duplicar",puede_duplicar)
		_item_resource = null
	print(ocupado)
	if item_duplicated == null:
		return
	else:
		print("obj deleted")
		item_duplicated.queue_free()
