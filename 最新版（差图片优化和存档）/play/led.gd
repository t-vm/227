extends Sprite2D
var initpo
var po = 0
func _ready():
	initpo = self.position
	
func f():
	if po<1850:
		self.position.x+= 1
		po+=3
	else:
		self.position = initpo
		po=0
