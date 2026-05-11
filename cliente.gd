extends Node2D

@onready var cliente_sprite: Sprite2D = $cliente_sprite
@onready var button: TextureButton = $Button
@onready var nombre: Label = %Nombre

@onready var ticket:PackedScene = preload("res://scenes/ticket.tscn")

var estado:int #0=para pedir orden, 1=esperando pedido, 2=entregado

var customer:Resource

var orden_cliente=Orden.new()

func _process(delta: float) -> void:
	if estado==0:
		pass
	elif estado==1:
		ClienteManager.calificar()
	else:
		hide()


func set_info(resource:Resource):
	customer=resource
	cliente_sprite.texture=customer.sprite
	nombre.text=resource.name
	clean_order()

func _on_button_pressed() -> void:
	var duplicate_res = customer.orden.duplicate()
	var new_item = ticket.instantiate()
	add_child(new_item)
	new_item.global_position= get_viewport_rect().size/2
	orden_cliente=new_item.orden_final
	print(orden_cliente.extras)
	#new_item.orden_entregada
	#new_item.new_pos=get_viewport_rect().size/2
	#new_item.inital_pos=get_viewport_rect().size/2
	#new_item.crear_orden()
	$Button.hide()
	
func clean_order():
	orden_cliente.chilaquil.clear()
	orden_cliente.cocciones.clear()
	orden_cliente.extras.clear()
	orden_cliente.presentacion.clear()
	orden_cliente.sabor.clear()
	orden_cliente.salsas.clear()
	orden_cliente.tamano.clear()
