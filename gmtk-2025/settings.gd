extends Node2D
@onready var music_slider: HSlider = $HSlider
@onready var sfx_slider: HSlider = $HSlider2
func _ready():
	sfx_slider.value = Sfx.sfx_volume
	music_slider.value = Music.music_volume



func _on_texture_button_pressed() -> void:
	Sfx.click()
	Global.butdis = true
	self.hide()


func _on_h_slider_value_changed(value: float) -> void:
	Music.set_music_volume(value)


func _on_h_slider_2_value_changed(value: float) -> void:
	Sfx.set_sfx_volume(value)
	Sfx.slide()


func _on_check_button_toggled(toggled_on: bool) -> void:
	if toggled_on:
		Global.hide = true
	else:
		Global.hide = false
