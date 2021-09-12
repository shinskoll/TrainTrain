extends KinematicBody2D

export var speed = Vector2(0,0)
var gearV = 0
var origin_pos = transform.origin

enum gear {
	STOP,
	SIXTYFIVE,
	FULLSPEED
}
var gearbox = gear.STOP

func train_speed(delta):
	match gearbox:
		gear.STOP:
			position = position.linear_interpolate(origin_pos+Vector2(-40,0), 0.005)
			speed = speed.linear_interpolate(Vector2(0,0), 0.005)
		gear.SIXTYFIVE:
			position = position.linear_interpolate(origin_pos, 0.002)
			speed = speed.linear_interpolate(Vector2(65,0), 0.002)
		gear.FULLSPEED:
			position = position.linear_interpolate(origin_pos+Vector2(40,0), 0.005)
			speed = speed.linear_interpolate(Vector2(130,0), 0.005)

func manage_gear():
	if Input.is_action_just_pressed("drive"):
		get_node("slowgear").start()
	if Input.is_action_just_released("drive"):
		get_node("slowgear").start()
	
	if get_node("slowgear").time_left > 0:
		gearbox = gear.SIXTYFIVE
		gearV = 1
	elif Input.is_action_pressed("drive"):
		gearbox = gear.FULLSPEED
		get_node("slowgear").stop()
		gearV = 2
	else:
		gearbox = gear.STOP
		get_node("slowgear").stop()
		gearV = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	manage_gear()
	train_speed(delta)
	get_node("speedometer").text = String(speed.x)
	get_node("gearview").text = String(gearV)
