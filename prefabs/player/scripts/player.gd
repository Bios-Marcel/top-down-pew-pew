extends KinematicBody2D

const MOVEMENT_ACCELERATION = 20
const MAX_MOVEMENT_SPEED = 160
const MOVEMENT_ACCELERATION_SPRINTING = MOVEMENT_ACCELERATION * 1.5
const MAX_MOVEMENT_SPEED_SPRINTING = MAX_MOVEMENT_SPEED * 1.5

const nullVector = Vector2()

# Stores the motion/direction the user is currently moving towards.
var motion = Vector2(0, 0)
var sprinting = false

var shooting_left = false setget set_shooting_left
var shooting_right = false setget set_shooting_right

func _physics_process(delta):
	process_mouse_input()
	process_movement()
	process_view_angle()

func process_movement():
	# if the player is holding the sprint key, then we use the values for sprinting
	var sprint_down = Input.is_action_pressed("sprint")
	var actual_max_speed = MAX_MOVEMENT_SPEED_SPRINTING if sprint_down else MAX_MOVEMENT_SPEED 
	var actual_acceleration = MOVEMENT_ACCELERATION_SPRINTING if sprint_down else MOVEMENT_ACCELERATION 

	var mov_accel = Vector2()

	# Add acceleration to the acceleration vector.
	if Input.is_action_pressed("walk_up"):
		mov_accel.y -= actual_acceleration
	if Input.is_action_pressed("walk_down"):
		mov_accel.y += actual_acceleration
	if Input.is_action_pressed("walk_left"):
		mov_accel.x -= actual_acceleration
	if Input.is_action_pressed("walk_right"):
		mov_accel.x += actual_acceleration

	if mov_accel != nullVector:
		# Clamp the acceleration to its maximum. This is to normalize the acceleration when moving diagonally.
		mov_accel = mov_accel.clamped(actual_acceleration)

		# Add the acceleration to the movement.
		motion = motion + mov_accel
		# Clamp the movement to its maximum. It also normalize the movement when moving diagonally.
		motion = motion.clamped(actual_max_speed)

	# Slow down the movement if the player is not pressing any buttons.
	# The X and Y axis are handled seperately as the changes on one axis (Ex. Up/Down, Y Axis)
	# would not have been handled otherwise if you are still holding the other buttons (Ex. Left/Right, X Axis).
	if not(Input.is_action_pressed("walk_up")) and not(Input.is_action_pressed("walk_down")):
		motion.y = lerp(motion.y, 0.0, 0.2)
	if not(Input.is_action_pressed("walk_left")) and not(Input.is_action_pressed("walk_right")):
		motion.x = lerp(motion.x, 0.0, 0.2)

	# If there's any movement to make, do so. Otherwise, make the player idle.
	if motion != nullVector:
		move_and_slide(motion)

	if not(shooting_left or shooting_right):
		$Sprite.play("idle")

func process_view_angle():
	look_at(get_global_mouse_position())

func process_mouse_input():
	self.shooting_left = Input.is_action_pressed("shoot_left")
	self.shooting_right = Input.is_action_pressed("shoot_right")

func set_shooting_left(newValue):
	shooting_left = newValue
	update_shooting_state()

func set_shooting_right(newValue):
	shooting_right = newValue
	update_shooting_state()

func update_shooting_state():
	if shooting_left and shooting_right:
		$Sprite.play("shooting_both")
	elif shooting_left:
		$Sprite.play("shooting_left")
	elif shooting_right:
		$Sprite.play("shooting_right")