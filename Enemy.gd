extends "Entity.gd"

func _entity_damaged(amount):
	print(health)

func _entity_died():
	print("You killed someone! You absolute MONSTER!")
	queue_free()

func get_shot():
	damage(15)
