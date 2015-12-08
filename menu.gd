
extends Control

var adManager = null
var sceneManager = null
var level1Path = "res://level.scn"
var admob = null
var isTop = true
var ad_id = "ca-app-pub-4589244455759759/3213519620"

func _ready():
	# Initialization here
	sceneManager = get_tree().get_root().get_node("sceneManager")
	
	#for some reason you cannot activate the ad here, so I'll do it in _process()
	set_process(true)
	
	get_tree().connect("screen_resized",self,"update_size")
	if(Globals.has_singleton("AdMob")):
		admob = Globals.get_singleton("AdMob")
		admob.init(false, isTop, ad_id)
		admob.showBanner(true)
func update_size():
	if(admob != null):
		print(admob.getAdWidth(), ", ", admob.getAdHeight())
		admob.resize(isTop)	
func _process(delta):
	#activate the ad and then disable _process() becuase there is nothing to process besides turning on the ad
	set_process(false)


func _on_Button_pressed():
	sceneManager.setScene(level1Path)


func _on_Button_2_pressed():
	get_tree().quit()
