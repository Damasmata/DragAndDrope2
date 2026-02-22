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
	if area.get_parent().is_in_group("items dropeables") and area.get_parent().dropped==true:
		area.get_parent().can_be_dropped = true
		objeto = area.get_parent()

func _on_area_2d_area_exited(area: Area2D) -> void:
	if area.get_parent().is_in_group("items dropeables"):
		area.get_parent().can_be_dropped = false
		objeto = null
