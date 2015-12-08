#simple ad manager script

#notes:
#	this script is added to Autoload so it can be used anywhere
#	for ads to work on Android, you have to add the [Android] portion to the engine.cfg file of your project (look at the top of this project's file)
#	I think I mentioned this before, but just in case I forgot here it is again:
#		AdMob ads only work when you are connected to the internet on your android device

extends Node

#enable ads for distribution, disable for personal use
#clicking on your own ads is against the admob guidelines
#disabling realAds prevents accidents but still shows test ads so you know it's working
var realAds = true

var admob = null	#points to admob singleton from module
var isTop = true	#display banner on top or bottom

#get this string when you register your app in adbmob backend
#if you do not put the correct app publisher id, you won't get any ads
#be patient as ads make take a few seconds to load sometimes
var banner_app_id = "ca-app-pub-"		#your admob ad id here
#var interstitial_app_id = "ca-app-pub-####"							#this module doesn't have these kinds of ads :(


func _ready():
	set_process(true)
	
	if(Globals.has_singleton("AdMob")):				#if the admob singleton is avaliable (only if run on android and built using the correct andorid export template)
		admob = Globals.get_singleton("AdMob")		#get the singleton the module created
		admob.init(realAds, isTop, banner_app_id)	#initialize it with your ad settings


#active banner ad
func showBanner():
	if(admob):
		admob.showBanner(true)


#deactivate banner ad
func hideBanner():
	if(admob):
		admob.showBanner(false)
		