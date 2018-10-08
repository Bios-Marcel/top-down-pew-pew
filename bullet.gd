extends Area2D

const bulletSpeed = 10

func _physics_process(delta):
	move_local_x(bulletSpeed)
	pass
