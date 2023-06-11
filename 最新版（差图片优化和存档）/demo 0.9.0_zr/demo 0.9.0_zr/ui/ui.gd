extends Control
# lay enter_only1/2  model
@onready var Camera = $'../Camera'
@onready var high_layer = $'../bg2' #非必须
@onready var bg_black_action = $'../lj1/l1'
@onready var player = $'../player'
@onready var play = $'../Camera/play'

@onready var back_move = $layer0/back/back_move
@onready var BJ = $"layer0/back/1"
@onready var BJ_Action = $"layer0/back/1/a1"
@onready var ST = $"layer0/back/2"
@onready var ST_Action = $"layer0/back/2/a2"


@onready var BJ_NEXT = $layer1/back_bj
@onready var BJ_NEXT_Action = $layer1/back_bj/b1


@onready var ST_NEXT =$layer2/back_bj
@onready var ST_NEXT_Action = $layer2/back_bj/b1

var change = []
var model = [0,0]
var lay = 0
var flags = [1,0,0]
signal ui_update_signal
signal feedback2
signal memo_signal
signal k_yorn

var flag = 0
var po = 1
var count = 0
var layer_0_index_choice = 0
var layer_0_choice_fun_set = [1,0,2,0,3,0]
var choice = 0

var enter_only1 = 1
var choice1 = 0
var layer_1_index_choice = 0
var layer_1_choice_data = [500,0,400,0,300,0,200,0]                          #[200,0,300,0,400,0,500,0]

var enter_only2 = 1
var choice2 = 0
var layer_2_index_choice = 0
var layer_2_choice_data = [6,0,5,0,4,0,3,0]                             #[3,0,4,0,5,0,6,0]

func _ready():
	self.connect('ui_update_signal',Callable(self,'ui_update'))
	self.connect('memo_signal',Callable(Camera,'右上角ui_模式'))
	self.connect('memo_signal',Callable(play,'模式分析'))
	self.connect('k_yorn',Callable(play,'UPDATE'))
func ui_update(layer_index):
	for i in range(flags.size()):
		flags[i] = 1 if i in layer_index else 0


func _physics_process(delta):
	self.position = Camera.position
	for i in range(flags.size()):
		if flags[i]:
			call('layer_'+str(i))
	if lay>0 or po>0 and count and not back_move.is_playing():
		emit_signal('k_yorn',[])
		

func layer_ready():
	model = [0,0]
	change = []
	lay = 0
	flag = 0
	po = 1
	count = 0
	layer_0_index_choice = 0
	choice = 0

	enter_only1 = 1
	choice1 = 0
	layer_1_index_choice = 0

	enter_only2 = 1
	choice2 = 0
	layer_2_index_choice = 0
	emit_signal('k_yorn',[0])
	BJ.hide()
	ST.hide()
	$"layer0/back/3".hide()
	for i in layer_1_choice_data:
		if i:
			var obj = get_node('layer1/back_bj/'+str(i))
			obj.hide()
	for i in layer_2_choice_data:
		if i:
			var obj = get_node('layer2/back_bj/'+str(i))
			obj.hide()
	

func layer_0_back_enter():
	if flag and po>0:
		high_layer.layer = -1
		back_move.play('back_move_enter')
		bg_black_action.play('l1_enter')
		count+=1
func layer_0_back_exit():
	if not flag and po<0:
		back_move.play('back_move_exit')
		bg_black_action.play('l1_exit')
		choice = 0
		lay = 0
		if BJ.modulate[3]:
			BJ_Action.play("choice_in_0")
		if ST.modulate[3] :
			ST_Action.play("choice_in_0")
		if $"layer0/back/3".modulate[3]:
			$"layer0/back/3/a3".play("choice_in_0")
		count+=1

func _unhandled_input(event):
	if  choice and  event is InputEventMouseButton:
		var d = 0
		if event.button_index == 4:
			layer_0_index_choice+=1
			layer_0_index_choice %= layer_0_choice_fun_set.size()
			d=1
		if event.button_index == 5:
			layer_0_index_choice-=1
			layer_0_index_choice %= layer_0_choice_fun_set.size()
			d=-1
		if layer_0_choice_fun_set[layer_0_index_choice] :
			var front = get_node('layer0/back/'+str(layer_0_choice_fun_set[(layer_0_index_choice-2*d)%layer_0_choice_fun_set.size()]))
			var now = get_node("layer0/back/"+str(layer_0_choice_fun_set[layer_0_index_choice]))
			if not now.visible:
				now.show()
				now.get_child(0).play('choice_out_0')
				front.get_child(0).play("choice_in_0")
				front.hide()
				lay =1
	
	
	if  choice1 and  event is InputEventMouseButton:
		var d = 0
		if event.button_index == 4:
			layer_1_index_choice+=1
			layer_1_index_choice %= layer_1_choice_data.size()
			d=1
		if event.button_index == 5:
			layer_1_index_choice-=1
			layer_1_index_choice %= layer_1_choice_data.size()
			d=-1
		if layer_1_choice_data[layer_1_index_choice]:
			var front = get_node('layer1/back_bj/'+str(layer_1_choice_data[(layer_1_index_choice-2*d)% layer_1_choice_data.size()]))
			var now = get_node("layer1/back_bj/"+str(layer_1_choice_data[layer_1_index_choice]))
			if not now.visible:
				now.show()
				now.get_child(0).play('choice_out_1')
				front.get_child(0).play("choice_in_1")
				front.hide()
				lay =2
	if  choice2 and  event is InputEventMouseButton:
		var d = 0
		if event.button_index == 4:
			layer_2_index_choice+=1
			layer_2_index_choice %= layer_2_choice_data.size()
			d=1
		if event.button_index == 5:
			layer_2_index_choice-=1
			layer_2_index_choice %= layer_2_choice_data.size()
			d=-1
		if layer_2_choice_data[layer_2_index_choice]:
			var front = get_node('layer2/back_bj/'+str(layer_2_choice_data[(layer_2_index_choice-2*d)% layer_2_choice_data.size()]))
			var now = get_node("layer2/back_bj/"+str(layer_2_choice_data[layer_2_index_choice]))
			if not now.visible:
				now.show()
				now.get_child(0).play('choice_out_1')
				front.get_child(0).play("choice_in_1")
				front.hide()
				lay = 3
		
		
func layer_0():
	if flags[0]:
		var EVENT1 = Input.is_action_just_pressed('E')
		if EVENT1 and player.velocity == Vector2(0,0) :
			flag^=1
			if not back_move.is_playing():
				if count:
					po *= (-1)**count
					count = 0
					back_move.speed_scale = 1
					bg_black_action.speed_scale = 1
				self.layer_0_back_enter()
				self.layer_0_back_exit()
			else:
				bg_black_action.speed_scale *= -1
				back_move.speed_scale*=-1
				count+=1
		if po>0 and count and not back_move.is_playing():
			choice = 1
			emit_signal('feedback2',0,0,0)
			var EVENT2 = Input.is_action_just_pressed("enter")
			if EVENT2 and lay==1:
				back_move.play('back_move_exit')
				ST.hide()
				BJ.hide()
				if layer_0_choice_fun_set[layer_0_index_choice] == 1:
					emit_signal('ui_update_signal',[1])
					choice = 0
					self.layer_1()
				if layer_0_choice_fun_set[layer_0_index_choice] == 2:
					emit_signal('ui_update_signal',[2])
					choice = 0
					self.layer_2()		
				if layer_0_choice_fun_set[layer_0_index_choice] == 3:
					if Input.is_action_just_pressed("enter"):
						BJ_Action.play("choice_in_0")
						bg_black_action.play("l1_exit")
						emit_signal('feedback2',1,1,1)
						emit_signal('ui_update_signal',[0])
						model = [0,0]
						emit_signal('memo_signal',model)
						self.layer_ready()					
				
		if po<0 and count%2 and not back_move.is_playing():
			high_layer.layer = 0
			choice = 0
			self.layer_ready()
			emit_signal('k_yorn',[0])
			emit_signal('feedback2',1,1,1)
			
			
			
			
func layer_1():
	if flags[1]:
		model[0] = 1
		if enter_only1:
			if not BJ_NEXT.visible:
				BJ_NEXT.visible = true
			BJ_NEXT_Action.play("back_bj_enter")
			enter_only1 = 0
		else:
			var EVENT3 = Input.is_action_just_pressed("esc")
			if EVENT3:
				self.esc1()
			else:
				choice1 = 1
				if Input.is_action_just_pressed("enter") and lay==2:
					BJ_NEXT_Action.play("back_bj_exit")
					bg_black_action.play("l1_exit")
					emit_signal('feedback2',1,1,1)
					emit_signal('ui_update_signal',[0])
					model[1] = layer_1_choice_data[layer_1_index_choice]
					emit_signal('memo_signal',model)
					self.layer_ready()


func esc1():
	BJ_NEXT_Action.play("back_bj_exit")
	enter_only1 = 1
	choice1 = 0
	lay = 1
	back_move.play('back_move_enter')
	#BJ_NEXT.hide()
	emit_signal('ui_update_signal',[0])




		

func layer_2():
	if flags[2]:
		model[0] = 2
		if enter_only2:
			if not ST_NEXT.visible:
				ST_NEXT.visible = true
			ST_NEXT_Action.play("back_bj_enter")
			enter_only2 = 0
		else:
			var EVENT4 = Input.is_action_just_pressed("esc")
			if EVENT4:
				self.esc2()
			else:
				choice2 = 1
				if Input.is_action_just_pressed("enter") and lay==3:
					ST_NEXT_Action.play("back_bj_exit")
					bg_black_action.play("l1_exit")
					emit_signal('feedback2',1,1,1)
					emit_signal('ui_update_signal',[0])
					model[1] = layer_2_choice_data[layer_2_index_choice]
					emit_signal('memo_signal',model)
					self.layer_ready()


func esc2():
	model[0] = 0
	ST_NEXT_Action.play("back_bj_exit")
	enter_only2 = 1
	choice2 = 0
	lay = 1
	back_move.play('back_move_enter')
	emit_signal('ui_update_signal',[0])


func layer_3():
	if flags[3]:
		pass
