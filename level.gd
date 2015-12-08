#sample level

#notes:
#	this is a pointless game
#	notice now you don't have to turn on ads from here because ads are overlayed on top of your game and not in your game


extends Control

var sceneManager = null
var menuPath = "res://menu.scn"

func _ready():
	# Initialization here
	sceneManager = get_tree().get_root().get_node("sceneManager")


func _on_Button_pressed():
	sceneManager.setScene(menuPath)
