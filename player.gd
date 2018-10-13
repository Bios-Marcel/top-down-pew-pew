extends KinematicBody2D

const MOVEMENT_ACCELERATION = 25
const MAX_MOVEMENT_SPEED = 200
const nullVector = Vector2()

# Stores the motion/direction the user is currently moving towards.
var motion = Vector2(0, 0)
var shooting_left = false setget set_shooting_left
var shooting_right = false setget set_shooting_right

func _init():
	# TODO Enable later on, it's quite annoying for now.
	# Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)
	pass

func _physics_process(delta):
	processMovement()
	processViewAngle()
	processProjectiles()

func processMovement():

	var mov_accel = Vector2()	
	
	# Add acceleration to the acceleration vector.
	if Input.is_action_pressed("ui_up"):
		mov_accel.y -= MOVEMENT_ACCELERATION
	if Input.is_action_pressed("ui_down"):
		mov_accel.y += MOVEMENT_ACCELERATION
	if Input.is_action_pressed("ui_left"):
		mov_accel.x -= MOVEMENT_ACCELERATION
	if Input.is_action_pressed("ui_right"):
		mov_accel.x += MOVEMENT_ACCELERATION
	
	if mov_accel != nullVector:
		# Clamp the acceleration to its maximum. This is to normalize the acceleration when moving diagonally.
		mov_accel = mov_accel.clamped(MOVEMENT_ACCELERATION)
	
		# Add the acceleration to the movement.
		motion = motion + mov_accel
		# Clamp the movement to its maximum. It also normalize the movement when moving diagonally.
		motion = motion.clamped(MAX_MOVEMENT_SPEED)

	# Slow down the movement if the player is not pressing any buttons.
	# The X and Y axis are handled seperately as the changes on one axis (Ex. Up/Down, Y Axis)
	# would not have been handled otherwise if you are still holding the other buttons (Ex. Left/Right, X Axis).
	if not(Input.is_action_pressed("ui_up")) and not(Input.is_action_pressed("ui_down")):
		motion.y = lerp(motion.y, 0.0, 0.2)
	if not(Input.is_action_pressed("ui_left")) and not(Input.is_action_pressed("ui_right")):
		motion.x = lerp(motion.x, 0.0, 0.2)

	# If there's any movement to make, do so. Otherwise, make the player idle.
	if motion != nullVector:
		move_and_slide(motion)

	if not(shooting_left or shooting_right):
		$Sprite.play("idle")

func processViewAngle():
	look_at(get_global_mouse_position())

func processProjectiles():
	pass

func _input(event):
	if event is InputEventMouseButton:
		match event.button_index:
			BUTTON_LEFT:
				self.shooting_left = event.is_pressed()
			BUTTON_RIGHT:
				self.shooting_right = event.is_pressed()

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