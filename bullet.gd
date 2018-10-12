extends Area2D

const bulletSpeed = 10

func _physics_process(delta):
	move_local_x(bulletSpeed)
	pass


func _on_Bullet_body_entered(body):
	if body.has_method("been_shot"):
		body.been_shot()
	queue_free()
