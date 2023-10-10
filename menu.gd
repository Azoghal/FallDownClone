extends Control

var music_ind
var sfx_ind
var music: CheckButton
var sfx: CheckButton

# Called when the node enters the scene tree for the first time.
func _ready():
	print("Doign it a gain")
	self.music_ind = AudioServer.get_bus_index("Music")
	self.sfx_ind = AudioServer.get_bus_index("SFX")
	self.music = $MarginContainer/VBoxContainer/HBoxContainer/MarginContainer/VBoxContainer/Music
	self.music.button_pressed = not AudioServer.is_bus_mute(self.music_ind)
	self.sfx = $MarginContainer/VBoxContainer/HBoxContainer/MarginContainer/VBoxContainer/Music
	self.sfx.button_pressed = not AudioServer.is_bus_mute(self.sfx_ind)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_begin_button_down():
	get_tree().change_scene_to_file("res://main.tscn")


func _on_salgo_button_down():
	get_tree().quit()
	
	
func _on_music_button_down():
	AudioServer.set_bus_mute(self.music_ind, not AudioServer.is_bus_mute(self.music_ind))   

func _on_sfx_button_down():

	AudioServer.set_bus_mute(self.sfx_ind, not AudioServer.is_bus_mute(self.sfx_ind))   

