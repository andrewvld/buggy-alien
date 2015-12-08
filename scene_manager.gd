#scene_manager
#	responsible for keeping track of the current scene and changing scenes

#notes:
#	this script is added to Autoload so it can be used anywhere
#
#	don't worry about all this, it's just the way I switch scenes
#	this isn't really part of the AdMob Example, aside from showing that you can change scenes and the ad banner won't be affected
#	this is because AdMob ads are overlayed overtop of your Godot game, and not a part of it

extends Node

var currentScene = null
var currentScenePath = ""
var menuPath = "res://menu.scn"

func _ready():
	#initialize current scene
	var root = get_tree().get_root()
	currentScene = root.get_child(root.get_child_count() - 1)		#last child is the root node (aka root scene)
	currentScenePath = menuPath										#set initial menu path
	
func setScene(path):
	#check if scene is already set
	if(currentScenePath == path):
		return														#do nothing if scene is already set

	#set scene when no code from current scene is running
	call_deferred("_deferred_setScene", path)
	
func _deferred_setScene(path):
	#free memory of current scene
	currentScene.free()
	
	#memorize path
	currentScenePath = path
	
	#load a new scene and instance it
	var newScene = load(path)
	currentScene = newScene.instance()
	
	#add new scene as the current scene in the scene tree
	get_tree().get_root().add_child(currentScene)
	get_tree().set_current_scene(currentScene)						#make it compatible with the SceneTree.change_scene() API
	
func getScene():
	return currentScenePath