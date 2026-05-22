class_name clienteManager
extends Node

var ticket_number:int=0

var clientes:Array[Node2D]=[]

var cliente_calificado:Node2D

var bandeja_usada:Node2D

var cliente_ordenando: bool = false


func buscar():
	for clientela in clientes.size():
		var orden_cliente=clientes[clientela].orden_cliente
		if bandeja_usada.orden_ticket==orden_cliente:
			cliente_calificado=clientes[clientela]
			cliente_calificado.change_state()
			print("LO ENCONTRÓ")

func calificar():
	var calf_est2: float =0
	var calf_est3: float =0
	var calf_est4: float =0
	var calf_final:float =0
	
	var tops_size_cliente=cliente_calificado.orden_cliente.extras.size()+1
	
	if bandeja_usada.orden_hecha.chilaquil==cliente_calificado.orden_cliente.chilaquil:
		calf_est2+=33
	
	if bandeja_usada.orden_hecha.presentacion==cliente_calificado.orden_cliente.presentacion:
		calf_est2+=33
	
	if bandeja_usada.orden_hecha.cocciones==cliente_calificado.orden_cliente.cocciones:
		calf_est2+=34
	
	
	if bandeja_usada.orden_hecha.salsas==cliente_calificado.orden_cliente.salsas:
		calf_est3+=100/tops_size_cliente
	
	if bandeja_usada.orden_hecha.extras.size()<tops_size_cliente and bandeja_usada.orden_hecha.extras.size()!=0:
		for topping in tops_size_cliente-1:
			if bandeja_usada.orden_hecha.extras[topping]==cliente_calificado.orden_cliente.extras[topping]:
				calf_est3+=100/tops_size_cliente
	
	
	if bandeja_usada.orden_hecha.tamano==cliente_calificado.orden_cliente.tamano:
		calf_est4+=33
		if bandeja_usada.platillo_final.drink_node.texture_progress_bar.value==bandeja_usada.platillo_final.drink_node.texture_progress_bar.max_value/7:
			calf_est4+=34
		print(bandeja_usada.platillo_final.drink_node.texture_progress_bar.value)
	
	if bandeja_usada.orden_hecha.sabor==cliente_calificado.orden_cliente.sabor:
		calf_est4+=33
	
	
	calf_final=calf_est2+calf_est3+calf_est4
	
	print(calf_final)
	
	cliente_calificado.hide()
	if calf_final>=200:
		Dialogic.VAR.set_variable("historia",+3)
		print("QUE BIEN")
	elif calf_final>=100:
		print("QUE BIEN")
		Dialogic.VAR.set_variable("historia",+2)
		print("MAS O MENOS")
	else:
		Dialogic.VAR.set_variable("historia",+1)
		print("QUE MAL")
		
	terminar_dia()

func terminar_dia():
	pass
	
	#if clientes.all()
	
	#get_tree().change_scene_to_file("res://Dialogic elements/timelines/dia1_2.dtl")
	#Dialogic.start("dia1_2")
	
	#cualquiera de las dos formas funciona
	#si todos los clientes estan en el ultimo estado, se inicia dia1_2.dtl
