extends KinematicBody2D

signal entity_died
signal entity_damaged(amount)

var health = 100

func _ready():
	connect("entity_died", self, "_entity_died")
	connect("entity_damaged", self, "_entity_damaged")

func damage(amount):
	health -= amount
	
	emit_signal("entity_damaged", amount)
	
	if health <= 0:
		emit_signal("entity_died")

func _entity_died():
	pass

func _entity_damaged(amount):
	pass