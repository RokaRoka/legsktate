extends KinematicBody2D


var input := Vector2()
var velocity := Vector2()

var accel = 5
var decel = .04
var maxSpeed = 320


func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	input = Vector2()
	if Input.is_key_pressed(KEY_W) or Input.is_key_pressed(KEY_UP):
		input += Vector2.UP
	if Input.is_key_pressed(KEY_S) or Input.is_key_pressed(KEY_DOWN):
		input += Vector2.DOWN
	if Input.is_key_pressed(KEY_A) or Input.is_key_pressed(KEY_LEFT):
		input += Vector2.LEFT
	if Input.is_key_pressed(KEY_D) or Input.is_key_pressed(KEY_RIGHT):
		input += Vector2.RIGHT
	
	if input == Vector2.ZERO:
		velocity = velocity.linear_interpolate(Vector2(), decel)
	else:
		velocity += input * accel
	
	velocity = move_and_slide(velocity.clamped(maxSpeed))
	if velocity.length_squared() < 0.01:
		velocity = Vector2.ZERO
	
	if sign(input.x) == 1:
		$Sprite.scale.x = abs($Sprite.scale.x)
	elif sign(input.x) == -1:
		$Sprite.scale.x = -abs($Sprite.scale.x)
	
	if input != Vector2.ZERO:
		var dirDiff = (abs(input.angle()) - abs(velocity.angle()) / PI) + 0.5
		$AnimationPlayer.play("skate", -1, dirDiff)
	else:
		var dirDiff = (abs(input.angle()) - abs(velocity.angle()) / PI) + 0.5
		$AnimationPlayer.play("idle", -1, dirDiff)


func _on_AnimationPlayer_animation_finished(anim_name):
	pass
