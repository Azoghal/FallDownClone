extends Control

var music_ind
var sfx_ind
var music
var sfx

# Called when the node enters the scene tree for the first time.
func _ready():
	self.sfx = $VBoxContainer/VBoxContainer/SFX
	self.music = $VBoxContainer/VBoxContainer/Music

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func show_menu():
	self.visible = true
	self.music_ind = AudioServer.get_bus_index("Music")
	self.sfx_ind = AudioServer.get_bus_index("SFX")
	self.music.button_pressed = not AudioServer.is_bus_mute(self.music_ind)
	self.sfx.button_pressed = not AudioServer.is_bus_mute(self.sfx_ind)
	
func close_menu():
	self.visible = false
	get_tree().paused = false

func _on_button_button_down():
	self.close_menu()


func _on_quit_to_menu_button_down():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://menu.tscn")


func _on_quit_button_down():
	get_tree().quit()


func _on_music_button_down():
	var music_ind = AudioServer.get_bus_index("Music")
	AudioServer.set_bus_mute(music_ind, not AudioServer.is_bus_mute(music_ind))   



func _on_sfx_button_down():
	var sfx_ind = AudioServer.get_bus_index("SFX")
	AudioServer.set_bus_mute(sfx_ind, not AudioServer.is_bus_mute(sfx_ind))   

