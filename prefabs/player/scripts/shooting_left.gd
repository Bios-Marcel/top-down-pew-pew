extends "res://prefabs/player/scripts/shooting.gd"

func _is_shooting_frame(frame):
	return frame == 0 or frame == 2
	
func _get_bullet_start_position():
	return player.get_node("GunLeft").global_position