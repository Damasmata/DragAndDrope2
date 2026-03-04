extends Node2D

@onready var colorrect: ColorRect = %colorrect

@onready var button_stopper: PanelContainer = %ButtonStopper

var item_resource: Resource

signal  droppedtoping

#region posiciones

var initialpos:Vector2 #la posicion inicial
var offset:Vector2 #para que el objeto se mueva donde se dio click para agarrlo
var new_pos:Vector2 #la nueva posicion

#endregion
 
#region bools

var follow_mouse:bool #siga el mouse

var can_be_dropped:bool = false
var dropped:bool=false

#endregion

#region setting the object

func set_info(resource): #establece la info en base al resource
	item_resource = resource #el item pasa a ser el resource
	colorrect.color = resource.colorextra #color del resource 
	add_to_group(resource.group) #el grupo de donde esta el resource
	#color_grade()

#endregion

func _process(delta: float) -> void:
	if can_be_dropped and dropped:
		droppedtoping.emit()
		dropped = false
	if follow_mouse: #si sigue al mouse, se mueve
		movement() 

func update_resource(_item_resource:Resource):
	item_resource = _item_resource

func movement(): #moverse
	if Input.is_action_just_pressed("Click"):
		offset=get_global_mouse_position()-global_position
	if Input.is_action_pressed("Click"):
		global_position = get_global_mouse_position()-offset #obtener la posicion global del mouse

func _on_button_button_down() -> void:
	follow_mouse = true #sigue el mouse
	dropped = false
	scale=Vector2(1,1) #escalar

func _on_button_button_up() -> void:
	dropped = true
	if initialpos != new_pos and can_be_dropped:
		initialpos = new_pos
	global_position = initialpos
	follow_mouse = false #que no pueda seguir el mouse
