
extends Camera2D
@onready var player = get_node('../player')
@onready var player_=get_node('../player/player_')
@onready var Dialogbox = get_node('../Dialogbox')
var init_positionx = self.position.x   #初始化镜头位置
var init_positiony = self.position.y   
var scale_ = 1
signal feedback
signal lens_to_dialog

func _ready():
	Dialogbox.connect('normal_lens',Callable(self,'dialoglens_re'))
	self.zoom = Vector2(1,1)

func Lens_synchronization_(flag):
	if flag:                                             #镜头跟随，当Lens_synchronization信号发出时触发
		self.position.x = player.position.x  + init_positionx-player.init_pox #水平镜头实时跟随
		self.position.y = floor(player.position.y/972)*972+486              # 竖直方向块跟随

#func _input(event):
#	if Input.is_action_pressed("ui_right"):
#		emit_signal('feedback',0)
#		self.position = player_.position + Vector2(500,700)
#		self.zoom = Vector2(2,2) 
#	else:
#		emit_signal('feedback',1)
#		self.zoom = Vector2(1,1) 


func dialoglens():
	emit_signal('feedback',0)
#	self.position.x = player.position.x  + 0.5*(init_positionx-player.init_pox) +300  #player_.position + Vector2(500,700)
#	self.position.y = player.position.y  + 0.5*(init_positiony-player.init_poy)
	$Timer_camera.start()
	
func action_camera():
	if scale_<2:
		self.position += Vector2(-100,200)*0.005
		scale_+=0.005
		self.zoom = Vector2(scale_,scale_) 
	else:
		$Timer_camera.queue_free()
		emit_signal('lens_to_dialog')
func dialoglens_re():
	self.zoom = Vector2(1,1)
	self.Lens_synchronization_(1)
	emit_signal('feedback',1)
