extends Node2D

@onready var base_color: ColorRect = %BaseColor #que reaccione el color(0,0)

var item_resource:Resource #el resource del objeto

#const FREIDORA = preload("uid://civho5vfk2eni")
#var Freidora=FREIDORA.instantiate()

signal freir

#region posiciones

var initialpos:Vector2 #la posicion inicial
var body_ref #permite que el new pos funcione, marca la posicion de la posicion
var offset:Vector2 #para que el objeto se mueva donde se dio click para agarrlo
var new_pos:Vector2 #la nueva posicion

#endregion
 
#region bools

var follow_mouse:bool #siga el mouse
#var cook_item:bool #se puede cocinar el item
#var destruible:bool #se puede destruir el item
#var next:bool
var entregar:bool

var can_be_dropped:bool = false
var dropped:bool=false

#endregion

#region setting the object

func _ready() -> void:
	initialpos = global_position

func set_info(resource): #establece la info en base al resource
	resource.cooked_time = resource.cooking_time
	item_resource = resource #el item pasa a ser el resource
	base_color.color = resource.random_color #color del resource 
	add_to_group(resource.group) #el grupo de donde esta el resource

func _process(delta: float) -> void:
	if follow_mouse: #si sigue al mouse, se mueve
		movement() 
	#if cook_item:
##		start_cook_timer(delta)
		#Freidora.add_to_group("ocupado")
	#else:
		#Freidora.remove_from_group("ocupado")

#endregion

func movement(): #moverse
	if Input.is_action_just_pressed("Click"):
		offset=get_global_mouse_position()-global_position
	if Input.is_action_pressed("Click"):
		global_position = get_global_mouse_position()-offset #obtener la posicion global del mouse

#region timer
#
#func ranges():
	#var _rango:float = item_resource.cooking_time
	#print(_rango)
#
#func start_cook_timer(_delta:float):
	#if (item_resource.cooking_time>0):
		#item_resource.cooking_time -= _delta
		#ranges()
		##print(item_resource.cooking_time)
#
#endregion

#region button down/up-posiciones

func _on_button_button_down() -> void: #apretandolo
	if entregar==false:
		follow_mouse = true #sigue el mouse
		#cook_item=false
		scale=Vector2(1,1) #escalar

func _on_button_button_up() -> void: #si se suelta el boton
	if can_be_dropped:
		new_pos = body_ref.global_position - Vector2((base_color.size.x/2),(base_color.size.y/2))
		global_position = new_pos
		initialpos = new_pos
		dropped=true
		freir.emit()
	else:
		if initialpos==new_pos:
			#cook_item = true
			freir.emit()
		#else:
			#cook_item=false
		global_position = initialpos
	follow_mouse = false #que no pueda seguir el mouse
	#if en_posicion:
		#if destruible:
			#queue_free()
		#else:
			#new_pos = body_ref.global_position - Vector2((base_color.size.x/2),(base_color.size.y/2))
			#global_position = new_pos
			#initialpos = new_pos
			#puesto=true
			#if next==true:
				#cook_item=false
				#entregar=true
			#else:
				#cook_item=true
				#entregar=false
	#else:
		#if initialpos==new_pos:
			#cook_item = true
		#else:
			#cook_item=false
		#global_position = initialpos

#endregion

#region mouse_entered/exited

func _on_button_mouse_entered() -> void: #escalar para poder agarrar
	if entregar == false:
		scale=Vector2(1.05,1.05)

func _on_button_mouse_exited() -> void: #escalar si no esta el mouse
	if entregar == false:
		scale=Vector2(1,1) #escalar

#endregion

#region body entered/exited

func _on_area_2d_body_entered(body: Node2D) -> void: #establecer que esta dentro del lugar
	#Freidora=body
	#if body.is_in_group("freidora"):
		#if Freidora.is_in_group("ocupado"):
			#print("NO SE PUEDE SOLTAR")
			#destruible=false
			#en_posicion=false
			#next=false
		#else:
			#print("SE PUEDE SOLTAR")
			#destruible=false
			#en_posicion=true
			#next=false
	#elif body.is_in_group("destructor") and puesto:
		#print("SE PUEDE SOLTAR")
		#destruible=true
		#en_posicion=true
		#next=false
	#elif body.is_in_group("servidores") and puesto:
		#print("SE PUEDE SOLTAR")
		#destruible=false
		#en_posicion=true
		#next=true
	body_ref=body

#func _on_area_2d_body_exited(body: Node2D) -> void: #establecer si esta fuera del lugar
	#print("NO SE PUEDE SOLTAR")
	#en_posicion=false
	#destruible=false
	#next=false

#endregion
