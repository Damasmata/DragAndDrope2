extends Node2D

@onready var cliente_sprite: Sprite2D = $cliente_sprite
@onready var button: TextureButton = $Button
@onready var nombre: Label = %Nombre

@onready var ticket:PackedScene = preload("res://scenes/ticket.tscn")

var estado:int =-1 #0=en cola, 1=pedir orden, 2=esperando orden, 3=calificando, 4=entregado

@onready var timer: Timer = $Timer

var customer:Resource

var orden_cliente=Orden.new()

func _ready() -> void:
	change_state()

func _process(delta: float) -> void:
	if ClienteManager.cliente_ordenando==false and estado==0:
		change_state()


func change_state():
	estado+=1
	match estado:
		0:
			cliente_sprite.modulate=(Color.DIM_GRAY)
			global_position.x+=100
		1:
			cliente_sprite.modulate=(Color.WHITE)
			global_position.x-=100
			button.show()
			nombre.show()
			ClienteManager.cliente_ordenando=true
		2:
			button.hide()
			cliente_sprite.modulate=(Color.DIM_GRAY)
			global_position.x-=300
			cliente_sprite.flip_h=true
			ClienteManager.cliente_ordenando=false
		3:
			timer.start()
			cliente_sprite.modulate=(Color.WHITE)
			global_position.x+=300
			#aqui el sprite mientras califica


func set_info(resource:Resource):
	customer=resource
	cliente_sprite.texture=customer.sprite
	nombre.text=resource.name
	clean_order()

func _on_button_pressed() -> void:
	var duplicate_res = customer.orden.duplicate()
	var new_item = ticket.instantiate()
	ClienteManager.ticket_number+=1
	add_child(new_item)
	new_item.global_position= get_viewport_rect().size/2
	orden_cliente=new_item.orden_final
	print(orden_cliente.extras)

	#new_item.orden_entregada
	#new_item.new_pos=get_viewport_rect().size/2
	#new_item.inital_pos=get_viewport_rect().size/2
	#new_item.crear_orden()
	change_state()

func clean_order():
	orden_cliente.chilaquil.clear()
	orden_cliente.cocciones.clear()
	orden_cliente.extras.clear()
	orden_cliente.presentacion.clear()
	orden_cliente.sabor.clear()
	orden_cliente.salsas.clear()
	orden_cliente.tamano.clear()


func _on_timer_timeout() -> void:
	ClienteManager.calificar()
