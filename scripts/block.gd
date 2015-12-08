extends KinematicBody2D

var speed = 10
var movement = true
var last_one = false

func _ready():
	set_process(true)
	#print("BLOCK CREATED " + self.get_name())
	
	#set_z(-1)

func _process(delta):
	if movement:
		move(Vector2(-speed,0)*60*delta)
	if get_pos().x < -250:
		queue_free()
		
