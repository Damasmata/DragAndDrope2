extends Control

@onready var tickets: HBoxContainer = %tickets

var ticket_on:Array[Control]=[]

var pos:Vector2


#func ticket_pos():
	#pass

func _on_area_2d_area_entered(area: Area2D) -> void:
	var new_ticket=area.get_parent()
	if new_ticket.is_in_group("Ticket"):
		#new_ticket.connect("tira_pos",ticket_pos)
		#new_ticket.get_parent().global_position= Vector2(600,global_position.y+(new_ticket.size.y/2)) #Vector2(global_position.x-new_ticket.global_position.x, global_position.y)
		new_ticket.reparent(tickets)


#func _on_area_2d_area_exited(area: Area2D) -> void:
	#var new_ticket=area.get_parent()
	#if new_ticket.is_in_group("Ticket"):
		##new_ticket.connect("tira_pos",ticket_pos)
		##new_ticket.get_parent().global_position= Vector2(600,global_position.y+(new_ticket.size.y/2)) #Vector2(global_position.x-new_ticket.global_position.x, global_position.y)
		#new_ticket.reparent(tickets)
