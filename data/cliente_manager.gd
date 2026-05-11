class_name clienteManager
extends Node


var clientes:Array[Node2D]=[]

var cliente_calificado:Node2D

var bandeja_usada:Node2D

func buscar():
	for clientela in clientes.size():
		var orden_cliente=clientes[clientela].orden_cliente
		if bandeja_usada.orden_ticket==orden_cliente:
			#bandeja_usada.queue_free()
			cliente_calificado=clientes[clientela]
			clientes[clientela].estado=1

func calificar():
	print(bandeja_usada.orden_entregada==cliente_calificado.orden_cliente)
	cliente_calificado.hide()
