extends Node2D


@export var drink_resource: Array [Resource]
@export var timers: Array[float]

@onready var spawn_pos: ColorRect = %SpawnPos

var drink_to_spawn:Resource

var bebida_scene: PackedScene=preload("res://Joel/scenes/Bebida.tscn")

var drink_time: float
var drink_type: Resource

var created_drink:Node2D

var selected_type:bool=false
var selected_size:bool=false

var drink_in_spawn:bool


func _process(delta: float) -> void:
	if !selected_type and !drink_in_spawn:
		$PanelTipo.show()
	elif selected_type and !selected_size:
		$PanelSize.show()
		$PanelTipo.hide()
	else:
		$PanelReady.show()

func spawn_drink():
	var _res_drink=drink_type.duplicate()
	var _time_drink=drink_time
	var new_drink=bebida_scene.instantiate()
	add_child(new_drink)
	new_drink.global_position = spawn_pos.global_position + spawn_pos.pivot_offset
	new_drink.initialpos = new_drink.global_position
	new_drink.new_pos = new_drink.initialpos
	new_drink.set_info(_res_drink,_time_drink)

#region botones panelTipo

func _on_bebida_1_pressed() -> void:
	selected_type=true
	drink_type=drink_resource[0]

func _on_bebida_2_pressed() -> void:
	selected_type=true
	drink_type=drink_resource[1]

func _on_bebida_3_pressed() -> void:
	selected_type=true
	drink_type=drink_resource[2]

func _on_bebida_4_pressed() -> void:
	selected_type=true
	drink_type=drink_resource[3]

func _on_bebida_5_pressed() -> void:
	selected_type=true
	drink_type=drink_resource[4]

func _on_bebida_6_pressed() -> void:
	selected_type=true
	drink_type=drink_resource[5]

#endregion

#region botones panelSize

func _on_size_s_pressed() -> void:
	selected_size=true
	drink_time=timers[0]
	spawn_drink()

func _on_size_m_pressed() -> void:
	selected_size=true
	drink_time=timers[1]
	spawn_drink()

func _on_size_b_pressed() -> void:
	selected_size=true
	drink_time=timers[2]
	spawn_drink()

#endregion

#region botones panelReady

func _on_stop_pressed() -> void: #aqui detiene el llenado
	pass

func _on_continue_pressed() -> void: #si esta detenido, al presionar sigue llenando
	pass # Replace with function body.

func _on_ready_pressed() -> void: #se deja de llenar y se puede mover la bebida
	pass # Replace with function body.

#endregion

#region area entered/exited

func _on_area_2d_area_entered(area: Area2D) -> void:
	var drink_in_area=area.get_parent()
	if drink_in_area.get_parent().is_in_group("Bebida"):
		drink_in_spawn=true
		created_drink=drink_in_area

func _on_area_2d_area_exited(area: Area2D) -> void:
	if area.get_parent().is_in_group("Bebida"):
		drink_in_spawn=false
		created_drink=null

#endregion
