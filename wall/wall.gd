extends Node2D

var speed = 100

var offspeed = 600

var useoffspeed = false

# Starting pos
var STARTX = 1153
var MAXY = 0
var MINY = 650

signal died()

signal player_scored()

func _ready():
	randomize()
	GlobalVars.score = 0

func _on_wall_body_entered(body):
	if body.name == "Player":
		died.emit()


func _on_hole_body_entered(body):
	if body.name == "Player":
		GlobalVars.score += 1
		speed += 20
		useoffspeed = true
		player_scored.emit()

func choose_random_y():
	var randomy = randf_range(MINY, MAXY)
	return randomy

func _process(delta):
	# If past the screen reset position and set useoffspeed to false
	if position.x < -10:
		# Reset y position
		position.y = choose_random_y()
		
		# Reset x position
		position.x = STARTX
		
		useoffspeed = false
	
	# Move the wall across the screen
	if not useoffspeed or speed > offspeed:
		position.x -= speed * delta
	elif useoffspeed:
		position.x -= offspeed * delta
