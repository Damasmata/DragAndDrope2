extends Camera2D

@export var camera_positions:Array[Vector2] = [Vector2(1152/2,648/2),Vector2((1152/2)+1152,648/2),Vector2((1152/2)+(1152*2),648/2), Vector2((1152/2)+(1152*3),648/2)]
@export var speed:float

@onready var estacion_1: Sprite2D = %Estacion1
@onready var estacion_2: Sprite2D = %Estacion2
@onready var estacion_3: Sprite2D = %Estacion3
@onready var estacion_4: Sprite2D = %estacion4



const NOTAS_PRES = preload("uid://buax101sbdlth")
const NOTAS = preload("uid://31y2rdhnweq5")

const FREIDORA_PRESS = preload("uid://dph2hdbxq238o")
const FREIDORA = preload("uid://cxd2b2txxldbo")

const TOPPINGS_PRES = preload("uid://u6ususxytx1o")
const TOPPINGS = preload("uid://cg8w8o7vpkhm2")

const BEBIDAS_PRES = preload("uid://dg8i45bice87e")
const BEBIDAS = preload("uid://3qg13tilsa81")

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
		estacion_1.texture=NOTAS_PRES
		estacion_2.texture=FREIDORA
		estacion_3.texture=TOPPINGS
		estacion_4.texture=BEBIDAS
	elif global_position == camera_positions[1]:
		estacion_1.texture=NOTAS
		estacion_2.texture=FREIDORA_PRESS
		estacion_3.texture=TOPPINGS
		estacion_4.texture=BEBIDAS
	elif global_position == camera_positions[2]:
		estacion_1.texture=NOTAS
		estacion_2.texture=FREIDORA
		estacion_3.texture=TOPPINGS_PRES
		estacion_4.texture=BEBIDAS

	else:
		estacion_1.texture=NOTAS
		estacion_2.texture=FREIDORA
		estacion_3.texture=TOPPINGS
		estacion_4.texture=BEBIDAS_PRES

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
