#extends KinematicBody2D
#
#
#const MAX_SPEED : int = 260 # Pixels/second.
#const ACCELERATION_MODIFIER : int = 1500 # Pixels/second
#const DRAG_COEF : float = -0.999 # Ratio
#const AIR_DRAG : float = -0.3 # Ratio
#const VELOCITY_TO_STOP_DRAGGING : int = 16 # Pixels/second
#const JUMP_ACCELERATION : int = 17 # Some unit, not really sure what tbh
#const WALL_JUMP_ACCELERATION : int = 12 # see above comment
#const GRAVITY : int = 1 # See above comment
#
#var velocity = Vector2(0,0)
#
## Called when the node enters the scene tree for the first time.
#func _ready():
#	pass # Replace with function body.
#
#
## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _physics_process(delta):
#	var acceleration = Vector2(0,0)
#	if Input.is_action_pressed("ui_right"):
#		acceleration.x += 1
#	if Input.is_action_pressed("ui_left"):
#		acceleration.x -= 1
#	velocity += acceleration * delta
#	move_and_slide(velocity)


extends KinematicBody2D

const MAX_WALK_SPEED : int = 260 # Pixels/second.
const WALK_ACCELERATION : int = 1500 # Pixels/second2
const WALK_DECELERATION : int = 500 # Pixels/second2
const AIR_DRAG : float = -0.3 # Ratio
const VELOCITY_TO_STOP_DRAGGING : int = 16 # Pixels/second
const JUMP_ACCELERATION : int = 17 # Some unit, not really sure what tbh
const WALL_JUMP_ACCELERATION : int = 12 # see above comment
const GRAVITY_ACCELERATION : int = 100 # Pixels/second2

#onready var on_ground = $OnGround
#onready var on_ground_left = $OnGroundLeft
#onready var on_ground_right = $OnGroundRight
#onready var on_left_wall = $OnLeftWall
#onready var on_right_wall = $OnRightWall

var velocity = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


#func is_on_ground():
#	return on_ground.is_colliding() or on_ground_left.is_colliding() or on_ground_right.is_colliding()


func _physics_process(delta):
	var acceleration = Vector2(0,0)  # The player's movement vector.
	
	#Apply gravity
	#acceleration.y = GRAVITY_ACCELERATION
	
	#Apply acceleration left and right
	if Input.is_action_pressed("ui_right"):
		acceleration.x += WALK_ACCELERATION
	if Input.is_action_pressed("ui_left"):
		acceleration.x -= WALK_ACCELERATION
	
	#If no left or right input is pressed...
	if(acceleration.x == 0):
		#And the player is currently in motion left or right...
		if abs(velocity.x)>10:
			#... then we need to decelerate them by applying acceleration in the opposite direction
			if(velocity.x>0):
				acceleration.x = -WALK_DECELERATION
			else:
				acceleration.x = WALK_DECELERATION
		#If the player's left or right velocity is low, then set it to zero to prevent rapid switching
		else:
			velocity.x = 0
	
	#Apply acceleration vector to velocity
	velocity += acceleration * delta
	velocity.x = clamp(velocity.x,-MAX_WALK_SPEED,MAX_WALK_SPEED)
	
	
	velocity = move_and_slide(velocity, Vector2(0, 1))
	print("Acceleration: ", acceleration)
	print("Velocity: ", velocity)
#	if Input.is_action_just_pressed("ui_up"):
#		if is_on_ground():
#			velocity.y = 0
#			acceleration.y -= JUMP_ACCELERATION
#		elif on_left_wall.is_colliding():
#			velocity.y = 0
#			acceleration.y -= WALL_JUMP_ACCELERATION
#			velocity.x = MAX_SPEED
#		elif on_right_wall.is_colliding():
#			velocity.y = 0
#			acceleration.y -= WALL_JUMP_ACCELERATION
#			velocity.x = -MAX_SPEED

#	#See if the character needs to drag to a halt
#	if acceleration.x == 0:
#		#$CharAnims.play("idle")
#		if(abs(velocity.x) > VELOCITY_TO_STOP_DRAGGING) :
##			if is_on_ground():
#				acceleration.x = DRAG_COEF * clamp(velocity.x, -1, 1)
##			else:
##				acceleration.x = AIR_DRAG * clamp(velocity.x, -1, 1)
#		else:
#			velocity.x = 0

#	else:
#		if(acceleration.x >0):
#			$Sprite.flip_h=true
#		elif(acceleration.x <0):
#			$Sprite.flip_h=false
#		$CharAnims.play("walk")


	

