extends Control

func _input(event):
	if event.is_action_pressed("ui_pause"):
		toggle_pause()
	else:
		handle_focus()

func handle_focus():
	if event.is_action_pressed("ui_down"):
		if $ResumeButton.has_focus():
			$ExitButton.grab_focus()
		elif $ExitButton.has_focus():
			$ResumeButton.grab_focus()
	elif event.is_action_pressed("ui_up"):
		if $ResumeButton.has_focus():
			$ExitButton.grab_focus()
		elif $ExitButton.has_focus():
			$ResumeButton.grab_focus()

func toggle_pause():
	var new_pause_state = not get_tree().paused
	get_tree().paused = new_pause_state

	visible = new_pause_state
	if visible:
		$ResumeButton.grab_focus()