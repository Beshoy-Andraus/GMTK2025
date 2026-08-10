extends Node2D

@onready var boom: AudioStreamPlayer = $boom
@onready var tele: AudioStreamPlayer = $tele
@onready var step: AudioStreamPlayer = $step
@onready var tred: AudioStreamPlayer = $tred
@onready var estep: AudioStreamPlayer = $estep
@onready var swap: AudioStreamPlayer = $swap
@onready var clicked: AudioStreamPlayer = $clicked
@onready var key: AudioStreamPlayer = $key
@onready var door: AudioStreamPlayer = $door
@onready var slider: AudioStreamPlayer = $slider

var sfx_volume: float = 0.0

func _ready():
	_update_all_volumes()
func set_sfx_volume(new_volume: float):
	sfx_volume = clamp(new_volume, -80.0, 0.0)
	_update_all_volumes()
func _update_all_volumes():
	for player in [boom, tele, step, tred, estep, swap, clicked, key, door, slider]:
		player.volume_db = sfx_volume
func _play_and_wait(player: AudioStreamPlayer) -> Signal:
	player.play()
	return player.finished
func p_move() -> Signal:
	return _play_and_wait(step)

func flags() -> Signal:
	tele.pitch_scale = 2.0
	return _play_and_wait(tele)

func emove() -> Signal:
	return _play_and_wait(estep)

func explo() -> Signal:
	return _play_and_wait(boom)

func odoor() -> Signal:
	return _play_and_wait(door)

func keys() -> Signal:
	return _play_and_wait(key)
	
func slide():
	return _play_and_wait(slider)

func click() -> Signal:
	return _play_and_wait(clicked)

func swa() -> Signal:
	swap.pitch_scale = 1.5
	return _play_and_wait(swap)

func tread() -> Signal:
	return _play_and_wait(tred)
