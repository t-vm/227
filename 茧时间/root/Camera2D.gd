
extends Camera2D
@onready var player = get_node('../player')
@onready var player_=get_node('../player/player_')
@onready var Dialogbox = get_node('../Dialogbox')
var init_positionx = self.position.x   #初始化镜头位置
var init_positiony = self.position.y   
var scale_ = 1
var test_fun = ''
var model = [0,0]
signal feedback
signal lens_to_dialog
signal ui_yorn
signal k

func _ready():
	Dialogbox.connect('normal_lens',Callable(self,'dialoglens_re'))
	self.connect('k',Callable($play,'UPDATE'))
	self.zoom = Vector2(1,1)
	self.右上角ui_模式(model)
	self.右上角ui_胶片数量(player.Number_of_films)

func Lens_synchronization_(flag):
	if flag:                                             #镜头跟随，当Lens_synchronization信号发出时触发
		self.position.x = player.position.x  + init_positionx-player.init_pox #水平镜头实时跟随
		self.position.y = floor(player.position.y/972)*972+486              # 竖直方向块跟随




func dialoglens(str_):
	self.test_fun = str_
	emit_signal('feedback',0,0,0)
	emit_signal('ui_yorn',[])
	emit_signal('k',[])
	$Timer.set_paused(false)
	$Timer.start()
	
func action_camera():
	if scale_<2:
		self.position += Vector2(-100,200)*0.02
		scale_+=0.02
		self.zoom = Vector2(scale_,scale_) 
	else:
		$Timer.stop()
		emit_signal('lens_to_dialog',self.test_fun)
func dialoglens_re():
	scale_ = 1
	self.zoom = Vector2(1,1)
	self.Lens_synchronization_(1)
	emit_signal('feedback',1,1,1)
	emit_signal('ui_yorn',[0])
	emit_signal('k',[0])
	
func 右上角ui_模式(model):
	self.model = model
	var models = ['自动','变焦','快门时间']
	var s1 = models[self.model[0]]
	var s2 = ': '+str(self.model[1]) if self.model[1] else ''
	var text = s1+s2
	$model.text  = text
	
func 右上角ui_胶片数量(num):
	var num_ = str(num) if num else '  '
	$films_num.text = num_+'|'+str(player.MAX)
	
	
