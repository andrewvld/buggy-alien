extends Node2D


var adManager = null
var sceneManager = null
var level1Path = "res://level.scn"
var admob = null
var isTop = false
var ad_id = "ca-app-pub-"


var new_block
var new_gold
var new_block_sprite
var side = 1
var speed = 16
var amount = 0
var last_i = 0
var last_block
var last_gold
var block2 
var block3 = load("res://scenes/block3.scn")
var block4 = load("res://scenes/block4.scn")
var block5 = load("res://scenes/block5.scn")
var block6 = load("res://scenes/block6.scn")

var gold 
var block_sprite = load("res://scenes/block_sprite.scn")
func _ready():
	randomize()
	block2  = preload("res://scenes/block2.scn")
	#gold =  preload("res://scenes/gold.scn")
	initial_blocks()
	get_node("gui/replay").hide()
	get_node("StreamPlayer").play()
	# Initialization here
	adManager = get_tree().get_root().get_node("adManager")
	get_tree().connect("screen_resized",self,"update_size")
	if(Globals.has_singleton("AdMob")):
		admob = Globals.get_singleton("AdMob")
		admob.init(false, isTop, ad_id)
		admob.showBanner(true)
func update_size():
	if(admob != null):
		print(admob.getAdWidth(), ", ", admob.getAdHeight())
		admob.resize(isTop)	

	
var block 

func _on_Timer_timeout():
	amount = (randi() % 5)+2
	
	if(amount ==2):
		new_block = block2.instance()
	if(amount ==3):
		new_block = block3.instance()
	if(amount ==2):
		new_block = block2.instance()
	if(amount ==4):
		new_block = block4.instance()
	if(amount ==5):
		new_block = block5.instance()
	if(amount ==6):
		new_block = block6.instance()
	
	if side == 0:
		new_block.set_pos(Vector2(1344+64*(amount-1) ,704))
		new_block.speed = speed
		add_child(new_block)
	
		for i in range(amount):
			new_block_sprite = block_sprite.instance()
			new_block_sprite.set_pos(Vector2(1344+(i*128),704))
			new_block_sprite.set_flip_v(false)
			new_block_sprite.speed = speed
			add_child(new_block_sprite)
			

			last_i = i
			var chance = (randi() % 100) + 1 
			#if chance >80:
			#	new_gold = gold.instance()
			#	new_gold.set_pos(Vector2(1344+(i*128),580))
			#	new_gold.speed = speed
			#	add_child(new_gold)
			#	last_gold = new_gold
		side = 1
	else:
		new_block.set_pos(Vector2(1344+(64*(amount-1)),16))
		new_block.speed = speed
		add_child(new_block)
		for i in range(amount):
			new_block_sprite = block_sprite.instance()
			new_block_sprite.set_pos(Vector2(1344+(i*128),16))
			new_block_sprite.set_flip_v(true)
			new_block_sprite.speed = speed
			add_child(new_block_sprite)
			last_i = i
			var chance = (randi() % 100) + 1 
			#if chance >80:
			#	new_gold = gold.instance()
			#	new_gold.set_pos(Vector2(1344+(i*128),144))
			#	new_gold.speed = speed
			#	new_gold.add_collision_exception_with(new_gold)
			#	add_child(new_gold)
			#	last_gold = new_gold
		side = 0
		
		#print(get_child_count())	


func _on_replay_pressed():
	get_tree().reload_current_scene()

func _on_Timer_block_timeout():
	speed += 2
	
func initial_blocks():
	block = load("res://scenes/block.scn")
	for i in range(15):
		
		new_block = block.instance()
		new_block.set_pos(Vector2(i*128+1,705))
		if last_block != null:
			new_block.add_collision_exception_with(last_block)
		last_block = new_block
		new_block.movement = false
		new_block.add_to_group("init_blocks")
		add_child(new_block)
		
		new_block_sprite = block_sprite.instance()
		new_block_sprite.set_pos(Vector2(i*128+1,705))
		new_block_sprite.movement = false
		new_block_sprite.add_to_group("init_blocks_sprites")
		add_child(new_block_sprite)

func _on_Button_pressed():
	get_node("/root/global").goto_scene("res://scenes/shop.scn")
