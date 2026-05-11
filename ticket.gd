extends PanelContainer
var follow_mouse:bool #siga el mouse
var offset:Vector2 #para que el objeto se mueva donde se dio click para agarrlo

var new_pos:Vector2
var initial_pos:Vector2


var can_be_dropped:bool
var dropped:bool

#signal tira_pos

var order_resource:Resource

signal comparar

@onready var button_stopper: PanelContainer = $Button/ButtonStopper


@onready var extras: VBoxContainer = %Extras

@export var extra_scene:PackedScene
@export var orden_entregada:Resource

var orden_final:Orden

var new_parent:Control

@onready var numero: Label = %Numero

@onready var bebida: Label = %Bebida
@onready var tamaño: Label = %Tamaño

@onready var salsa: Label = %Salsa
@onready var chilaquil: Label = %Chilaquil
@onready var plato: Label = %Plato
@onready var coccion: Label = %Coccion

@export var numero_de_orden:int = 0

func _ready() -> void:
	crear_orden()
	reparent(get_parent(),)
	#print(orden_final.extras)
	new_pos=global_position
	initial_pos=global_position
	$Area2D/CollisionShape2D.shape.size = size
	$Area2D.position = $Area2D/CollisionShape2D.shape.size/2
	#$Area2D/CollisionShape2D.shape.size = size
	scale=Vector2(0.5,0.5)

func _process(delta: float) -> void:
	if follow_mouse:
		movement()
	if can_be_dropped and dropped:
		#tira_pos.emit()
		comparar.emit()
		dropped=false

func crear_orden():
	
	var new_order = Orden.new()
	var orden_temp = Orden.new()
	
	var extras_random_number = randi_range(1,5)
	orden_temp.numero_orden = numero_de_orden +1
	#var extras_en_orden:Array[String] = []
	orden_temp.extras.clear()
	orden_temp.chilaquil.clear()
	orden_temp.cocciones.clear()
	orden_temp.presentacion.clear()
	orden_temp.tamano.clear()
	orden_temp.sabor.clear()
	orden_temp.salsas.clear()
	for _extra in extras_random_number:
		var new_extra_scene = extra_scene.instantiate()
		var rand_extra=randi_range(0,orden_temp.extras.size()-1)
		if !orden_temp.extras.has(new_order.extras[rand_extra]):
			extras.add_child(new_extra_scene)
			new_extra_scene.text = new_order.extras[rand_extra]
			orden_temp.extras.push_front(new_order.extras[rand_extra])
		else:
			break
	numero.text = "Numero de orden: " + str(orden_temp.numero_orden)
	
	
	
	
	coccion.text=new_order.cocciones[randi_range(1,3)]
	orden_temp.cocciones.append(coccion.text)
	
	chilaquil.text=new_order.chilaquil[randi_range(0,2)]
	orden_temp.chilaquil.append(chilaquil.text)
	
	plato.text=new_order.presentacion[randi_range(0,1)]
	orden_temp.presentacion.append(plato.text)
	
	salsa.text=new_order.salsas[randi_range(0,1)]
	orden_temp.salsas.append(salsa.text)
	
	bebida.text=new_order.sabor[randi_range(0,2)]
	orden_temp.sabor.append(bebida.text)
	
	tamaño.text=new_order.tamano[randi_range(0,2)]
	orden_temp.tamano.append(tamaño.text)
	
	
	orden_final = orden_temp.duplicate()
	
	#var extras_random_number = 5
	#orden_entregada.numero_orden = numero_de_orden +1
	##var extras_en_orden:Array[String] = []
	#orden_temp.extras.clear()
	#for _extra in extras_random_number:
		#var new_extra_scene = extra_scene.instantiate()
		#extras.add_child(new_extra_scene)
		#new_extra_scene.text = orden_entregada.extras[_extra]
		#orden_entregada.extras.append(new_order.extras[_extra])
	#
	
	#
	#numero.text = "Numero de orden: " + str(orden_entregada.numero_orden)
	##print("extras: ",extras_en_orden)
	##orden_temp.extras = extras_en_orden.duplicate()
	#
	#orden_final = orden_temp.duplicate()

func comparar_orden():
	var extras_iguales:bool 
	extras_iguales = orden_final.extras == orden_entregada.extras
	orden_final.coccion == orden_entregada.coccion
	print("of: ", orden_final, " ", "oe: ", orden_entregada, " ", extras_iguales)

func movement():
	if Input.is_action_just_pressed("Click"):
		offset=get_global_mouse_position()-global_position
	if Input.is_action_pressed("Click"):
		global_position = get_global_mouse_position()-offset #obtener la posicion global del mouse

func _on_button_button_down() -> void:
	follow_mouse=true
	dropped=false

func _on_button_button_up() -> void:
	if can_be_dropped:
		reparent(new_parent)
	dropped = true
	if initial_pos != new_pos and can_be_dropped:
		initial_pos = new_pos
	global_position = initial_pos
	if global_position.x > get_viewport_rect().size.x:
		global_position.x = get_viewport_rect().size.x/2
	follow_mouse = false
	

func _on_button_mouse_entered() -> void:
	scale=Vector2(1.0,1.0)


func _on_button_mouse_exited() -> void:
	scale=Vector2(0.5,0.5)


func _on_button_test_pressed() -> void:
	comparar_orden()
