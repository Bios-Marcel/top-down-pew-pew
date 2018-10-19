extends AnimatedSprite

var bullet_scene
var player

func _ready():
	connect("frame_changed", self, "_frame_changed")

	bullet_scene = load("res://prefabs/bullet/bullet.tscn")
	player = get_parent()

func _frame_changed():
	if _is_shooting_frame(frame):
		fire_bullet(_get_bullet_start_position(), player.rotation_degrees)

func fire_bullet(startpos, degree):
	var new_bullet = bullet_scene.instance()
	get_tree().get_root().add_child(new_bullet)
	
	new_bullet.set_rotation_degrees(degree)
	new_bullet.set_position(startpos)

func _is_shooting_frame(frame):
	return false

func _get_bullet_start_position():
	return Vector2(0, 0)