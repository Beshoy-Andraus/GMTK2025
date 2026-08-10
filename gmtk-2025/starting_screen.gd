extends Node2D
@onready var level_select: Node2D = $"Level Select"
@onready var texture_button_2: TextureButton = $TextureButton2
@onready var texture_button: TextureButton = $TextureButton

func _ready() -> void:
	Global.hide = true
	Music.intros()
func _physics_process(delta: float) -> void:
	if Global.butdis == true:
		$"Sprite-0011".show()
		texture_button.disabled = false
		texture_button.disabled = false
	
func _on_texture_button_pressed() -> void:
	texture_button.disabled = true
	texture_button.disabled = true
	Global.butdis = false
	Sfx.click()
	$"Sprite-0011".hide()
	level_select.show()

func _on_texture_button_2_pressed() -> void:
	texture_button.disabled = true
	texture_button.disabled = true
	Global.butdis = false
	Sfx.click()
	$"Sprite-0011".hide()
	$Settings.show()
