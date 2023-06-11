extends Sprite2D
@onready  var incar=$incar
var po = 0
var flag = 0
var t = 1
var i = 1
signal  feedback4
func _process(delta):#控制列车的移动，在列车移动到对应位置时播放动画
	if flag:
		$"../AudioStreamPlayer2D2".play()
		if i:
			emit_signal("feedback4",1,0,0)
			incar.play()
			i = 0
		if po < 1500  :
			self.position.x-= 4
			po += 4
		elif po>=1500 and po<2000 :
			self.position.x-= 2
			po += 2
		
		elif t:
			t=0
			$"../Test".f9_()
			$"../Test/dia2/AnimationPlayer".play("转场0.5")
			await $"../Test/dia2/AnimationPlayer".animation_finished
			get_tree().change_scene_to_file("res://全部游戏/转场2.tscn")
		
	

