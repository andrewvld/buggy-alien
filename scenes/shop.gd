
extends Node

# member variables here, example:
# var a=2
# var b="textvar"
var gold 
var conf = "user://config.cfg" 
func _ready():
	gold = int(Globals.get("gold"))
	get_node("gui/gold").set_text(str(gold))
	var f = ConfigFile.new()
	f.load(conf)
	if f.has_section("game_bg_moon"):
		var moon = int(f.get_value("game_bg_moon","bg_moon"))
		if moon == 1:
			get_node("gui/Button").set_opacity(1)


func _on_Button_2_pressed():
	var f = ConfigFile.new()
	f.load(conf)
	f.set_value("game_bg","bg", 1)
	f.save(conf)

func _on_Button_pressed():
	var f = ConfigFile.new()
	f.load(conf)
	var moon = 0
	if f.has_section("game_bg_moon"):
		moon = int(f.get_value("game_bg_moon","bg_moon"))
		if( moon ==0):
			if gold > 350:
				f.set_value("game_bg_moon","bg_moon", 1)
				gold = gold - 350
				f.set_value("curency","gold", gold)
				get_node("gui/gold").set_text(str(gold))
				moon = 1
				
	else:
		if gold > 350:
			f.set_value("game_bg_moon","bg_moon", 1)
			gold = gold - 350
			f.set_value("curency","gold", gold)
			get_node("gui/gold").set_text(str(gold))
			moon = 1
		else:
			f.set_value("game_bg_moon","bg_moon", 0)

	if moon == 1:
		f.set_value("game_bg","bg", 2)
	f.save(conf)


