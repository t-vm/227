extends Sprite2D

var initpo 
var po = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	initpo = self.position.x


func f():
	if po<12000:
		self.position.x+=8
		po+=8
	else:
		self.position.x = initpo
		po = 0
