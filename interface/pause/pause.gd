extends Control

func toggle_pause():
	var new_pause_state = not get_tree().paused
	get_tree().paused = new_pause_state

	visible = new_pause_state
	if visible:
		$ResumeButton.grab_focus()