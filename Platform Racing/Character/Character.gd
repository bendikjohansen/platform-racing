extends KinematicBody2D

onready var sprite = $AnimatedSprite
onready var left_ray = $Left
onready var right_ray = $Right

const ACCELERATION := 100
const FRICTION := 0.2
const JUMP_FORCE := 600
const GRAVITY := 30
var velocity := Vector2.ZERO

var _movement: float = 0

puppet var puppet_position = global_position

func move(movement: float):
	_movement = movement * ACCELERATION

func jump():
	if is_on_floor():
		velocity += Vector2.UP.rotated(rotation) * JUMP_FORCE
	elif left_ray.is_colliding() or right_ray.is_colliding():
		var horizontal_jump = Vector2.LEFT if right_ray.is_colliding() else Vector2.RIGHT
		var jump_velocity = Vector2.UP + horizontal_jump / 2
		velocity = jump_velocity * JUMP_FORCE

func _physics_process(delta: float):
	if true:#is_network_master():
		if not is_on_floor() and velocity.y < -JUMP_FORCE / 2  and (left_ray.is_colliding() or right_ray.is_colliding()):
			if Input.is_action_pressed("move_right") and velocity.x > 0:
				velocity.x += JUMP_FORCE / 4
			elif Input.is_action_pressed("move_left") and velocity.x < 0:
				velocity.x -= JUMP_FORCE / 4
		if is_on_floor():
			velocity.x += _movement
			velocity.x = lerp(velocity.x, 0, FRICTION)
		else:
			velocity.x += _movement / 10
			velocity.x = lerp(velocity.x, 0, FRICTION / 10)

		if (left_ray.is_colliding() or right_ray.is_colliding()) and velocity.y > 0:
			velocity.y += GRAVITY / 10
		else:
			velocity.y += GRAVITY


		sprite.turn(_movement)

		velocity = move_and_slide(velocity, Vector2.UP)
		rset_unreliable("puppet_position", global_position)
	else:
		global_position = lerp(global_position, puppet_position, 400)
