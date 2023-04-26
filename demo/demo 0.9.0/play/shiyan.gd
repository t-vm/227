extends Area2D

var flag = 1
var symbol = {'type':'body','colli_type':'circle','size':1,'tx':'' }
var angal = 0.01

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if flag:
		self.rotate(angal)
