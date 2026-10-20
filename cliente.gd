extends Node2D

@onready var cliente_sprite: Sprite2D = $cliente_sprite
@onready var button: TextureButton = $Button
@onready var nombre: Label = %Nombre

@onready var ticket:PackedScene = preload("res://scenes/ticket.tscn")

var text_pidiendo:Texture2D
var text_calificando:Texture2D
var text_esperando:Texture2D
var text_default:Texture2D
var text_bien: Texture2D
var text_mal:Texture2D
var text_maso: Texture2D

var estado:int =-1 #0=en cola, 1=pedir orden, 2=esperando orden, 3=calificando, 4=entregado

#@onready var game_camera: Camera2D = %GameCamera

@onready var timer: Timer = $Timer

var customer:Resource

var orden_cliente=Orden.new()

func _ready() -> void:
	change_state()

func _process(delta: float) -> void:
	if ClienteManager.cliente_en_espera==false and estado==0:
		change_state()
	if ClienteManager.cliente_calificando==true and estado==1:
		button.hide()
	elif ClienteManager.cliente_calificando==false and estado==1 and ClienteManager.cliente_ordenando==false:
		button.show()


func change_state():
	estado+=1
	match estado:
		0:
			cliente_sprite.modulate=(Color.DIM_GRAY)
			global_position.x+=100
			cliente_sprite.texture=text_esperando
		1:
			cliente_sprite.modulate=(Color.WHITE)
			global_position.x-=100
			button.show()
			nombre.show()
			ClienteManager.cliente_en_espera=true
			cliente_sprite.texture=text_default
		2:
			button.hide()
			cliente_sprite.modulate=(Color.DIM_GRAY)
			global_position.x-=300
			cliente_sprite.flip_h=true
			ClienteManager.cliente_en_espera=false
			nombre.hide()
			cliente_sprite.texture=text_esperando
			cliente_sprite.z_index=6-ClienteManager.ticket_number
		3:
			timer.start()
			cliente_sprite.modulate=(Color.WHITE)
			global_position.x+=300
			nombre.show()
			ClienteManager.game_camera.disable_cam()
			ClienteManager.cliente_calificando=true
			cliente_sprite.texture=text_calificando
		4:
			timer.start()


func set_info(resource:Resource):
	customer=resource
	text_default=customer.sprite
	text_calificando=customer.calificando
	text_esperando=customer.esperando
	text_bien=customer.bien
	text_mal=customer.mal
	text_maso=customer.maso
	text_pidiendo=customer.ordenando
	
	cliente_sprite.texture=text_esperando
	nombre.text=resource.name
	clean_order()

func _on_button_pressed() -> void:
	
	timer.start()
	button.hide()
	cliente_sprite.texture=text_pidiendo
	ClienteManager.game_camera.disable_cam()
	ClienteManager.cliente_ordenando=true
	#ClienteManager.clientes.map(func(nodo):button.hide())
	#ClienteManager.disable_cam()
	#game_camera.disable_cam()
	#new_item.orden_entregada
	#new_item.new_pos=get_viewport_rect().size/2
	#new_item.inital_pos=get_viewport_rect().size/2
	#new_item.crear_orden()

func clean_order():
	orden_cliente.chilaquil.clear()
	orden_cliente.cocciones.clear()
	orden_cliente.extras.clear()
	orden_cliente.presentacion.clear()
	orden_cliente.sabor.clear()
	orden_cliente.salsas.clear()
	orden_cliente.tamano.clear()


func _on_timer_timeout() -> void:
	if estado==1:
		#var duplicate_res = customer.orden.duplicate()
		var new_item = ticket.instantiate()
		ClienteManager.ticket_number+=1
		add_child(new_item)
		new_item.global_position= get_viewport_rect().size/2
		orden_cliente=new_item.orden_final
		print(orden_cliente.extras)
		change_state()
		ClienteManager.game_camera.disable_cam()
		ClienteManager.cliente_ordenando=false
	elif estado==3:
		ClienteManager.calificar()
		
	elif estado==4:
		self.hide()
		ClienteManager.game_camera.disable_cam()
		ClienteManager.cliente_calificando=false
		
