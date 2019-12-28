extends CheckButton

onready var options = get_node("/root/World/Options")

func _toggled(button_pressed):
	options.controller_aim = button_pressed