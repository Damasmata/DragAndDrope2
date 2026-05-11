extends Control

@onready var tickets: HBoxContainer = %tickets

var ticket_on:Control

var pos:Vector2

var with_ticket:bool

func _process(delta: float) -> void:
	if with_ticket:
		ticket_pos()

func ticket_pos():
	ticket_on.new_pos= Vector2(get_global_mouse_position().x,0)#Vector2(600,global_position.y+(new_ticket.size.y/2)) 

func _on_area_2d_area_entered(area: Area2D) -> void:
	var new_ticket=area.get_parent()
	if new_ticket.is_in_group("Ticket"):
		new_ticket.new_parent = self
		new_ticket.can_be_dropped=true
		with_ticket=true
		print("ENTRA")
		ticket_on=new_ticket


func _on_area_2d_area_exited(area: Area2D) -> void:
	var new_ticket=area.get_parent()
	if new_ticket.is_in_group("Ticket"):
		new_ticket.can_be_dropped=false
		with_ticket=false
		print("SALE")
