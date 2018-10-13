extends KinematicBody2D

const MOVEMENT_ACCELERATION = 25
const MAX_MOVEMENT_SPEED = 200
const MAX_DIAG_MOVEMENT_SPEED = MAX_MOVEMENT_SPEED * 0.707
const nullVector = Vector2()

# Stores the motion/direction the user is currently moving towards.
var motion = Vector2(0, 0)
var shooting_left = false setget set_shooting_left
var shooting_right = false setget set_shooting_right

func _init():
	Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)

func _physics_process(delta):
	process_mouse_input()
	process_movement()
	process_view_angle()

func process_movement():
	if Input.is_action_pressed("ui_up"):
		motion.y = max(motion.y - MOVEMENT_ACCELERATION, -MAX_MOVEMENT_SPEED)
	if Input.is_action_pressed("ui_down"):
		motion.y = min(motion.y + MOVEMENT_ACCELERATION, MAX_MOVEMENT_SPEED)
	if Input.is_action_pressed("ui_left"):
		motion.x = max(motion.x - MOVEMENT_ACCELERATION, -MAX_MOVEMENT_SPEED)
	if Input.is_action_pressed("ui_right"):
		motion.x = min(motion.x + MOVEMENT_ACCELERATION, MAX_MOVEMENT_SPEED)

	# Clamp the movement speed further if moving diagonally.
	if ((Input.is_action_pressed("ui_up") || Input.is_action_pressed("ui_down"))
		&& (Input.is_action_pressed("ui_left") || Input.is_action_pressed("ui_right"))):
		motion.x = clamp(motion.x, -MAX_DIAG_MOVEMENT_SPEED, MAX_DIAG_MOVEMENT_SPEED)
		motion.y = clamp(motion.y, -MAX_DIAG_MOVEMENT_SPEED, MAX_DIAG_MOVEMENT_SPEED)

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

func process_view_angle():
	look_at(get_global_mouse_position())

func process_mouse_input():
	self.shooting_left = Input.is_mouse_button_pressed(BUTTON_LEFT)
	self.shooting_right = Input.is_mouse_button_pressed(BUTTON_RIGHT)

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