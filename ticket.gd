extends Control

var follow_mouse:bool #siga el mouse
var offset:Vector2 #para que el objeto se mueva donde se dio click para agarrlo

var new_pos:Vector2
var initial_pos:Vector2


var can_be_dropped:bool
var dropped:bool

signal tira_pos

var order_resource:Resource
@onready var extras: VBoxContainer = %Extras

@export var extra_scene:PackedScene
@export var orden_entregada:Resource

var orden_final:Orden



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
	print(orden_final.extras)
	new_pos=global_position
	initial_pos=global_position

func _process(delta: float) -> void:
	if follow_mouse:
		movement()
	if can_be_dropped and dropped:
		tira_pos.emit()
		dropped=false

func crear_orden():
	var new_order = Orden.new()
	var orden_temp = Orden.new()
	
	var extras_random_number = randi_range(1,5)
	orden_temp.numero_orden = numero_de_orden +1
	#var extras_en_orden:Array[String] = []
	orden_temp.extras.clear()
	for _extra in extras_random_number:
		var new_extra_scene = extra_scene.instantiate()
		extras.add_child(new_extra_scene)
		new_extra_scene.text = new_order.extras[_extra]
		orden_temp.extras.append(new_order.extras[_extra])
		
	numero.text = "Numero de orden: " + str(orden_temp.numero_orden)
	#print("extras: ",extras_en_orden)
	#orden_temp.extras = extras_en_orden.duplicate()
	
	orden_final = orden_temp.duplicate()





#func set_info(resource:Resource):
	#order_resource=resource
	#
	#if order_resource.coccion==1:
		#coccion.text="crudo"
	#elif order_resource.coccion==2:
		#coccion.text="suave"
	#elif order_resource.coccion==3:
		#coccion.text="dorado"
	#elif order_resource.coccion==4:
		#coccion.text="crujiente"
	#else:
		#coccion.text="quemado"
	#
	#order_resource.servido.name=plato.text
	#order_resource.salsa.name=salsa.text
	#
	#order_resource.extras[0].name=extra_1.text
	#order_resource.extras[1].name=extra_2.text
	#order_resource.extras[2].name=extra_3.text
	#order_resource.extras[3].name=extra_4.text
	#order_resource.extras[4].name=extra_5.text
	#
	#order_resource.bebida.name=bebida.text
	#
	#if order_resource.tamano==1:
		#tamaño.text="chico"
	#elif order_resource.tamano==2:
		#coccion.text="mediano"
	#else:
		#tamaño.text="grande"

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
	dropped = true
	if initial_pos != new_pos and can_be_dropped:
		initial_pos = new_pos
	global_position = initial_pos
	follow_mouse = false


#func _on_button_mouse_entered() -> void:
	#scale=Vector2(1.0,1.0)
#
#
#func _on_button_mouse_exited() -> void:
	#scale=Vector2(0.5,0.5)


func _on_button_test_pressed() -> void:
	comparar_orden()
