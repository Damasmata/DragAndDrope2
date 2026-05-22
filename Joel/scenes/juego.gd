extends Node2D

@onready var counters: Node2D = %Counters
@onready var game_camera: Camera2D = %GameCamera
@onready var bandeja: Node2D = %Bandeja

@onready var lugar_de_ticket: Node2D = %"lugar de ticket"
@onready var ticket_pos: ColorRect = %"ticket pos"

var counters_in_level:Array[Node2D]
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for counter in counters.get_children():
		counters_in_level.append(counter)
	DishManager.counters_in_level = counters_in_level.duplicate()
	DishManager._counters_in_level = counters_in_level.duplicate()

func _process(delta: float) -> void:
	if DishManager.order_finish and game_camera.global_position==game_camera.camera_positions[3] and bandeja.platillo_final!=null:
		lugar_de_ticket.show()
	else:
		lugar_de_ticket.hide()

func _on_area_2d_area_entered(area: Area2D) -> void:
	var ticket_on_area=area.get_parent()
	if ticket_on_area.is_in_group("Ticket") and DishManager.order_finish and game_camera.global_position==game_camera.camera_positions[3]:
		print("ENTRA")
		ticket_on_area.connect("comparar",bandeja.check)
		#ticket_on_area.new_pos=ticket_pos.global_position
		#ticket_on_area.new_parent = bandeja
		bandeja.orden_en_ticket=ticket_on_area
		bandeja.orden_ticket=ticket_on_area.orden_final
		bandeja.check() #se queda hasta que se coloque el ticket soltando el click


func _on_area_2d_area_exited(area: Area2D) -> void:
	var ticket_on_area=area.get_parent()
	if ticket_on_area.is_in_group("Ticket") and DishManager.order_finish and game_camera.global_position==game_camera.camera_positions[3]:
		print("SALE")
		ticket_on_area.disconnect("comparar",bandeja.check)
