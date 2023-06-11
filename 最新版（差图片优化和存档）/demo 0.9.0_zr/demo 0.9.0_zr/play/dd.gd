extends Area2D


var  tx = "res://外源/photo（第二关）/吊灯光.png"
var symbol = {'type':'light_move_hold','colli_type':'circle','size':0.01,'tx':tx }
var flag = 1




# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if flag:
		$'../'.f()
	pass
