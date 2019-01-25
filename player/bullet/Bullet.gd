extends Area2D

# Scene or script imports (preloads)
# var Player = preload("res://Player.tscn")

# Signals (signal names must be in past tense)
# signal game_started

# Class public attributes, aka those which might be modified from outside the class.
export (int) var speed
var velocity = Vector2()

# Node references
# onready var sprite = $Sprite

# Class private API: variables that should not be modified from outside the class.
# var _current_health


# Override methods(2 blank space between them)
func _ready():
	pass


func _process(delta):
	position += delta * velocity


# Public Methods(2 blank space between them)
func start(pos, dir):
	position = pos
	rotation = dir
	velocity = Vector2(speed, 0).rotated(dir)


# Class private methods(2 blank space between them)

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func _on_Bullet_area_entered(area):
	if area.is_in_group('rocks'):
		area.explode()
		queue_free()
