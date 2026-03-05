extends Node2D

@onready var base_color: ColorRect = %BaseColor #que reaccione el color(0,0)
@onready var button_stopper: PanelContainer = %ButtonStopper
#@onready var menu: PanelContainer = %Menu

var item_resource:Resource #el resource del objeto

var _salsa_resource: Resource
var salsa_node:Node2D

signal freir
signal duplicar

var extras: Array[Node2D]
var dropped_sauce: Node2D

#region posiciones

var initialpos:Vector2 #la posicion inicial
var offset:Vector2 #para que el objeto se mueva donde se dio click para agarrlo
var new_pos:Vector2 #la nueva posicion

#endregion
 
#region bools

var follow_mouse:bool #siga el mouse
var mouse_in:bool #siga el mouse

var can_be_dropped:bool = false
var dropped:bool=false

var with_sauce:bool=false

#endregion

func _ready() -> void:
	$Menu.hide()

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
		dropped = false
	if follow_mouse: #si sigue al mouse, se mueve
		movement() 
	elif !follow_mouse and mouse_in:
		if Input.is_action_just_released("click_derecho"):
			$Menu.show()

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

func consalsa():
	with_sauce=true
	salsa_node.button_stopper.show()
	salsa_node.global_position=self.global_position
	dropped_sauce=salsa_node

#region button down/up-posiciones

func _on_button_button_down() -> void: #apretandolo
	follow_mouse = true #sigue el mouse
	dropped = false
	scale=Vector2(1,1) #escalar

func _on_button_button_up() -> void: #si se suelta el boton
	dropped = true
	if initialpos != new_pos and can_be_dropped:
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

#region extras y salsas

func _on_area_2d_area_entered(area: Area2D) -> void:
	var _salsa_node=area.get_parent()
	if _salsa_node.is_in_group("salsa") and with_sauce==false:
		_salsa_node.can_be_dropped = true
		_salsa_node.new_pos = self.global_position
		_salsa_node.connect("droppedsauce",consalsa)
		salsa_node=_salsa_node
		

func _on_area_2d_area_exited(area: Area2D) -> void:
	var _salsa_node=area.get_parent()
	if _salsa_node.is_in_group("salsa") and with_sauce==false:
		_salsa_node.can_be_dropped = false
		_salsa_node.disconnect("droppedsauce",consalsa)
		_salsa_resource=null
		salsa_node=null

#endregion

#añadir extras
#que detecte que tenga extras

#no se puede copiar el codigo de la freidora adaptado a la salsa---
#---if _salsa_node.item_resource == _salsa_resource:
#no lo detecta/no es igual/no se cumple


func _on_to_counter_pressed() -> void:
	if get_parent().is_in_group("servidores"):
		var counter = DishManager.counters_in_level.pop_front()
		get_parent().global_position = counter.global_position
		DishManager.dish_on_second_screen = false
	$Menu.hide()


func _on_button_stopper_mouse_entered() -> void:
	mouse_in = true

func _on_button_stopper_mouse_exited() -> void:
	mouse_in = false
