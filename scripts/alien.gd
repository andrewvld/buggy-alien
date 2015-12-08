extends Sprite

var conf = "user://config.cfg" 
var side = 0
var jump = false
var score = 0
var sound = 0
var start = false
var dead = false
var hit = false
var gold_total = 0


var adManager = null
var sceneManager = null
var level1Path = "res://level.scn"
var admob = null
var isTop = false
var ad_id = "ca-app-pub-"


func _ready():
	set_process_input(true)
	set_fixed_process(true)
	get_parent().get_node("gui/scores").set_text("HIGHSCORE: "+str(get_previous_score()))
	gold_total = get_previous_gold()
	#Globals.set("gold",int(gold_total))
	#if gold_total == null:
	#	gold_total = 0
	
	get_parent().get_node("gui/gold").set_text(""+str(gold_total))
	get_node("AnimatedSprite/AnimationPlayer").stop()
	#var f = ConfigFile.new()
	#f.load(conf)
	#var bg = 1
	#if f.has_section("game_bg"):
	#	bg = int(f.get_value("game_bg","bg"))
	#	
	#	if bg == 2:
	#		var res = load("res://gfx/backgrounds/bg_dark.tex")
	#		get_parent().get_node("background/Sprite").set_texture(res)
	#	if bg == 1:
	#		var res = load("res://gfx/backgrounds/bg_city.tex")
	#		get_parent().get_node("background/Sprite").set_texture(res)
	
func _fixed_process(delta):
	if !dead:
		if !get_node("ray_bottom").is_colliding() && !get_node("ray_up").is_colliding():
			jump = false
			if side == 0:
				translate(Vector2(0,10))
			else:
				translate(Vector2(0,-10))
		else:
			jump = true

	else:
		if side == 0:
			translate(Vector2(0,10))
		else:
			translate(Vector2(0,-10))
	
	if get_node("RayCast2D").is_colliding():
		hit = true
		
	#if get_node("RayCastGold").is_colliding() and  get_node("RayCastGold").get_collider()!=null:
	#	
	#	get_node("RayCastGold").get_collider().queue_free()
	#
	#	gold_total = gold_total + 1
	#	get_parent().get_node("gui/gold").set_text(""+str(gold_total))
		
	if hit:
		if side == 0:
			translate(Vector2(-int(get_node("RayCast2D").get_collider().speed),10))
		else:
			translate(Vector2(-int(get_node("RayCast2D").get_collider().speed),-10))
		hit = false

var prev = 1
func _input(ev):
	if ev.is_pressed() && !ev.is_echo() && jump && start:
		jump = false
		sound = (randi() % 49)+1
		while sound == prev:
			sound = (randi() % 49)+1
		prev = sound
		get_node("SamplePlayer2D").play("hit"+str(sound))
		
		score +=1
		get_parent().get_node("gui/scores").set_text("SCORE: "+str(score))
		if side == 0:
			translate(Vector2(0,-20))
			get_node("AnimatedSprite/AnimationPlayer").play("rotate")
			get_node("AnimatedSprite").set_flip_h(true)
			side = 1
		else:
			translate(Vector2(0,20))
			get_node("AnimatedSprite/AnimationPlayer").play("rotate",-1,-1,true)
			get_node("AnimatedSprite").set_flip_h(false)
			side = 0

func _on_VisibilityNotifier2D_exit_viewport( viewport ):
	get_parent().get_node("gui/replay").show()
	get_parent().get_node("gui/scores").hide()
	get_parent().get_node("gui/welcome").set_text("GAME OVER\n SCORE: "+str(score))
	get_parent().get_node("gui/welcome").show()
	get_parent().get_node("Timer").stop()

	if score > get_previous_score():
		highscore(score)
		
	set_gold(gold_total)
	
	#get_parent().get_node("gui/start").queue_free()
	get_parent().get_node("gui/scores").set_text("SCORE: 0")
	if(Globals.has_singleton("AdMob")):
		admob = Globals.get_singleton("AdMob")
		admob.init(false, isTop, ad_id)
		admob.showBanner(true)
	


func _on_AnimationPlayer_finished():
	get_node("AnimatedSprite/AnimationPlayer").play("run")


func _on_start_pressed():
	get_parent().get_node("Timer").start()
	get_parent().get_node("Timer_block").start()
	get_parent().get_node("gui/welcome").hide()
	get_parent().get_node("gui/Button").hide()
	#get_node("AnimatedSprite/Particles2D").show()
	get_node("AnimatedSprite/AnimationPlayer").play("run")
	for block in get_tree().get_nodes_in_group("init_blocks"):
		block.movement = true
	for block in get_tree().get_nodes_in_group("init_blocks_sprites"):
		block.movement = true
	start = true
	get_parent().get_node("gui/start").queue_free()
	get_parent().get_node("gui/scores").set_text("SCORE: 0")
	if(Globals.has_singleton("AdMob")):
		admob = Globals.get_singleton("AdMob")
		admob.init(false, isTop, ad_id)
		admob.showBanner(false)
func update_size():
	if(admob != null):
		print(admob.getAdWidth(), ", ", admob.getAdHeight())
		admob.resize(isTop)	

	
func highscore(score):
	var f = ConfigFile.new()
	f.load(conf)
	f.set_value("game","score", score)
	f.save(conf)

func get_previous_score():
	var f = ConfigFile.new()
	f.load(conf)
	if f.has_section("game"):
		return int(f.get_value("game","score"))
	else:
		return 0

func set_gold(gold):
	var f = ConfigFile.new()
	f.load(conf)
	f.set_value("curency","gold", gold)
	f.save(conf)
	
func get_previous_gold():
	var f = ConfigFile.new()
	f.load(conf)
	if f.has_section("curency"):
		return int(f.get_value("curency","gold"))
	else:
		return 0



