extends Node2D

@onready var extra_color:ColorRect =$ColorRect

var en_posicion:bool

var extra_resource:Resource

var initialpos:Vector2 #la posicion inicial
var body_ref #permite que el new pos funcione, marca la posicion de la posicion
var offset:Vector2 #para que el objeto se mueva donde se dio click para agarrlo
var new_pos:Vector2 #la nueva posicion

var followmouse:bool

func _ready() -> void:
	initialpos=global_position

func set_info(_resource):
	extra_resource=_resource
	extra_color.color=_resource.colorextra
	add_to_group(_resource.groupname)

func _process(delta: float) -> void:
	if followmouse:
		movement()

func movement():
	if Input.is_action_just_pressed("Click"):
		offset=get_global_mouse_position()-global_position
	if Input.is_action_pressed("Click"):
		global_position = get_global_mouse_position()-offset #obtener la posicion global del mouse

func working ():
	pass

func _on_button_button_down() -> void:
	followmouse=true

func _on_button_button_up() -> void:
	followmouse=false
	if en_posicion:
		new_pos = body_ref.global_position - Vector2((extra_color.size.x/2),(extra_color.size.y/2))
		global_position = new_pos
		initialpos = new_pos
	else:
		global_position=initialpos

#func _on_area_2d_area_entered(area: Area2D) -> void:
	#pass # Replace with function body.
#
#func _on_area_2d_area_exited(area: Area2D) -> void:
	#pass # Replace with function body.
