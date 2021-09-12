extends Node2D

var gareScene = preload("res://Gare.tscn")
export var distance = 0
export var points = 100
var gareNear = false
var gar

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if $Train.speed.x > 0:
		distance = distance + $Train.speed.x / 3600
	points += distance
	
	$score.text = String(int(points))
	gareSpawn()


func gareSpawn():
	if distance > 10 && gareNear == false:
		$GareInc.start()
		gareNear = true
		distance = 0


func _on_GareInc_timeout():
	if rand_range(0,10) > 9:
		gar = gareScene.instance()
		add_child(gar)
		gar.position = Vector2(800,284)
		gareNear = false
		$GareInc.stop()
	else:
		$GareInc.start()
