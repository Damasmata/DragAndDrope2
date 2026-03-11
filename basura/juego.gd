extends Node2D

func _on_button_6_pressed() -> void:
	if $Camera2D2.is_current():
		$Camera2D.make_current()

func _on_button_7_pressed() -> void:
	if $Camera2D.is_current():
		$Camera2D2.make_current()
