extends StaticBody2D

@onready var color_rect: ColorRect = $ColorRect

var place_resource:Resource

var item_resource:Resource

var objeto:Node2D

var ocupado:bool

func set_info(resource):
	place_resource=resource
	color_rect.color=resource.colorrect
	add_to_group(resource.groupname)

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.get_parent().is_in_group("servidores"):
		area.get_parent().can_be_dropped = true
		item_resource = area.get_parent().item_resource
		objeto = area.get_parent()
		ocupado=true

func _on_area_2d_area_exited(area: Area2D) -> void:
	area.get_parent().can_be_dropped = false
	item_resource = null
	objeto=null
