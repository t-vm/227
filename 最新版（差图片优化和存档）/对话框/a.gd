extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.


func _physics_process(delta):
	# Add the gravity.

	# Handle Jump.
	var direction_ = Input.get_axis("ui_up", "ui_down")
	if direction_:
		velocity.y = direction_ * SPEED
	else:
		velocity.y = move_toward(velocity.x, 0, SPEED)

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
