extends Node2D

@onready var photosound=$photosound
@onready var Camera = $'../'
@onready var lj = $'../../lj1/l1'
@onready var 框 = $"框"
@onready var high_layer = $'../../bg2'
@onready var player = $'../../player'
signal feedback3
signal ui_yorn_
signal change_films_num
signal memo_signal
var fun = '自动'
var model = [0,0]
var time=0.01
var flag = 0
var flags=[1]
var flag_ = 1
var in_body_move = []
var in_body_static=[]
var in_body_body = []
var in_body_all = []
var fl = 0
var i = 1
var j =1
var shot_time_flag = 1
var shot_flag = 1
var 拍照时禁用收起相机 = 1
var 拍照时禁用框 = 1
var 预览确认 = 0
var 预览确认2 = 0
func _ready():
	self.connect('feedback3',Callable(player,'change_flag'))
	self.connect('change_films_num',Callable($'../','右上角ui_胶片数量'))
	self.connect('memo_signal',Callable(Camera,'右上角ui_模式'))
	model = [0,0]
	框.modulate[3] = 0

func _unhandled_input(event):
	if event.is_action_pressed('1'):
		self.model = [0,0]
		emit_signal("memo_signal",model)
		self.模式分析()
	if event.is_action_pressed('2'):
		self.model = [2,3]
		emit_signal("memo_signal",model)
		self.模式分析()
func k_ready():
	j = 1
	i = 1
	fl = 0
	flag_ = 1
	shot_time_flag = 1
	shot_flag = 1
	拍照时禁用收起相机 = 1
	拍照时禁用框 = 1
	预览确认 = 0
	预览确认2 = 0

func UPDATE(t):
	for i in range(flags.size()):
		flags[i] = 1 if i in t else 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if flags[0]:
		flag_ ^= int(Input.is_action_just_pressed("left_click"))
		if flag_ and 拍照时禁用框 :
			$"框".position = get_local_mouse_position()
		elif $"框".visible:
			fl ^= int(Input.is_action_just_pressed('S') and player.Number_of_films>0)  if not fl else 0
			if fl:
				拍照时禁用框 = 0
				if j and fun=='快门时间' :
					$Timer2.paused = false
					$Timer2.start(time)
					var body_ = Node2D.new()
					$'../../body'.add_child(body_)
					j=0
				拍照时禁用收起相机 = 0
				call(fun)
		if Input.is_action_just_pressed('Q') and not lj.is_playing() and player.velocity.x == 0 and 拍照时禁用收起相机 :
			flag^=1
			if flag:
				self.调用取景框()
			else :
				self.退出取景框()
		if 预览确认:
			if Input.is_action_just_pressed("enter"):
				var tt = 1
				for obj in in_body_all:
					if obj in in_body_body:
						obj.symbol['type'] = 'change'
					if obj.symbol['type'] == 'light_move' or obj.symbol['type'] == 'light_static':
						if tt:
							player.Number_of_films = player.Number_of_films-1
							tt = 0
						obj.queue_free()
				emit_signal('change_films_num',player.Number_of_films)
				拍照时禁用收起相机 = 1
				self.结算()
				self.k_ready()
				
			if Input.is_action_just_pressed("right_click"):
				$'../../body'.get_child(-1).queue_free()
				for obj in in_body_all:
					obj.flag = 1
				self.k_ready()
				flag_=0
		if 预览确认2 and 预览确认2^预览确认:
			if Input.is_action_just_pressed("enter"):
				var tt = 1
				for obj in in_body_body:
					obj.symbol['type'] = 'change'
					if tt:
						player.Number_of_films = player.Number_of_films-1
						tt = 0
				emit_signal('change_films_num',player.Number_of_films)
				拍照时禁用收起相机 = 1
				self.结算()
				self.k_ready()
			if Input.is_action_just_pressed("right_click"):
				for obj in in_body_body:
					obj.flag = 1
				self.k_ready()
				flag_=0
	
func 结算():
	in_body_all = []
	in_body_body = []
	in_body_move = []
	in_body_static = []

func 模式分析():
	if self.model[0] == 0:
		fun = '自动'
		time = 0.01
	if self.model[0] == 2:
		fun ='快门时间'
		time = self.model[1]
	
	
func 调用取景框():
	high_layer.layer = -1
	框.modulate[3] = 1
	lj.play("l1_enter")
	emit_signal('ui_yorn_',[])
	emit_signal('feedback3',1,0,0)
	flag_ = 1

	
func 退出取景框():
	$Timer.paused = false
	$Timer.start(0.4)
	lj.play("l1_exit")
	框.modulate[3] = 0
	emit_signal('ui_yorn_',[0])
	emit_signal('feedback3',1,1,1)
	self.k_ready()
func exit_sence_k():
	high_layer.layer = 0
	$Timer.stop()
	
func 快门时间():
	if shot_time_flag:
		for obj in in_body_move:
			self.生成(obj)
		if i:
			i=0
			for obj in in_body_static:
				self.生成(obj)
				
func 自动():
	if shot_flag: 
		for obj in in_body_body:
			obj.flag = 0
		预览确认2 = 1
		shot_flag = 0
		if in_body_move.size() or in_body_static.size():
			$Timer2.paused = false
			$Timer2.start(time)
			var body_ = Node2D.new()
			$'../../body'.add_child(body_)
			j=0
			self.快门时间()
		
		
		
		
func enter(body):
	if { "name": "symbol", "class_name": &"", "type": 0, "hint": 0, "hint_string": "", "usage": 4096 } in body.get_property_list():
		if body.symbol['type'] in ['light_move','body','light_static'] and not body in in_body_all:
			in_body_all.append(body)
		if body.symbol['type']  == 'light_move' and not body in in_body_move:
			in_body_move.append(body)
		if  body.symbol['type']  == 'light_static' and not body in in_body_static:
			in_body_static.append(body)
		if body.symbol['type'] == 'body' and not body in in_body_body:
			in_body_body.append(body)
func exit(body):
	if body in in_body_move:
		var ind = in_body_move.find(body)
		in_body_move.pop_at(ind)
	if body in in_body_static:
		var ind = in_body_move.find(body)
		in_body_static.pop_at(ind)
	if body in in_body_body:
		var ind = in_body_move.find(body)
		in_body_body.pop_at(ind)
	if body in in_body_all and flag_:
		var ind = in_body_all.find(body)
		in_body_all.pop_at(ind)
		
func stop():
	shot_time_flag = 0
	$Timer2.stop()
	预览确认 = 1
	for obj in in_body_all:
		obj.flag = 0

func 生成(obj):
	var colli_type_ =  obj.symbol['colli_type']
	var size_ = obj.symbol['size']
	var tx_ = obj.symbol['tx']
	var pos = obj.global_position
	var tx = load(tx_)
	var shape 
	var collision = CollisionShape2D.new()
#		var color = ColorRect.new()
	var static_create = StaticBody2D.new()
	var parent = $'../../body'.get_child(-1)
	var sprite = Sprite2D.new()
	if colli_type_ == 'circle':
		shape = CircleShape2D.new()
		shape.radius = size_
	sprite.scale = Vector2(size_,size_) if not obj == $"../../light_and_body/dd/Area2D" else Vector2(1,1)
	collision.shape = shape
#		color.set_color(Color(0, 0, 0, 0))
#		color.set_size(Vector2(16, 16))
	sprite.texture = tx
	sprite.position = pos
#		static_create.add_child(color)
	parent.add_child(sprite)
	static_create.add_child(collision)
	sprite.add_child(static_create)
	static_create.owner  #sprite2d<staticboddy2d<collisionShape2d  - shape -size
#												    <ColorRect
