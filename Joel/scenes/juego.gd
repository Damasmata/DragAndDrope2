extends Node2D

@onready var counters: Node2D = %Counters

var counters_in_level:Array[Node2D]
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for counter in counters.get_children():
		counters_in_level.append(counter)
	DishManager.counters_in_level = counters_in_level.duplicate()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
