extends RigidBody2D

enum {INIT, ALIVE, INVULNERABLE, DEAD}

# Scene or script imports (preloads)
# var Player = preload("res://Player.tscn")

# Signals (signal names must be in past tense)
signal shoot

# Class public attributes, aka those which might be modified from outside the class.
export (PackedScene) var Bullet
export (float) var fire_rate

export (int) var engine_power
export (int) var spin_power

var state = null
var can_shoot = true

var thrust = Vector2()
var rotation_dir = 0

var screensize = Vector2()

# Node references
# onready var sprite = $Sprite

# Class private API: variables that should not be modified from outside the class.
# var _current_health


# Override methods(2 blank space between them)
func _ready():
	change_state(ALIVE)
	screensize = get_viewport().get_visible_rect().size
	$GunTimer.wait_time = fire_rate


func _process(delta):
	get_input()


func _integrate_forces(physics_state):
	set_applied_force(thrust.rotated(rotation))
	set_applied_torque(spin_power * rotation_dir)
	var xform = physics_state.get_transform()
	if xform.origin.x > screensize.x:
		xform.origin.x = 0
	if xform.origin.x < 0:
		xform.origin.x = screensize.x
	if xform.origin.y > screensize.y:
		xform.origin.y = 0
	if xform.origin.y < 0:
		xform.origin.y = screensize.y
	physics_state.set_transform(xform)


# Public Methods(2 blank space between them)
func change_state(new_state):
	match new_state:
		INIT:
			$CollisionShape2D.disabled = true
		ALIVE:
			$CollisionShape2D.disabled = false
		INVULNERABLE:
			$CollisionShape2D.disabled = true
		DEAD:
			$CollisionShape2D.disabled = true
	state = new_state


func get_input():
	thrust = Vector2()

	if state in [DEAD, INIT]:
		return

	if Input.is_action_pressed("thrust"):
		thrust = Vector2(engine_power, 0)
	rotation_dir = 0
	if Input.is_action_pressed("rotate_right"):
		rotation_dir += 1
	if Input.is_action_pressed("rotate_left"):
		rotation_dir -= 1

	if Input.is_action_pressed("shoot") and can_shoot:
		shoot()


func shoot():
	if state == INVULNERABLE:
		return
	emit_signal("shoot", Bullet, $Muzzle.global_position, rotation)
	can_shoot = false
	$GunTimer.start()


# Class private methods(2 blank space between them)
func _on_GunTimer_timeout():
	can_shoot = true
