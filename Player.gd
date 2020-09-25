extends KinematicBody


var speed = 200
var direction = Vector3()
var gravity = -9.8
var velocity = Vector3()


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	# Animation processing!
	
	var mario_direction # Possible values: N, S, E, W, NW, SW, NE, SE and Idle

	if direction.z==0 and direction.x==0:
		mario_direction="Idle"
	if direction.z<0 and direction.x<0:
		mario_direction="NW"
	if direction.z>0 and direction.x<0:
		mario_direction="SW"
	if direction.z>0 and direction.x>0:
		mario_direction="SE"
	if direction.z<0 and direction.x>0:
		mario_direction="NE"
		
	if direction.z<0 and direction.x==0:
		mario_direction="N"
	if direction.z>0 and direction.x==0:
		mario_direction="S"
	if direction.z==0 and direction.x>0:
		mario_direction="E"
	if direction.z==0 and direction.x<0:
		mario_direction="W"
		
	#$AnimatedSprite3D.flip_h=false
	match mario_direction:
		"Idle":
			$AnimatedSprite3D.play("idleDown")
		"NW":
			$AnimatedSprite3D.play("walkUp")
			$AnimatedSprite3D.flip_h=false
		"NE":
			$AnimatedSprite3D.play("walkUp")
			$AnimatedSprite3D.flip_h=true
		"SW":
			$AnimatedSprite3D.play("walkDown")
			$AnimatedSprite3D.flip_h=false
		"SE":
			$AnimatedSprite3D.play("walkDown")
			$AnimatedSprite3D.flip_h=true
		"N":
			$AnimatedSprite3D.play("walkUp")
			#$AnimatedSprite3D.flip_h=false
		"S":
			$AnimatedSprite3D.play("walkDown")
			#$AnimatedSprite3D.flip_h=false
		"W":
			$AnimatedSprite3D.play("walkDown")
			$AnimatedSprite3D.flip_h=false
		"E":
			$AnimatedSprite3D.play("walkDown")
			$AnimatedSprite3D.flip_h=true
			
	if !is_on_floor(): # If mario is in the air, jump
		$AnimatedSprite3D.play("jump")
		if direction.x>0: # flip if we are heading right
			$AnimatedSprite3D.flip_h=true
		else:
			if is_on_floor() or direction.x<0: #head left only if user specifies, or we complete jump
				$AnimatedSprite3D.flip_h=false
	
	
	
	

	#if Input.is_action_just_released("ui_up"):
		#$AnimatedSprite3D.play("idleUp")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	direction=Vector3(0,0,0)
	if Input.is_action_pressed("ui_left"):
		direction.x -= 1 # subtract 1 from direction.x
	if Input.is_action_pressed("ui_right"):
		direction.x += 1 # add 1 from direction.x
		#$AnimationPlayer.play("Walk Down")
	if Input.is_action_pressed("ui_down"):
		direction.z += 1 # add 1 from direction.z
	if Input.is_action_pressed("ui_up"):
		direction.z -= 1 # subtract 1 from direction.z
	direction=direction.normalized()
	direction=direction*speed*delta
	
	velocity.y += gravity*delta
	velocity.x=direction.x
	velocity.z=direction.z
	
	velocity = move_and_slide(velocity,Vector3(0,1,0))
	
	if Input.is_action_pressed("ui_accept"): # TODO: find a better action for jumping
		#velocity.y=10
		if is_on_floor():
			velocity.y=10

	#velocity = move_and_slide(direction,Vector3(0,1,0))

#	pass
