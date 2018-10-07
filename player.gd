extends KinematicBody2D

const DEFAULT_MOVEMENT_SPEED = 50
const ACCELERATION_MOVEMENT_SPEED = 20
const MAX_MOVEMENT_SPEED = 200

var speed = 0

var shooting = false setget set_shooting

func _init():
	#TODO Enable later on, it's quite annoying for now.
	#Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)
	pass

func set_shooting(newValue):
	shooting = newValue
	$Sprite.play("shooting")

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT:
			if event.is_pressed():
				self.shooting = true
			else:
				self.shooting = false

func _physics_process(delta):
	processMovement()
	processViewAngle()
		
func processMovement():
	var movement = Vector2(0, 0)
		
	# Accelerate linear
	speed = min(max(DEFAULT_MOVEMENT_SPEED, speed + ACCELERATION_MOVEMENT_SPEED), MAX_MOVEMENT_SPEED)
	
	if Input.is_key_pressed(KEY_UP)	or Input.is_key_pressed(KEY_W):
		movement.y += -speed
	if Input.is_key_pressed(KEY_LEFT) || Input.is_key_pressed(KEY_A):
		movement.x += -speed
	if Input.is_key_pressed(KEY_DOWN) || Input.is_key_pressed(KEY_S):
		movement.y += speed
	if Input.is_key_pressed(KEY_RIGHT) || Input.is_key_pressed(KEY_D):
		movement.x += speed
	
	# There was a movement on either the vertical or the horizontal axis, therefore we move
	if movement.x != 0 or movement.y != 0:
		move_and_slide(movement)
		
		if !shooting:
			$Sprite.play("moving")
	else:
		# Resetting speed, as no movement happend and therefore acceleration has to happen agai
		if !shooting:
			$Sprite.play("idle")
			
		speed = 0
		
func processViewAngle():
	look_at(get_global_mouse_position())
	
