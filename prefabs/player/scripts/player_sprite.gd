extends AnimatedSprite

var bullet_scene
var player

func _ready():
	connect("frame_changed", self, "_frame_changed")

	bullet_scene = load("res://prefabs/bullet/bullet.tscn")
	player = get_parent()

func _frame_changed():
	match animation:
		"shooting_both":
			match frame:
				0,2:
					fire_right_bullet()
				1,3:
					fire_left_bullet()
		"shooting_left":
			match frame:
				0,2:
					fire_left_bullet()
		"shooting_right":
			match frame:
				1,3:
					fire_right_bullet()

# We are using a little hack to determine the bullets starting position.
# Each gun has an empty marker node that determines where a bullet starts to fly from.

func fire_left_bullet():
	var gun_left = player.get_node("GunLeft")
	fire_bullet(gun_left.global_position, player.rotation_degrees)

func fire_right_bullet():
	var gun_right = player.get_node("GunRight")
	fire_bullet(gun_right.global_position, player.rotation_degrees)

func fire_bullet(startpos, degree):
	var new_bullet = bullet_scene.instance()
	# We are expect the parent of the parent to be the "World" and inside of that "World"
	# we want to add the new bullet, but it has to be below the "Player". 
	get_parent().get_parent().add_child_below_node(get_parent(), new_bullet)
	
	new_bullet.set_rotation_degrees(degree)
	new_bullet.set_position(startpos)