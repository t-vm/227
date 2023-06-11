extends Area2D


var  tx = "res://外源/photo（第二关）/led光.png"
var symbol = {'type':'light_move','colli_type':'circle','size':1,'tx':tx }

var flag = 1
var initpo
var po = 0

func _ready():
	initpo = self.position

func _process(delta):
	if flag:
		$"../Sprite2D".f()
		if po<260:
			self.position.x+= 0.425
			po+=0.425
		else:
			self.position = initpo
			po=0
