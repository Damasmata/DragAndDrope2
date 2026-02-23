extends Camera2D

@export var camera_positions:Array[Vector2] = [Vector2(1152/2,648/2),Vector2((1152/2)+1152,648/2)]
@export var speed:float

var moving_camera:bool
var next_pos
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	global_position = camera_positions[0]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !moving_camera:
		change_camera_pos(delta)
	else:
		global_position.x = move_toward(global_position.x,next_pos.x,delta * speed)
		if global_position.x == next_pos.x:
			moving_camera = false

func change_camera_pos(_delta:float):
	if Input.is_action_just_pressed("camera_change"):
		for pos in camera_positions:
			if pos.x != global_position.x:
				next_pos = pos
		moving_camera = true
