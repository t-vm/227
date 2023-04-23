extends CharacterBody2D

signal Lens_synchronization  #镜头同步信号

var MAX = 5 #最大胶卷数量
var in_air = 0 #落地判断变量
var h_yorn = int(true) #水平方向是否可操作
var v_yorn = int(true) #竖直方向是否可操作
var Number_of_films = 0 #人物胶片数量
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity") #重力
var init_pox = position.x	#初始化人物位置
var init_poy = position.y
var a_x =40		#人物行动加速度
var f_g = 24	#人物地面摩擦加速度
var f_a = 8		#人物空气阻力加速度
var SPEED = 3000 #人物水平最大速度
var H = a_x+f_g+f_a+1 #判定速度归零范围 H>=所有加速度大小之和+1
var flag =1
@onready var action = get_node('player_/action') #获取action（动画）节点
func _ready():
	var Camera = get_node('../Camera') #获取镜头（Camera）节点
	Camera.connect('feedback',Callable(self,'change_flag'))
	self.connect("Lens_synchronization",Callable(Camera,'Lens_synchronization_')) #将镜头同步信号连接到action节点中的镜头同步函数
	

func _physics_process(delta): #人物方法
	var la  = 3.5 #重力加速度调节比例
	var a_g = gravity * delta*la #重力加速度
	var k = 18	#比例值，k/30表示起跳到落地的时间
	var v_y = -a_g*k	#起跳时瞬时速度
	var direction = Input.get_axis("A", "D") * h_yorn #人物加速度方向
	var fastest = float(abs(velocity.x)<SPEED or direction*velocity.x<=0 ) #加速度是否存在：当人物加速度方向和运动方向相同，限制最大速度
	var fg_yorn = int(is_on_floor() and direction==0) #地面阻力的是否存在：仅当在地面且不按AD键时有地面阻力
	var f_d = -velocity.x/abs(velocity.x) if velocity.x else 0 #阻力方向
	emit_signal("Lens_synchronization",flag) #发射镜头同步信号
	# print(self.position.x) 
	velocity.x = velocity.x + fastest*(a_x*direction + f_d*(f_g*fg_yorn+f_a)) if not(velocity.x*direction<=0 and abs(velocity.x)<H and velocity.x !=0) else 0   #水平速度方程
	if Input.is_action_just_pressed("ui_accept") and v_yorn and is_on_floor(): #跳跃函数
		velocity.y = v_y 
		emit_signal("Lens_synchronization",flag)	
	else:
		velocity.y += a_g
#Move	
		
	if is_on_floor() :
		if in_air<=0:
			if abs(velocity.x) < 5 : #判定静止范围
				action.play('stop')
			else:
				action.play('move')
		else:
			action.play('down')
			in_air= in_air>>1
		action.speed_scale = abs(velocity.x/SPEED) if abs(velocity.x/SPEED)>0.5 else 0.5 #动画播放速度随速度大小变化
	else:
		in_air+=2**1
		action.play('jump')  ###判定可能要改
			
	
	if velocity.x>0:
		action.flip_h = true   #人物方向由速度决定
	if velocity.x<0:
		action.flip_h = false
	
#action
	
	move_and_slide() #按照速度运动

func add_films(n):
	Number_of_films+=n if Number_of_films+n<MAX else MAX-Number_of_films
func minu_films(n):
	Number_of_films -= n  if n<=Number_of_films else Number_of_films
	
func change_flag(x):
	flag = x
	h_yorn = x
	v_yorn = bool(x)

func Camera_interaction():
	pass
	

	

