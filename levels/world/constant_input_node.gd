extends Node

func _input(event):
	if event.is_action_pressed("ui_pause"):
		get_parent().get_node("CanvasLayer/Pause").toggle_pause()
	elif event.is_action_pressed("ui_switch_screen_mode"):
		var new_fullscreen_state = not(OS.is_window_fullscreen())
		OS.set_window_fullscreen(new_fullscreen_state)
		
		var pause_menu = get_parent().get_node("CanvasLayer/Pause")
		if pause_menu.visible:
			pause_menu.popup_centered()