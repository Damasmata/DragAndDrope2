extends Node2D

@onready var texture_progress_bar: TextureProgressBar = %TextureProgressBar

@onready var button_stopper: PanelContainer = %ButtonStopper

#@onready var collision_shape_2d: CollisionShape2D = $Area2D/CollisionShape2D

var orden_hecha=Orden.new()
var orden_filler=Orden.new()


var full: bool = false
var stop:bool = false #implementar al rato------------------------
var finish:bool = false


var drink_resource:Resource

var follow_mouse:bool #siga el mouse
var can_be_dropped:bool = false
var dropped:bool=false

var drink_size:int

var initialpos:Vector2 #la posicion inicial
var offset:Vector2 #para que el objeto se mueva donde se dio click para agarrlo
var new_pos:Vector2 #la nueva posicion

signal filled
signal placed

func _ready() -> void:
	DishManager.drink_on_screen=true
	initialpos=global_position
	new_pos=global_position
	%Button.hide()
	print(new_pos)

func _process(delta: float) -> void:
	if !full and !stop:
		drink_resource.act_fill_time += delta
		filling()
	elif full:
		filled.emit()
		%Button.show()
	if can_be_dropped and dropped:
		placed.emit()
		dropped = false
	if follow_mouse: #si sigue al mouse, se mueve
		movement() 

func filling():
	var progreso = (drink_resource.act_fill_time / drink_resource._fill_time) * texture_progress_bar.max_value
	texture_progress_bar.value = progreso
	if drink_resource.act_fill_time >= drink_resource._fill_time:
		texture_progress_bar.value = texture_progress_bar.max_value
		full = true

func set_info(sabor:int,resource,size:int):
	clean_order()
	drink_resource=resource
	texture_progress_bar.texture_progress = drink_resource.sabores[sabor]
	
	orden_hecha.sabor.append(orden_filler.sabor[sabor])
	print(orden_hecha.sabor)
	
	orden_hecha.tamano.append(orden_filler.tamano[size])
	print(orden_hecha.tamano)
	
	texture_progress_bar.texture_over=drink_resource.vaso
	drink_resource.act_fill_time=0

func movement(): #moverse
	if Input.is_action_just_pressed("Click"):
		offset=get_global_mouse_position()-global_position
	if Input.is_action_pressed("Click"):
		global_position = get_global_mouse_position()-offset #obtener la posicion global del mouse

func clean_order():
	orden_hecha.chilaquil.clear()
	orden_hecha.cocciones.clear()
	orden_hecha.extras.clear()
	orden_hecha.presentacion.clear()
	orden_hecha.sabor.clear()
	orden_hecha.salsas.clear()
	orden_hecha.tamano.clear()

func _on_button_button_down() -> void:
	follow_mouse = true #sigue el mouse
	dropped = false
	scale=Vector2(1,1) #escalar

func _on_button_button_up() -> void:
	dropped = true
	if initialpos != new_pos and can_be_dropped:
		initialpos = new_pos
	global_position = initialpos
	follow_mouse=false
