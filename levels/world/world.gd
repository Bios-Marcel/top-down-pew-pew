extends Node

func _input(event):
	if event is InputEventKey and event.is_action_pressed("ui_switch_screen_mode"):
		OS.set_window_fullscreen(not(OS.is_window_fullscreen()))