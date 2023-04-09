extends CharacterBody2D

const SPEED = 300.0
signal abc

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var init_pox = position.x
var init_poy = position.y
@onready var cr1 = get_node('CollisionPolygon2D/1')

func _ready():
	var Camera = get_node('../Camera')
	self.connect("abc",Callable(Camera,'a'))
	

func _physics_process(delta):
	# Add the gravity.
	emit_signal("abc")
	if not is_on_floor():
		velocity.y += gravity * delta*2

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = -gravity * delta*18*2
		emit_signal("abc")

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("A", "D")
	if direction:
		if direction>0:
			cr1.flip_h = true
		else:
			cr1.flip_h = false
		velocity.x = direction * SPEED
		emit_signal("abc")
	elif is_on_floor() :
		velocity.x = velocity.x + -16*velocity.x/abs(velocity.x) if (velocity.x>10 or velocity.x<-10) else 0
	else:
		velocity.x = velocity.x + -8*velocity.x/abs(velocity.x) if (velocity.x>10 or velocity.x<-10) else 0
			
	

	move_and_slide()
