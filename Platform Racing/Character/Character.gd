extends KinematicBody2D

onready var sprite = $AnimatedSprite

const ACCELERATION := 100
const FRICTION := 0.2
const JUMP_FORCE := 600
const GRAVITY := 30
var velocity := Vector2.ZERO

var _movement: float = 0
var _can_double_jump := true

puppet var puppet_position = global_position

func move(movement: float):
	_movement = movement * ACCELERATION

func jump():
	if is_on_floor():
		velocity += Vector2.UP.rotated(rotation) * JUMP_FORCE
	elif _can_double_jump:
		_can_double_jump = false
		velocity.y = -JUMP_FORCE * 0.8

func _physics_process(delta: float):
	if is_network_master():
		_can_double_jump = is_on_floor() or _can_double_jump

		rotation = lerp_angle(rotation, sign(int(_movement)) * PI / 12, 0.1)
		velocity.x = lerp(velocity.x + _movement, 0, FRICTION)
		velocity.y += GRAVITY

		sprite.turn(_movement)

		velocity = move_and_slide(velocity, Vector2.UP)
		rset_unreliable("puppet_position", global_position)
	else:
		global_position = puppet_position

func _on_Timer_timeout():
	pass
