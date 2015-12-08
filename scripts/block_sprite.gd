extends Sprite

var speed = 10
var movement = true
var last_one = false

func _ready():
	set_process(true)
	
func _process(delta):
	if movement:
		translate(Vector2(-speed*delta*60,0))
	if get_pos().x < -128:
		speed = 0
		queue_free()