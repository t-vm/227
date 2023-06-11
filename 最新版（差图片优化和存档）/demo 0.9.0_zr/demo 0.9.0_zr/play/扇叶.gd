extends Area2D


var  tx = 'res://photo/Photo_layer 1/拖影素材.png'
var symbol = {'type':'body','colli_type':'circle','size':1,'tx':tx }

var flag = 1
func _process(delta):
	if flag:
		rotate(0.09)
