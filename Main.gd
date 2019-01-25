extends Node

# Scene or script imports (preloads)
# var Player = preload("res://Player.tscn")

# Signals (signal names must be in past tense)
# signal game_started

# Class public attributes, aka those which might be modified from outside the class.
# export (int) var max_health = 3

# Node references
# onready var sprite = $Sprite

# Class private API: variables that should not be modified from outside the class.
# var _current_health


# Override methods(2 blank space between them)
func _ready():
	pass


# Public Methods(2 blank space between them)


# Class private methods(2 blank space between them)

func _on_Player_shoot(Bullet, pos, dir):
	var b = Bullet.instance()
	b.start(pos, dir)
	add_child(b)

