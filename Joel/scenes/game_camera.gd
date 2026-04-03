extends Camera2D

@export var camera_positions:Array[Vector2] = [Vector2(1152/2,648/2),Vector2((1152/2)+1152,648/2),Vector2((1152/2)+(1152*2),648/2), Vector2((1152/2)+(1152*3),648/2)]
@export var speed:float

@onready var estacion_1: Sprite2D = $"../../CanvasLayer/Estacion1"
@onready var estacion_2: Sprite2D = $"../../CanvasLayer/Estacion2"
@onready var estacion_3: Sprite2D = $"../../CanvasLayer/Estacion3"

const ESTACION_DE_ORDENES_PRESIONADO = preload("uid://q73mo8c2t2ld")
const ESTACION_DE_ORDENES = preload("uid://be17yld8mahx3")

const BOTON_FREIDORA_PRESIONADO = preload("uid://yaadpikiax3j")
const BOTON_FREIDORA = preload("uid://uo652gqug7sj")

const BOTON_DE_TOPPING_PRESIONADO = preload("uid://cslta4p5kva5p")
const BOTON_DE_TOPPING = preload("uid://bo4k2v50f2v1b")





var moving_camera:bool
var next_pos

func _ready() -> void:
	global_position = camera_positions[0]
	change_buttons()

func _process(delta: float) -> void:
	if !moving_camera:
		change_camera_pos(delta)
	else:
		global_position.x = move_toward(global_position.x,next_pos.x,delta * speed)
		if global_position.x == next_pos.x:
			moving_camera = false

func change_camera_pos(_delta:float):
	if Input.is_action_just_pressed("camera_change"):
		for pos in camera_positions:
			if pos.x != global_position.x:
				next_pos = pos
		moving_camera = true

func change_buttons():
	if global_position == camera_positions[0]:
		estacion_1.texture=ESTACION_DE_ORDENES_PRESIONADO
		estacion_2.texture=BOTON_FREIDORA
		estacion_3.texture=BOTON_DE_TOPPING
	elif global_position == camera_positions[1]:
		estacion_1.texture=ESTACION_DE_ORDENES
		estacion_2.texture=BOTON_FREIDORA_PRESIONADO
		estacion_3.texture=BOTON_DE_TOPPING
	elif global_position == camera_positions[2]:
		estacion_1.texture=ESTACION_DE_ORDENES
		estacion_2.texture=BOTON_FREIDORA
		estacion_3.texture=BOTON_DE_TOPPING_PRESIONADO
	else:
		estacion_1.texture=ESTACION_DE_ORDENES
		estacion_2.texture=BOTON_FREIDORA
		estacion_3.texture=BOTON_DE_TOPPING

func _on_est_1_pressed() -> void:
	if global_position != camera_positions[0]:
		global_position=camera_positions[0]
		change_buttons()


func _on_est_2_pressed() -> void:
	if global_position != camera_positions[1]:
		global_position=camera_positions[1]
		change_buttons()


func _on_est_3_pressed() -> void:
	if global_position != camera_positions[2]:
		global_position=camera_positions[2]
		change_buttons()


func _on_est_4_pressed() -> void:
	if global_position != camera_positions[3]:
		global_position=camera_positions[3]
		change_buttons()
