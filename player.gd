extends KinematicBody2D

const MOVEMENT_ACCELERATION = 25
const MAX_MOVEMENT_SPEED = 200
const nullVector = Vector2()

# Stores the motion/direction the user is currently moving towards.
var motion = Vector2(0, 0)
var shooting = false setget set_shooting

func _init():
	# TODO Enable later on, it's quite annoying for now.
	# Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)
	pass

func _physics_process(delta):
	processMovement()
	processViewAngle()
	processProjectiles()

func processMovement():
	if Input.is_action_pressed("ui_up"):
		motion.y = max(motion.y - MOVEMENT_ACCELERATION, -MAX_MOVEMENT_SPEED)
	if Input.is_action_pressed("ui_down"):
		motion.y = min(motion.y + MOVEMENT_ACCELERATION, MAX_MOVEMENT_SPEED)
	if Input.is_action_pressed("ui_left"):
		motion.x = max(motion.x - MOVEMENT_ACCELERATION, -MAX_MOVEMENT_SPEED)
	if Input.is_action_pressed("ui_right"):
		motion.x = min(motion.x + MOVEMENT_ACCELERATION, MAX_MOVEMENT_SPEED)
	
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
	
	if not(shooting):
		$Sprite.play("idle")

func processViewAngle():
	look_at(get_global_mouse_position())

func processProjectiles():
	pass

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT:
			if event.is_pressed():
				self.shooting = true
			else:
				self.shooting = false

func set_shooting(newValue):
	shooting = newValue
	$Sprite.play("shooting")
