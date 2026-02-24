extends StaticBody2D

var objeto:Node2D

func _ready() -> void:
	modulate=Color(Color.RED,0.7)

func _process(delta: float) -> void:
	if objeto != null and Input.is_action_just_released("Click"):
		destruir()

func destruir():
	objeto.queue_free()

func _on_area_2d_area_entered(area: Area2D) -> void:
	var _item_node = area.get_parent()
	if _item_node.is_in_group("item") and _item_node.item_resource.cooked_time != _item_node.item_resource.cooking_time:
		objeto = area.get_parent()
		print(objeto)

func _on_area_2d_area_exited(area: Area2D) -> void:
	if area.get_parent().is_in_group("item"):
		objeto = null
