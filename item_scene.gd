extends Node2D

@onready var base_color: ColorRect = %BaseColor #que reaccione el color(0,0)
@onready var button_stopper: PanelContainer = %ButtonStopper

var item_resource:Resource #el resource del objeto

signal freir
signal duplicar

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
	if resource.cooked_time == 0.0:
		resource.cooked_time = resource.cooking_time
	item_resource = resource #el item pasa a ser el resource
	base_color.color = resource.raw_color #color del resource 
	add_to_group(resource.group) #el grupo de donde esta el resource
	color_grade()

#endregion


func _process(delta: float) -> void:
	if can_be_dropped and dropped:
		freir.emit()
		duplicar.emit()
		print("hello")
		dropped = false


	if follow_mouse: #si sigue al mouse, se mueve
		movement() 

func color_grade():
	var cooked_time:float = remap(item_resource.cooked_time,item_resource.cooking_time,0.0,0.0,1.0)
	base_color.color = lerp(item_resource.raw_color,item_resource.cooked_color,cooked_time)


func update_resource(_item_resource:Resource):
	item_resource = _item_resource

func movement(): #moverse
	if Input.is_action_just_pressed("Click"):
		offset=get_global_mouse_position()-global_position
	if Input.is_action_pressed("Click"):
		global_position = get_global_mouse_position()-offset #obtener la posicion global del mouse

#region timer

#endregion

#region button down/up-posiciones

func _on_button_button_down() -> void: #apretandolo
	follow_mouse = true #sigue el mouse
	dropped = false
	scale=Vector2(1,1) #escalar

func _on_button_button_up() -> void: #si se suelta el boton
	dropped = true
	if initialpos != new_pos:
		initialpos = new_pos
	global_position = initialpos
	follow_mouse = false #que no pueda seguir el mouse
	


#endregion

#region mouse_entered/exited

func _on_button_mouse_entered() -> void: #escalar para poder agarrar
	scale=Vector2(1.05,1.05)

func _on_button_mouse_exited() -> void: #escalar si no esta el mouse
	scale=Vector2(1,1) #escalar

#endregion
