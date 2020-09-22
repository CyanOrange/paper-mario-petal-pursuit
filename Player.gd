extends KinematicBody


var speed = 200
var direction = Vector3()
var gravity = -9.8
var velocity = Vector3()


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	if Input.is_action_pressed("ui_down"):
		$AnimationPlayer.play("Walk Down")
	if Input.is_action_just_released("ui_down"):
		$AnimationPlayer.play("Idle")
#	if Input.is_action_pressed("ui_up"):
#		$AnimationPlayer.play("Walk Up")
	if Input.is_action_just_released("ui_up"):
		$AnimationPlayer.play("Idle")

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
	
	if Input.is_action_pressed("ui_accept"):
		#velocity.y=10
		if is_on_floor():
			velocity.y=10

	#velocity = move_and_slide(direction,Vector3(0,1,0))

#	pass
