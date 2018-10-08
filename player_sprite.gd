extends AnimatedSprite

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var bullet_scene
var player

func _ready():
	bullet_scene = load("res://bullet.tscn")
	player = get_parent()
	
	connect("frame_changed", self, "_frame_changed")

func _frame_changed():
	if animation == "shooting":
		match frame:
			0,2:
				fire_right_bullet()
			1,3:
				fire_left_bullet()

# We are using a little click to determine the bullets starting position.
# Each gun has an empty marker node that determines where a bullet starts to fly from.

func fire_left_bullet():
	var gun_left = player.get_node("GunLeft")
	fire_bullet(gun_left.position, player.rotation_degrees)

func fire_right_bullet():
	var gun_right = player.get_node("GunRight")
	fire_bullet(gun_right.position, player.rotation_degrees)

func fire_bullet(startpos, degree):
	var new_bullet = bullet_scene.instance()
	new_bullet.set_rotation(degree)
	
	add_child(new_bullet)