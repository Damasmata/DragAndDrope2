class_name clienteManager
extends Node

var ticket_number:int=0

var clientes:Array[Node2D]=[]

var cliente_calificado:Node2D

var bandeja_usada:Node2D

var cliente_ordenando: bool = false

var cliente_en_espera:bool=false

var cliente_calificando: bool=false

var game_camera: Camera2D



func buscar():
	for clientela in clientes.size():
		var orden_cliente=clientes[clientela].orden_cliente
		if bandeja_usada.orden_ticket==orden_cliente:
			cliente_calificado=clientes[clientela]
			cliente_calificado.change_state()
			print("LO ENCONTRÓ")

#func disable_cam():
	#if game_camera.est_1.disabled==false:
		#game_camera.est_1.disabled=true
		#game_camera.est_2.disabled=true
		#game_camera.est_3.disabled=true
		#game_camera.est_4.disabled=true
	#else:
		#game_camera.est_1.disabled=false
		#game_camera.est_2.disabled=false
		#game_camera.est_3.disabled=false
		#game_camera.est_4.disabled=false

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
		if bandeja_usada.platillo_final.drink_node.texture_progress_bar.value<=(bandeja_usada.platillo_final.drink_node.texture_progress_bar.max_value/10)*7:
			var suma_tamano=bandeja_usada.platillo_final.drink_node.texture_progress_bar.value*0.4857
			calf_est4+=suma_tamano
			print("LA SUMA ES: ",suma_tamano)
		else:
			var resta_tamano=(bandeja_usada.platillo_final.drink_node.texture_progress_bar.value*1.13)
			calf_est4+=34-resta_tamano
			print("LA RESTA ES: ",resta_tamano)
		print(bandeja_usada.platillo_final.drink_node.texture_progress_bar.value)
	
	if bandeja_usada.orden_hecha.sabor==cliente_calificado.orden_cliente.sabor:
		calf_est4+=33
	
	
	calf_final=calf_est2+calf_est3+calf_est4
	
	print(calf_final)
	
	#cliente_calificado.hide()
	cliente_calificado.change_state()
	if calf_final>=200:
		Dialogic.VAR.set_variable("historia",+3)
		print("QUE BIEN")
		cliente_calificado.cliente_sprite.texture=cliente_calificado.text_bien
	elif calf_final>=100:
		Dialogic.VAR.set_variable("historia",+2)
		cliente_calificado.cliente_sprite.texture=cliente_calificado.text_maso
		print("MAS O MENOS")
	else:
		Dialogic.VAR.set_variable("historia",+1)
		cliente_calificado.cliente_sprite.texture=cliente_calificado.text_mal
		print("QUE MAL")
		
		DishManager.platillo_final.queue_free()
		
	#terminar_dia()
	DishManager.platillo_final.queue_free()
	game_camera.est_1.button_pressed=true
	game_camera.est_4.button_pressed=false

func comparar_estado(client:Node2D):
	return client.estado==4

func terminar_dia():
	if clientes.all(comparar_estado):
		
		NovelaManager.next_scene="dia1_2"
		get_tree().change_scene_to_file("res://scenes/novela.tscn")
