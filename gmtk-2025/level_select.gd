extends Node2D

@onready var next: TextureButton = $"0-10/next"
@onready var last: TextureButton = $"11-23/last"
@onready var _0: TextureButton = $"0-10/0"
@onready var _1: TextureButton = $"0-10/1"
@onready var _2: TextureButton = $"0-10/2"
@onready var _3: TextureButton = $"0-10/3"
@onready var _4: TextureButton = $"0-10/4"
@onready var _5: TextureButton = $"0-10/5"
@onready var _6: TextureButton = $"0-10/6"
@onready var _7: TextureButton = $"0-10/7"
@onready var _8: TextureButton = $"0-10/8"
@onready var _9: TextureButton = $"0-10/9"
@onready var _10: TextureButton = $"0-10/10"
@onready var _11: TextureButton = $"11-23/11"
@onready var _12: TextureButton = $"11-23/12"
@onready var _13: TextureButton = $"11-23/13"
@onready var _14: TextureButton = $"11-23/14"
@onready var _15: TextureButton = $"11-23/15"
@onready var _16: TextureButton = $"11-23/16"
@onready var _17: TextureButton = $"11-23/17"
@onready var _18: TextureButton = $"11-23/18"
@onready var _19: TextureButton = $"11-23/19"
@onready var _20: TextureButton = $"11-23/20"
@onready var _21: TextureButton = $"11-23/21"
@onready var _22: TextureButton = $"11-23/22"
@onready var _23: TextureButton = $"11-23/23"

@onready var _0_10: Node2D = $"0-10"
@onready var _11_23: Node2D = $"11-23"

func _ready():
	_0_10.show()
	_11_23.hide()

	next.pressed.connect(func():
		Sfx.click()
		_0_10.hide()
		_11_23.show()
	)
	last.pressed.connect(func():
		Sfx.click()
		_0_10.show()
		_11_23.hide()
	)
	_connect_level(_0, "res://level_0.tscn")
	_connect_level(_1, "res://level_1.tscn")
	_connect_level(_2, "res://level_2.tscn")
	_connect_level(_3, "res://level_3.tscn")
	_connect_level(_4, "res://level_4.tscn")
	_connect_level(_5, "res://level_5.tscn")
	_connect_level(_6, "res://level_6.tscn")
	_connect_level(_7, "res://level_7.tscn")
	_connect_level(_8, "res://level_8.tscn")
	_connect_level(_9, "res://level_9.tscn")
	_connect_level(_10, "res://level_10n.tscn")
	_connect_level(_11, "res://level_10.tscn")
	_connect_level(_12, "res://level_11.tscn")
	_connect_level(_13, "res://level_12.tscn")
	_connect_level(_14, "res://level_13.tscn")
	_connect_level(_15, "res://level_14.tscn")
	_connect_level(_16, "res://level_15.tscn")
	_connect_level(_17, "res://level_16.tscn")
	_connect_level(_18, "res://level_17.tscn")
	_connect_level(_19, "res://level_19.tscn")
	_connect_level(_20, "res://20.tscn")
	_connect_level(_21, "res://level_21.tscn")
	_connect_level(_22, "res://level_22.tscn")
	_connect_level(_23, "res://level_23.tscn")


func _connect_level(button: TextureButton, scene_path: String) -> void:
	button.pressed.connect(func():
		_on_any_level_pressed(scene_path)
	)

func _on_any_level_pressed(scene_path: String) -> void:
	Tran.trans()
	Sfx.click()
	Music.player()
	Tran.animation_player.animation_finished.connect(
		func(_anim_name):
			get_tree().change_scene_to_file(scene_path),
		CONNECT_ONE_SHOT
	)


func _on_texture_button_pressed() -> void:
	Global.butdis = true
	Sfx.click()
	self.hide()
