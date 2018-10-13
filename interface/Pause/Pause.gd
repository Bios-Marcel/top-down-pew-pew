extends Control

func _input(event):
	if event.is_action_pressed("ui_pause"):
		var new_pause_state = not get_tree().paused
		get_tree().paused = new_pause_state

		visible = new_pause_state
		if visible:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		else:
			var mouse_pos = get_global_mouse_position()
			print(mouse_pos)
			Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)
			Input.warp_mouse_position(mouse_pos)