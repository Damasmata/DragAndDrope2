extends Node2D

@onready var cliente_sprite: Sprite2D = $cliente_sprite
@onready var button_sprite: Sprite2D = $Button_sprite

const BOTON_NORMAL = preload("uid://d0a2c0ovf5ywk")
const BOTON_PRESIONADO = preload("uid://bomnj7eqxqs1")

@onready var ticket:PackedScene = preload("res://scenes/ticket.tscn")

var customer:Resource

func set_info(resource:Resource):
	customer=resource
	cliente_sprite.texture=customer.sprite

func _on_button_pressed() -> void:
	var duplicate_res = customer.orden.duplicate()
	var new_item = ticket.instantiate()
	add_child(new_item)
	new_item.global_position= get_viewport_rect().size/2
	#new_item.set_info(duplicate_res)
	$Button_sprite.hide()

func _on_button_button_down() -> void:
	button_sprite.texture=BOTON_PRESIONADO

func _on_button_button_up() -> void:
	button_sprite.texture=BOTON_NORMAL
