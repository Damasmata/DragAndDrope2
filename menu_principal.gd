extends Control




func _on_iniciar_juego_pressed() -> void:
	NovelaManager.next_scene="timeline"
	get_tree().change_scene_to_file("res://scenes/novela.tscn")
