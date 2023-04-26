extends Sprite2D
var flag = 1
var symbol = {'type':'body','colli_type':'circle','size':1,'tx':'' }

func _process(delta):
	if flag:
		rotate(0.05)
