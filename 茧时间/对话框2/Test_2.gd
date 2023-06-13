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
		
func test_exit(x,y):#清空胶片
	if x==player:
		get_node(y).queue_free()


func films_enter(x,y,num,action_,fun):  #强制拾取胶片（物品）检查点
	if x==player:
		self.player_action_change(action_)
		call(fun,num)

func films_exit(x,y):#清空胶片
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
			
func interaction_test_exit(x,y):#对话完成后隐藏对话框
	if x==player:
		get_node(y).get_child(0).get_child(0).hide()
		self.init()
		if del_flag:
			get_node(y).queue_free()
			del_flag = 0

func _unhandled_input(event):#按f跳过对话
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
	
func f1_(): #对话函数1（开头cg）
	Dialogbox.show_dialogbox([{name='如果你可以听到--',text='打起精神，死亡不是一切的终点。'},{name='在梦中的世界沿着向前延伸的路走下去，崭新的世界在等待着你。',text=''},{name='幸福',text=''},{name='快乐',text=''},{name='共感',text=''},{name='认同',text=''},{name='',text='也许你可以拥有你想要的一切'}])




func f4(): #对话函数4（相机放大）
	Camera.dialoglens('f4_')
	
func f4_(): #对话函数4（第一关，第一个强制对话框）
	Dialogbox.show_dialogbox([{name='',text='黑色的云似高山遮盖住了天空，凌冽的风扫过空无一人的街道。生锈的电线杆在大风中吱呀作响，刺耳的声音让我从迷茫中回过神来。'},{name='',text='这是哪儿？'},{name='',text='刚才我的脑海中突然出现的那个女声，她的话语暧昧且温暖，还有些含混不清。这个声音似乎有着什么魔力，让我莫名的感觉到亲近。直到女声念完了最后一个字后的很长时间，我都还沉湎在刚刚的那个感觉之中。'},{name='',text='那时我同样不知身处何处，但与现在不同的是，我似乎被一种让人愿意亲近的感觉包围、缠绕，处于一种令人生疑却又不想离开的氛围中。'},{name='',text='那时她使用了如此温柔的嗓音，以至于“死亡”这般令人生畏的词语都融化在其中了。'},{name='',text='说不定如“她”所说，我真的死了，而这一切都是我死去的一瞬那盏巨大的走马灯。'},{name='我：',text=' 令人在意...'},{name='我：',text='姑且走下去看看吧。'}])




func f5(): #对话函数5（相机放大）
	Camera.dialoglens('f5_')
	
func f5_(): #对话函数5（第一关，第二个强制对话框）
	Dialogbox.show_dialogbox([{name='',text='突然来到了完全陌生的地方使我颇为无措。回望四周，除了一望无际的道路以外，能看见的就只有远处的一座房子。一阵恐惧在此刻适时的涌了上来，伴着好奇一起促使着我尽快离开当下驻足的这个地方。'},{name='',text='但就在我抬起脚时，胸口处突然传来了一阵凉意。'},{name='我：',text='嗯？'},{name='',text='我低头看去，不知何时，我的胸前多了一台悬挂在脖颈上的照相机。这机器并不属于我，我也从未见过它。但莫名的直觉告诉我，我应该把它留下来。'}])




func f6(): #对话函数6（相机放大）
	Camera.dialoglens('f6_')
	
func f6_(): #对话函数6（第一关，车站前，第三个强制对话框）
	Dialogbox.show_dialogbox([{name='',text='车站的牌子掉下来了一个。  '},{name='',text='这个车站大概已经废弃了。这样一个风景优美的湖滨小车站，在它还在运营的时候--如果真的有过，曾让多少画家为它作画，又让多少经过的旅客心头产生过作诗的想法？'},{name='',text='这让我突然想起那来历不明的照相机来。这般景象与好奇心让我不禁举起它把镜头对准那里，按下快门。'},{name='',text='没有反应--胶卷仓空着。'},{name='我：',text='…这样吗。'},{name='我：',text='干脆进去看看。'}])




func f7(): #对话函数7（相机放大）
	Camera.dialoglens('f7_')
	
func f7_(): #对话函数7（第一关，车站门口，第四个强制对话框）
	Dialogbox.show_dialogbox([{name='我：',text='怎么还亮着灯？'},{name='',text='空无一人的地方却维持着电力供应，这让我心生恐惧。不过也许我身处此地这件事本身就是一件令人恐惧的事情。'},])
	$"../车厢".flag = 1



func f8(): #对话函数8（相机放大）
	Camera.dialoglens('f8_')
	
func f8_(): #对话函数8（第一关，上车前对话，1，第五个强制对话框）
	Dialogbox.show_dialogbox([{name='我：',text='？！'},{name='我：',text='……'},{name='',text='打开的门似乎在暗示我：”进来吧！“'},{name='',text='几乎凝固的风景里驶来一辆列车，使我作出了上车的决定--看上去它几乎就是为了我而驶来的。'}])



func f9(): #对话函数9（相机放大）
	Camera.dialoglens('f9_')
	
func f9_(): #对话函数9 （第一关， 车开走后对话，2，第六个强制对话框）
	Dialogbox.show_dialogbox([{name='',text='此前的我还是一只漫无目的飞行的昆虫，这辆车便在当下提供了一个落脚点。'},{name='',text='不过就当前的处境来看，也许它会是一株猪笼草，神秘、甜美而危险。'}])



func f10(): #对话函数10（相机放大）
	Camera.dialoglens('f10_')
	
func f10_(): #对话函数10（第一关，车厢里，1，第七个强制对话框）
	Dialogbox.show_dialogbox([{name='',text='我在空旷的车厢里大声询问。'},{name='我：',text='是谁？'},{name='我：',text='有谁在那里吗？'},{name='',text='一切像是被安排好一样，只有回音从车厢的各处传回我的耳朵。'},{name='',text='问题的无解反而让我冷静下来。姑且在车上寻找线索吧。'}])


	
func f11(): #对话函数11（相机放大）
	Camera.dialoglens('f11_')
	
func f11_(num): #对话函数11（第一关， 车厢里，和途径站标识板互动，第1个可交互式对话框）
	del_flag = 1
	Dialogbox.show_dialogbox([{name='',text='途经的车站名被抹去了。'},{name='我：',text='那个令人在意的声音到底来自何方？'},{name='我：',text='这车上真是一个人也没有啊。甚至连通体漆黑的戴白色面具的人也没有。'},])



	
func f12(): #对话函数12（相机放大）
	Camera.dialoglens('f12_')
	
func f12_(num): #对话函数12（第一关，车厢里，与海报1互动，第2个可交互对话框）
	del_flag = 1
	Dialogbox.show_dialogbox([{name='',text='车里的海报充满着年代感。曾经这样的的广告海报遍布大街小巷，刺激着人们的购买欲，让空气中充斥着甜腻味儿。海报中“优质生活”的模样被渲染得闪闪发光，使人们被驱使着从自己本就不丰盈的荷包里掏出相当一部分，模仿着勾勒出一个轮廓来。'},{name='我：',text='海报里的这个人是谁呢？'},{name='我：',text='也许我的父母一辈人人都认识她吧。'},])



func f15(): #对话函数15（相机放大）
	Camera.dialoglens('f15_')
	
func f15_(num): #对话函数15（第一关，车厢里，与海报2互动，第3个可交互对话框）
	del_flag = 1
	Dialogbox.show_dialogbox([{name='',text='是电视机的广告。海报里电视机那被显像管撑起的硕大身躯放射出一条条橙黄色的线，给右下角被重重描边的打折数字提供了背景板。时至今日，液晶时代的人们中又有人开始追求crt了。'},])


	
func f13(): #对话函数13（相机放大）
	Camera.dialoglens('f13_')
	
func f13_(): #对话函数13（第一关，车厢内，第八个强制对话框）
	Dialogbox.show_dialogbox([{name='车厢的广播：',text='欢迎来到瑕疵相片的世界。错误的快门时间、错误的成像时机、模糊和拖影…您拍出过瑕疵相片吗？'},{name='我：',text=' 什么？'},{name='车厢的广播：',text='在另一侧的现实中死亡的人们，都会来到这里。表面上出现问题的相片，也许会成为改变一切的契机。'},{name='我：',text='……'},{name='车厢的广播：',text='您每次按下快门，那一刻印在菲林上的内容都将更新这个世界，铺下通向美丽的、崭新的世界之路的一块基石。'},{name='车厢的广播：',text=' 列车即将到站，请您务必通过改写这个世界的样貌，在光与影的帮助下到达彼岸。'},{name = '',text ='我站在原地，大脑飞速运转。'},{name = '我：',text ='简直像是童话故事里住在森林木屋中的老婆婆的发言。'}])
	

