extends Node2D

func _ready() -> void:
	#Dialogic.start(NovelaManager.next_scene)
	Dialogic.start(NovelaManager.next_scene)
	Dialogic.signal_event.connect(on_signal)
	on_signal(sign)

func on_signal(signal_passed):
	match signal_passed:
		"Pantalla de inicio":
			get_tree().change_scene_to_file("res://scenes/pantalla_final.tscn")
		"gameplay1":
			get_tree().change_scene_to_file("res://Joel/scenes/test.tscn")
	
