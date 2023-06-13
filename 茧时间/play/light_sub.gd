extends Area2D


var  tx = 'res://photo/Photo_layer 1/拖影素材.png'
var symbol = {'type':'light_move','colli_type':'circle','size':1,'tx':tx }

const SPEED = 3
var flag = 1
var velocity = Vector2(0,2)
func _physics_process(delta):

#	var direction_ = Input.get_axis("ui_up", "ui_down")
#	if direction_:
#		velocity.y = direction_ * SPEED
#	else:
#		velocity.y = move_toward(velocity.x, 0, SPEED)
#
#	var direction = Input.get_axis("ui_left", "ui_right")
#	if direction:
#		velocity.x = direction * SPEED
#	else:
#		velocity.x = move_toward(velocity.x, 0, SPEED)
	if flag:
		move_and_slide()


func move_and_slide():
	self.position+=velocity
