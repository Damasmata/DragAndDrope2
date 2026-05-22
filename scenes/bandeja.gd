extends Node2D


var platillo_final=Node2D

var orden_hecha=Orden.new() #el platillo ya completo

var orden_ticket=Orden.new() #la orden del ticket

var orden_en_ticket:PanelContainer #el nodo del ticket

@onready var game_camera: Camera2D = %GameCamera



func _ready() -> void:
	reiniciar()

func reiniciar():
	platillo_final=null
	orden_hecha.chilaquil.clear()
	orden_hecha.cocciones.clear()
	orden_hecha.extras.clear()
	orden_hecha.presentacion.clear()
	orden_hecha.sabor.clear()
	orden_hecha.salsas.clear()
	orden_hecha.tamano.clear()
	print("SE REINICIA")
	print(platillo_final)
	DishManager.order_finish=false

func actualizar():
	orden_hecha=platillo_final.orden_hecha
	print(orden_hecha.chilaquil)
	print(orden_hecha.cocciones)
	print(orden_hecha.presentacion)
	print(orden_hecha.salsas)
	print(orden_hecha.extras)
	print(orden_hecha.tamano)
	print(orden_hecha.sabor)
	DishManager.order_finish=true

func check():
	#self.get_property_list()
	orden_en_ticket.queue_free()
	ClienteManager.bandeja_usada=self
	ClienteManager.buscar()
	game_camera.global_position=game_camera.camera_positions[0]
	game_camera.change_buttons()


func _on_area_2d_area_entered(area: Area2D) -> void:
	var platillo=area.get_parent()
	if platillo.is_in_group("item"):
		platillo.connect("servido",actualizar)
		platillo_final=platillo


func _on_area_2d_area_exited(area: Area2D) -> void:
	var platillo=area.get_parent()
	if platillo.is_in_group("item"):
		platillo.disconnect("servido",actualizar)
		reiniciar()
