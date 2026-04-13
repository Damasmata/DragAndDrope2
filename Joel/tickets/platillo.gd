extends Node2D

var mouse_in:bool = false

func _process(delta: float) -> void:
	if mouse_in and Input.is_action_pressed("Click"):
		global_position = get_global_mouse_position()




func _on_orden_mouse_entered() -> void:
	mouse_in = true

func _on_orden_mouse_exited() -> void:
	mouse_in = false


func _on_agregar_pressed() -> void:
	pass # Replace with function body.
