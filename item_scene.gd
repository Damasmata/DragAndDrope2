extends Node2D

@onready var extras: Node2D = %Extras
@onready var tops: Node2D = %Tops


@onready var to_counter: Button = %toCounter

@onready var base_color: ColorRect = %BaseColor #que reaccione el color(0,0)
@onready var button_stopper: PanelContainer = %ButtonStopper

@onready var to_continue: Button = %toContinue

@onready var to_back: Button = %toBack

var item_resource:Resource #el resource del objeto

var _salsa_resource: Resource
var salsa_node:Node2D #este es para instanciar el objeto

signal freir
signal duplicar
signal ocupar

var _toppings_resource:Resource
var topping_node: Node2D
var toppings_nodes: Array[Node2D]


#region array

var toppings:Array[Node2D] = []

#endregion

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

var en_guardaobjetos:bool

var with_sauce:bool = false

var en_tercera:bool = false

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
		ocupar.emit()
		dropped = false
	if follow_mouse: #si sigue al mouse, se mueve
		movement() 
	elif !follow_mouse and mouse_in:
		%ClickDer.show()
	#if duplicar:
		#pass
	if DishManager.dish_on_second_screen:
		to_back.disabled=true
	else:
		to_back.disabled=false
	if en_guardaobjetos:
		to_counter.disabled=true
		to_continue.disabled=true
	else:
		to_counter.disabled=false
		if DishManager.dish_on_third_screen:
			to_continue.disabled=true
		else:
			to_continue.disabled=false

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
	var child_node=salsa_node
	if child_node.get_parent():
		child_node.get_parent().remove_child(child_node)
	extras.add_child(child_node)
	child_node.global_position=global_position
	salsa_node.button_stopper.show()
	with_sauce=true

func contopping():
	var child_node=topping_node
	if check_topping(child_node):
		if child_node.get_parent():
			child_node.get_parent().remove_child(child_node)
		tops.add_child(child_node)
		child_node.global_position=global_position
		child_node.button_stopper.show()
		toppings.append(child_node)
	else:
		return
	print(toppings)
	#for topping in topping_node:
		#toppings_nodes.append(topping)
		#hacer un for para que almacene los datos de los toppings

func check_topping(new_topping:Node2D) -> bool:
	if !toppings.is_empty():
		for topping in toppings:
			print(topping.item_resource.name, " ", new_topping.item_resource.name)
			if topping.item_resource.name == new_topping.item_resource.name:
				return false
	toppings.append(new_topping)
	return true

func show_container():
	if $Menu.visible:
		$Menu.hide()
	else:
		$Menu.show()

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
	var _extra_node=area.get_parent()
	if _extra_node.is_in_group("salsa") and !salsa_node and !with_sauce:
		#print("FUNCIONA AL ENTRAR")
		_extra_node.can_be_dropped = true
		_extra_node.new_pos = self.global_position
		_extra_node.connect("droppedsauce",consalsa)
		salsa_node=_extra_node
	if _extra_node.is_in_group("items dropeables") and salsa_node and !en_guardaobjetos:
		topping_node=_extra_node
		_extra_node.can_be_dropped = true
		_extra_node.connect("droppedtoping",contopping)

		
		
		#if toppings.has(topping_node):
			#toppings.erase(topping_node)
		

func _on_area_2d_area_exited(area: Area2D) -> void:
	var _extra_node=area.get_parent()
	if _extra_node.is_in_group("salsa") and salsa_node and !with_sauce:
		#print("FUNCIONA AL SALIR")
		_extra_node.can_be_dropped = false
		_extra_node.disconnect("droppedsauce",consalsa)
		_salsa_resource=null
		salsa_node=null
	if _extra_node.is_in_group("items dropeables") and salsa_node and !en_guardaobjetos:
		_extra_node.can_be_dropped = false
		_extra_node.disconnect("droppedtoping",contopping)
		_toppings_resource=null
		topping_node=null

#endregion

func _on_button_stopper_mouse_entered() -> void:
	mouse_in = true

func _on_button_stopper_mouse_exited() -> void:
	mouse_in = false

func _on_to_counter_pressed() -> void:
	if get_parent().is_in_group("servidores"):
		var _counter:Node2D
		for counter in DishManager.counters_in_level:
			if !counter.ocupado:
				_counter = counter
				get_parent().reparent(_counter)
				get_parent().global_position = counter.global_position
				DishManager.dish_on_second_screen = false
				en_guardaobjetos=true
				counter.ocupado = true
				break
	show_container()

func _on_to_erase_pressed() -> void:
	if get_parent().is_in_group("servidores"):
		get_parent().queue_free()
		DishManager.dish_on_second_screen = false
	show_container()

func _on_to_continue_pressed() -> void:
	if get_parent().is_in_group("servidores"):
		get_parent().global_position = Vector2((get_viewport_rect().size.x/2)+(1152*2),get_viewport_rect().size.y/2)
		DishManager.dish_on_second_screen = false
		DishManager.dish_on_third_screen = true
		en_tercera=true
	show_container()

func _on_to_back_pressed() -> void:
	if get_parent().is_in_group("servidores"):
		get_parent().global_position = Vector2((get_viewport_rect().size.x/2)+1152,get_viewport_rect().size.y/2)
		DishManager.dish_on_second_screen = true
		en_guardaobjetos=false
		get_parent().get_parent().ocupado = false
		get_parent().reparent(get_parent().get_parent().get_parent())
		DishManager.counters_in_level.append(get_parent())
	show_container()

func _on_click_der_pressed() -> void:
	if salsa_node and !en_tercera:
		show_container()
