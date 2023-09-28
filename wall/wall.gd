extends Node2D

var y_dir = 0

var speed = 100

var offspeed = 600

var useoffspeed = false

# Starting pos
var STARTX = 1153
var MAXY = 55
var MINY = 595

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
	

func move_y(delta):
	position.y -= y_dir * delta * speed
	
	if position.y <= MAXY or position.y >= MINY:
		y_dir *= -1

func reset_to_start():
	# If past the screen reset position and set useoffspeed to false
	if position.x < -10:
		
		# Reset x position
		position.x = STARTX
		
		useoffspeed = false
		
		position.y = choose_random_y()
		
		y_dir = randf_range(-1, 1)

func move_x(delta):
	# Move the wall across the screen
	if not useoffspeed or speed > offspeed:
		position.x -= speed * delta
	elif useoffspeed:
		position.x -= offspeed * delta

func _process(delta):
	# If need reset then reset
	reset_to_start()
	
	# Move across screen
	move_x(delta)
	
	# Move up screen
	move_y(delta)
	
	# Move the wall up and down
	if GlobalVars.score >= 10:
		var y_speed = randf()
