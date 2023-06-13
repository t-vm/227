extends Node2D
var w = 0.01
var sita = 0.89
var dir = 1
var flag = 0

func f(): # 实现吊灯的旋转
	if flag:
		if sita<=0.9 and sita>=0:
			w = sqrt(2.5*(cos(sita)-cos(0.9)))/100*dir
			self.rotate(w)
			sita-=w
		if sita>0.9 or sita<0:
			dir *= -1 
			self.rotate(-w)
			sita+=w
