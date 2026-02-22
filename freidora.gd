extends StaticBody2D

var ocupado:bool 
var friendo:bool 

var item_resource:Resource
var coccion:int

func _ready() -> void:
	modulate=Color(Color.YELLOW,0.7)

func _process(delta: float) -> void:
	if friendo:
		var timer = item_resource.cooked_time
		timer -= delta
		item_resource.cooked_time = timer
		_friendo(timer)

func puede_freir():
	friendo = true

func _friendo(tiempo:float):
	#var rango:float = item_resource.cooking_time/10
	#var modulo = fmod(item_resource.cooked_time,rango)

	#if modulo <= 0.01 and modulo >= -0.01:
		#coccion += 1
	#var rango:float=(item_resource.cooking_time)-(item_resource.cooking_time/5) 
	if item_resource.cooked_time >= (item_resource.cooking_time)-(item_resource.cooking_time/5):
		print("CRUDO")
	elif item_resource.cooked_time >= (item_resource.cooking_time)-(item_resource.cooking_time/5)*2:
		print("BLANDO")
	elif item_resource.cooked_time >= (item_resource.cooking_time)-(item_resource.cooking_time/5)*3:
		print("DORADO")
	elif item_resource.cooked_time >= (item_resource.cooking_time)-(item_resource.cooking_time/5)*4:
		print("CRUJIENTE")
	else:
		print("YA SE QUEMO")

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.get_parent().is_in_group("items dropeables") and ocupado == false:
		area.get_parent().can_be_dropped = true
		item_resource = area.get_parent().item_resource
		#area.get_parent().connect("freir",puede_freir)
		ocupado = true
	elif area.get_parent().is_in_group("items dropeables") and ocupado:
		area.get_parent().can_be_dropped = false
		friendo=false
		item_resource = null

func _on_area_2d_area_exited(area: Area2D) -> void:
	if area.get_parent().is_in_group("items dropeables"):
		area.get_parent().can_be_dropped = false
		friendo = false
		item_resource = null
		#area.get_parent().disconnect("freir",puede_freir)
		ocupado = false
