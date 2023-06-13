extends Node2D

var flag = -1
@onready var player = get_node('../player')
@onready var v_box = $Control/VBoxContainer
@onready var color_rect = $Control/ColorRect
@onready var tu = $"Control/暂停界面"
@onready var camera = $"../Camera"
@onready var vhs = $Control/Vhs
@onready var animation_player = $AnimationPlayer

func _ready():
	pass # Replace with function body.

func _process(delta):
	self.position.x = camera.position.x+200
	self.position.y = camera.position.y-100

func _input(event):
	if Input.is_action_just_released("esc"):
		if v_box.visible == false:
			v_box.visible = -1*int(v_box.visible)+1
			vhs.visible = -1*int(vhs.visible)+1
			animation_player.play("暂停界面出现")
		elif v_box.visible == true:
			animation_player.play("暂停界面消失")
			v_box.visible = -1*int(v_box.visible)+1
			vhs.visible = -1*int(vhs.visible)+1
		get_tree().paused = not get_tree().paused
		


func _on_button_button_down():
	animation_player.play("暂停界面消失")
	v_box.visible = -1*int(v_box.visible)+1
	vhs.visible = -1*int(vhs.visible)+1
	get_tree().paused = not get_tree().paused



func _on_button_2_button_down():
	get_tree().change_scene_to_file("res://全部游戏/开始界面/开始界面.tscn")
	get_tree().paused = not get_tree().paused
