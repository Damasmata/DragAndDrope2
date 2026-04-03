extends Control

var follow_mouse:bool #siga el mouse
var offset:Vector2 #para que el objeto se mueva donde se dio click para agarrlo

var order_resource:Resource


@onready var bebida: Label = $Orden/VBoxContainer/BebidaTamaño/Bebida

@onready var tamaño: Label = $Orden/VBoxContainer/BebidaTamaño/Tamaño

@onready var extra_5: Label = $Orden/VBoxContainer/Extra5
@onready var extra_4: Label = $Orden/VBoxContainer/Extra4
@onready var extra_3: Label = $Orden/VBoxContainer/Extra3
@onready var extra_2: Label = $Orden/VBoxContainer/Extra2
@onready var extra_1: Label = $Orden/VBoxContainer/Extra1

@onready var salsa: Label = $Orden/VBoxContainer/Salsa

@onready var chilaquil: Label = $Orden/VBoxContainer/ChilaquilPlato/Chilaquil

@onready var plato: Label = $Orden/VBoxContainer/ChilaquilPlato/Plato

@onready var coccion: Label = $Orden/VBoxContainer/Coccion


func _ready() -> void:
	reparent(get_parent(),)

func _process(delta: float) -> void:
	if follow_mouse:
		movement()

func set_info(resource:Resource):
	order_resource=resource
	
	if order_resource.coccion==1:
		coccion.text="crudo"
	elif order_resource.coccion==2:
		coccion.text="suave"
	elif order_resource.coccion==3:
		coccion.text="dorado"
	elif order_resource.coccion==4:
		coccion.text="crujiente"
	else:
		coccion.text="quemado"
	
	order_resource.servido.name=plato.text
	order_resource.salsa.name=salsa.text
	
	order_resource.extras[0].name=extra_1.text
	order_resource.extras[1].name=extra_2.text
	order_resource.extras[2].name=extra_3.text
	order_resource.extras[3].name=extra_4.text
	order_resource.extras[4].name=extra_5.text
	
	order_resource.bebida.name=bebida.text
	
	if order_resource.tamano==1:
		tamaño.text="chico"
	elif order_resource.tamano==2:
		coccion.text="mediano"
	else:
		tamaño.text="grande"

func movement():
	if Input.is_action_just_pressed("Click"):
		offset=get_global_mouse_position()-global_position
	if Input.is_action_pressed("Click"):
		global_position = get_global_mouse_position()-offset #obtener la posicion global del mouse

func _on_button_button_down() -> void:
	follow_mouse=true


func _on_button_button_up() -> void:
	follow_mouse=false


func _on_button_mouse_entered() -> void:
	scale=Vector2(1.0,1.0)


func _on_button_mouse_exited() -> void:
	scale=Vector2(0.5,0.5)
