extends Control

@onready var tickets: HBoxContainer = %tickets

var ticket_on:Control

var pos:Vector2


#func ticket_pos():
	#var child_node=ticket_on
	#if child_node.get_parent():
		#child_node.get_parent().remove_child(child_node)
	#tickets.add_child(child_node)
	#child_node.global_position=global_position

func _on_area_2d_area_entered(area: Area2D) -> void:
	var new_ticket=area.get_parent()
	if new_ticket.is_in_group("Ticket"):
		new_ticket.reparent(tickets)
		new_ticket.can_be_dropped=true
		#new_ticket.connect("tira_pos",ticket_pos)
		new_ticket.new_pos= Vector2(600,global_position.y+(new_ticket.size.y/2)) #Vector2(global_position.x-new_ticket.global_position.x, global_position.y)
		print("ENTRA")


func _on_area_2d_area_exited(area: Area2D) -> void:
	var new_ticket=area.get_parent()
	if new_ticket.is_in_group("Ticket"):
		new_ticket.can_be_dropped=false
		#new_ticket.disconnect("tira_pos",ticket_pos)
		#new_ticket.reparent(tickets)
		print("SALE")
		
