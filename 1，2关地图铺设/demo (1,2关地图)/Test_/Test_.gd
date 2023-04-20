extends Node2D

# Called when the node enters the scene tree for the first time.

@onready var player = get_node('../player')
@onready var Dialogbox = get_node('../Dialogbox')
@onready var action = get_node('../player/player_/action')
@onready var Camera = get_node('../Camera')
@onready var player_ =  get_node('../player/player_')

func _ready():
	Camera.connect('lens_to_dialog',Callable(self,'f1_'))

func test_enter(x,y,action_,fun):
	if x==player:
		print('test enter')
		player.velocity.x = 0### 暂时这样弄
		self.player_action_change(action_)
		call(fun)
		print(y,1)
		
func test_exit(x,y):
	if x==player:
		print('test exit')
		print(get_node(y))
		get_node(y).queue_free()
		print(x)


func films_enter(x,y,num,action_,fun):
	if x==player:
		print('films enter')
		self.player_action_change(action_)
		call(fun,num)
		print(y,2)

func films_exit(x,y):
	if x==player:
		print('films exit')
		get_node(y).queue_free()
		print(x)





func player_action_change(t):
	action.play(t)

func f1():
	Camera.dialoglens()
func f1_():
	Dialogbox.show_dialogbox([{name='AAAAA',text='ssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssss'},{name='BBBBBB',text='(&*ghjgki&^*%)'},{name='AAAAA',text='&**%&%^*(*^*&%)'}])

func f2(num):
	if player.Number_of_films+num > player.MAX:
		var text_tips = '你获得了%d个胶片'%(player.MAX-player.Number_of_films)
		player.Number_of_films = 5
		print(text_tips,player.Number_of_films)
	else:
		var text_tips = '你获得了%d个胶片'%(num)
		player.Number_of_films+= num
		print(text_tips,player.Number_of_films)
	
	


