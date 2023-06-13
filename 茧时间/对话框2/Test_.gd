extends Node2D

# Called when the node enters the scene tree for the first time.

@onready var player = get_node('../player')
@onready var Dialogbox = get_node('../Dialogbox')
@onready var action = get_node('../player/player_/action')
@onready var Camera = get_node('../Camera')
@onready var player_ =  get_node('../player/player_')
signal ui_yorn
signal change_films_num
var flag = 0
var i = 1
var x = null
var y = null
var action_ = ''
var num = 0
var fun = ''
var del_flag = 0
var f3_flag = 0
func init():
	flag = 0
	i = 1
	x = null
	y = null
	action_ = ''
	num = 0
	fun = ''
func _ready():
	Camera.connect('lens_to_dialog',Callable(self,'call_test_fun'))
	self.connect("change_films_num",Callable(Camera,'右上角ui_胶片数量'))
func test_enter(x,y,action_,fun):  #强制进行检查点
	if x==player:
		self.player_action_change(action_)
		call(fun)
		player.velocity.x = 0
		
func test_exit(x,y):
	if x==player:
		get_node(y).queue_free()


func films_enter(x,y,num,action_,fun):  #强制拾取胶片（物品）检查点
	if x==player:
		self.player_action_change(action_)
		call(fun,num)

func films_exit(x,y):
	if x==player:
		get_node(y).queue_free()
		
func interaction_test_enter(x,y,num,action_,fun):
	if x==player:
		flag = 1
		self.x = x
		self.y = y
		self.num = num
		self.action_ = action_
		self.fun = fun
		var sp = get_node(y).get_child(0).get_child(0)
		if sp.visible == false :
			sp.show()
			
func interaction_test_exit(x,y):
	if x==player:
		get_node(y).get_child(0).get_child(0).hide()
		self.init()
		if del_flag:
			get_node(y).queue_free()
			del_flag = 0

func _unhandled_input(event):
	if flag:
		if event.is_action_pressed('f') and i:
			self.player_action_change(action_)
			call(fun,num)
			

func player_action_change(t):
	action.play(t)

func call_test_fun(str_):
	call(str_)

func f1(): #对话函数1（相机放大）
	Camera.dialoglens('f1_')
	
func f1_(): #对话函数1
	Dialogbox.show_dialogbox([{name='真不戳',text='住在山里真不戳'},{name='BBBBBB',text='(&*ghjgki&^*%)'},{name='AAAAA',text='&**%&%^*(*^*&%)'}])

func f2(num): #胶片捡起函数
	var text_tips
	if player.Number_of_films+num > player.MAX:
		text_tips = '你获得了%d个胶片'%(player.MAX-player.Number_of_films)
		player.Number_of_films = 5
	else:
		text_tips = '你获得了%d个胶片'%(num)
		player.Number_of_films+= num
	$"../other/Node2D10/箱子打开".show()
	self.f16()
	emit_signal("change_films_num",player.Number_of_films)
	
func f2_1(num): #胶片捡起函数
	var text_tips
	if player.Number_of_films+num > player.MAX:
		text_tips = '你获得了%d个胶片'%(player.MAX-player.Number_of_films)
		player.Number_of_films = 5
	else:
		text_tips = '你获得了%d个胶片'%(num)
		player.Number_of_films+= num
	$"../other/Node2D11/箱子打开".show()
	emit_signal("change_films_num",player.Number_of_films)
	print(player.Number_of_films)
	
func f2_2(num): #胶片捡起函数
	var text_tips
	if player.Number_of_films+num > player.MAX:
		text_tips = '你获得了%d个胶片'%(player.MAX-player.Number_of_films)
		player.Number_of_films = 5
	else:
		text_tips = '你获得了%d个胶片'%(num)
		player.Number_of_films+= num
	$"../other/Node2D12/箱子打开".show()
	emit_signal("change_films_num",player.Number_of_films)
	
func f3(num):
	f3_flag^=1
	if f3_flag:
		$"../light_and_body/dd/Area2D".symbol['type'] = 'light_move'
		$"../light_and_body/dd/Area2D/CollisionPolygon2D/吊灯光".show()
		$"../other/Node2D3/AnimatedSprite2D".play("on")
	else:
		$"../light_and_body/dd/Area2D".symbol['type'] = 'light_move_hold'
		$"../light_and_body/dd/Area2D/CollisionPolygon2D/吊灯光".hide()
		$"../other/Node2D3/AnimatedSprite2D".play("off")

func f4(num):
	del_flag = 1
	get_node(y).get_child(0).get_child(0).hide()
	$"../light_and_body/dd".flag = 1
	$"../other/Node2D2/AnimatedSprite2D".play("on")
	$"../other/Node2D2/AnimatedSprite2D/Timer".start()

var t = 0
func f4_timeout(): # 毁坏后使电灯常亮。
	$"../other/Node2D2/AnimatedSprite2D".play("broken")
	if t:
		$"../other/Node2D2/AnimatedSprite2D".play("off")
		$"../other/Node2D2/AnimatedSprite2D/Timer".stop()
	t+=1

func f14(): #对话函数14（相机放大）
	Camera.dialoglens('f14_')
	
func f14_(): #对话函数14（第二关，下车第一个强制对话框， ）
	Dialogbox.show_dialogbox([{name='',text='我下了车，再度想起最初的那个温柔的声音'},{name='',text='它令我沉浸其中，感到舒适，而我因寻找它的源头不得而感到烦闷，却又在事实上无时无刻不精准地执行它的命令--不断前进。而此刻的我也正遵循着它的嘱咐。'},{name='',text='我想，这也许就是我内心深处的某一部分。'},{name='',text='此刻的我，已经不再关心什么”死亡“ 、 ”梦境“， 也不愿再管什么无人的列车和湖了，反倒是对于这里的一切的好奇心正不停生长。'},{name='',text='来历不明的相机，又或是广播中令人在意的描述。'},{name='',text='或许这是某种提示，如果我能够获得一些胶卷，便可以验证一下用这台机器拍摄到底会发生什么了。'},])
func f16(): #对话函数16（相机放大）
	Camera.dialoglens('f16_')
	
func f16_(): #对话函数16（第二关，捡起第一个胶卷的强制对话。 ）
	Dialogbox.show_dialogbox([{name='',text='用户指南'},{name='',text='优秀的摄影作品引人驻足欣赏，伟大的摄影作品改变整个世界！'},{name='',text='感谢您选择x-0e型相机与配套胶卷。'},{name='',text='本产品致力于让每一位用户以最简单的学习成本发挥独一无二的创意，拍摄伟大的摄影作品。'},{name='',text='*按键说明*'},{name='',text='1，2键分别控制本相机的两种模式，1为自动拍照模式，2为延时摄影模式'},{name='',text='选择完模式后，使用Q键调出取景框'},{name='',text='在取景框界面，您可以用光标定位取景框位置。随后，点击左键确认并锁定后，按S拍照，查看预览效果。随后回车确认效果，或是点击右键取消本次拍照。'},{name='',text='当您确认拍摄完毕后，再次使用Q键退出取景框。'},{name='',text='令人愉悦的契合声让我明白相机大概已经被正确填入胶卷，可以使用了。'},{name='我：',text='果然可以找到。'},{name='我：',text='但这显然不是一个可以让我随意发挥的数量。'}])
	


func f18(): #对话函数18（相机放大）
	Camera.dialoglens('f18_')
	
func f18_(): #对话函数18（第二关，第一次遇到障碍，强制弹出对话框）
	Dialogbox.show_dialogbox([{name='',text='想要前进，得越过那辆堵路的叉车才行。但是很显然，我无法撼动它，更无法从叉车那稳定性之上的低矮底盘下方钻过去。'},{name='我：',text='根本不可能从梯子上跳过去……我以前该多练习一下自己的体术的。'},{name='我：',text='不， 就算是那样也不可能。'},{name='我：',text=' 如果那些话属实，那确实很难想象在死后的世界里摔伤会发生什么。我可不想尝试。'},{name='我：',text='瑕疵相片和“更新世界” 吗…也许我应该…'}])


func f50(): #对话函数18（相机放大）
	Camera.dialoglens('f18_')
	
func f50_(): #对话函数18（第二关，第一次遇到障碍，强制弹出对话框）
	pass
