extends Node2D

var ocupado:bool 
var friendo:bool 

var item_node:Node2D
var _item_resource:Resource
var coccion:int

func _ready() -> void:
	modulate=Color(Color.YELLOW,0.7)

func _process(delta: float) -> void:
	if friendo and !item_node.follow_mouse:
		var timer = _item_resource.cooked_time
		timer -= delta
		_item_resource.cooked_time = timer
		_friendo(timer)

func puede_freir():
	if !ocupado:
		friendo = true
		ocupado = true

func _friendo(tiempo:float):
	item_node.color_grade()
	if _item_resource.cooked_time >= (_item_resource.cooking_time)-(_item_resource.cooking_time/5):
		print("CRUDO")
	elif _item_resource.cooked_time >= (_item_resource.cooking_time)-(_item_resource.cooking_time/5)*2:
		print("BLANDO")
	elif _item_resource.cooked_time >= (_item_resource.cooking_time)-(_item_resource.cooking_time/5)*3:
		print("DORADO")
	elif _item_resource.cooked_time >= (_item_resource.cooking_time)-(_item_resource.cooking_time/5)*4:
		print("CRUJIENTE")
	else:
		print("YA SE QUEMO")

func _on_area_2d_area_entered(area: Area2D) -> void:
	var _item_node = area.get_parent()
	if _item_node.is_in_group("item") and !ocupado:
		_item_resource = _item_node.item_resource
		_item_node.connect("freir",puede_freir)
		_item_node.can_be_dropped = true
		_item_node.new_pos = self.global_position
		item_node = _item_node


func _on_area_2d_area_exited(area: Area2D) -> void:
	var _item_node = area.get_parent()
	if _item_node.item_resource == _item_resource:
		_item_node.update_resource(_item_resource)
		_item_node.can_be_dropped = false
		friendo = false
		_item_resource = null
		_item_node.disconnect("freir",puede_freir)
		item_node = null
		ocupado = false
