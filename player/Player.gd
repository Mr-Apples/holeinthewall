extends CharacterBody2D

# Joystick
var joy_dir = Vector2(0, 0)
var joy_str = Vector2(0, 0)
var joy_del = 0

const SPEED = 300.0

# Updates the x velocity
func update_x_velocity():
	# Get the x direction
	var direction = Input.get_axis("player_left", "player_right")
	
	# If the direction is not 0 then increase velocity
	if direction:
		velocity.x = direction * SPEED
	# Else don't move
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

func update_y_velocity():
	# Get the y direction
	var direction = Input.get_axis("player_up", "player_down")
	
	# If the direction is not 0 then increase velocity
	if direction:
		velocity.y = direction * SPEED
	# Else don't move
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)
		
func update_joystick_velocity():
	velocity = joy_dir * joy_str * SPEED

func _physics_process(_delta):
	# Update x velocity
	update_x_velocity()
	
	# Update y velocity
	update_y_velocity()
	
	# Check if to use joystick
	if velocity.x == 0 and velocity.y ==0:
		update_joystick_velocity()
	
	# Update position
	move_and_slide()


func _on_actual_joystick_joystick_input(strength, direction, delta):
	joy_dir = direction
	joy_str = strength
	joy_del = delta
