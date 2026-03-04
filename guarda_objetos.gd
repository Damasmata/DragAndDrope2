extends Node2D

var ocupado:bool 

var item_node:Node2D
var _item_resource:Resource

#func _ready() -> void:
	#modulate=Color(Color.YELLOW,0.7)

func puede_ocuparse():
	if !ocupado:
		ocupado=true

func _on_area_2d_area_entered(area: Area2D) -> void:
	var _item_node = area.get_parent()
	if _item_node.is_in_group("item") and !ocupado:
		_item_resource = _item_node.item_resource
		_item_node.can_be_dropped = true
		_item_node.new_pos = self.global_position
		#_item_node.connect("freir",puede_ocuparse)
		item_node = _item_node
		puede_ocuparse()

func _on_area_2d_area_exited(area: Area2D) -> void:
	var _item_node = area.get_parent()
	if _item_node.item_resource == _item_resource:
		_item_node.update_resource(_item_resource)
		_item_node.can_be_dropped = false
		_item_resource = null
		item_node = null
		ocupado = false
