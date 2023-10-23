extends Control

onready var select_sound =$SelectSound
onready var main_menu =$MainMenuMusic
var sound =1

func _ready():
	main_menu.play()
func _on_StartButton_pressed():
	select_sound.play()
	if get_tree().change_scene("res://levels/level1.tscn") != OK:
		print("not ok")
		
	



	


func _on_ExitButton_pressed():
	select_sound.play()
	get_tree().quit()
	


func _on_Sound_button_pressed():
	var master_sound = AudioServer.get_bus_index("Master")
	if sound ==1:
		AudioServer.set_bus_mute(master_sound, true)
		sound =0
	else:
		AudioServer.set_bus_mute(master_sound, false)
		sound =1
		
