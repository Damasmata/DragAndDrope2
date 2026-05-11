extends Node2D

@onready var ticket_place: ColorRect = %TicketPlace


var platillo_final=Node2D

var orden_hecha=Orden.new() #el platillo ya completo

var orden_ticket=Orden.new()

var orden_en_ticket:PanelContainer


func _ready() -> void:
	reiniciar()
	ticket_place.hide()

func reiniciar():
	platillo_final=null
	orden_hecha.chilaquil.clear()
	orden_hecha.cocciones.clear()
	orden_hecha.extras.clear()
	orden_hecha.presentacion.clear()
	orden_hecha.sabor.clear()
	orden_hecha.salsas.clear()
	orden_hecha.tamano.clear()
	ticket_place.hide()

func actualizar():
	orden_hecha=platillo_final.orden_hecha
	print(orden_hecha.chilaquil)
	print(orden_hecha.cocciones)
	print(orden_hecha.presentacion)
	print(orden_hecha.salsas)
	print(orden_hecha.extras)
	print(orden_hecha.tamano)
	print(orden_hecha.sabor)
	
	ticket_place.show()

func check():
	#self.get_property_list()
	orden_en_ticket.button_stopper.show()
	ClienteManager.bandeja_usada=self
	ClienteManager.buscar()


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


func _on_area_2d_2_area_entered(area: Area2D) -> void:
	var ticket_on_area=area.get_parent()
	if ticket_on_area.is_in_group("Ticket"):
		print("ENTRA")
		ticket_on_area.connect("comparar",check)
		ticket_on_area.new_pos=global_position
		orden_en_ticket=ticket_on_area
		orden_ticket=ticket_on_area.orden_hecha


func _on_area_2d_2_area_exited(area: Area2D) -> void:
	var ticket_on_area=area.get_parent()
	if ticket_on_area.is_in_group("Ticket"):
		print("SALE")
		ticket_on_area.disconnect("comparar",check)
		orden_en_ticket=null
		orden_ticket=null
