extends Control


@onready var conf_data : Dictionary = Globals.config_data
@onready var tab_container : TabContainer = $TabContainer
@onready var enemies_lock_rotation_button : CheckButton = $TabContainer/SecretTab/EnemiesLockRotation
@onready var extra_tab_container : TabContainer = $TabContainer/ExtraTab/ExtraTabContainer

@onready var audio_stream_player : AudioStreamPlayer = $TabContainer/VolumeTab/AudioStreamPlayer
@onready var sound_fx_value : Label = $TabContainer/VolumeTab/SoundFXsection/SoundFXvalue
@onready var sound_fx_hslider : HSlider = $TabContainer/VolumeTab/SoundFXsection/SoundFXHSlider
@onready var voice_slider : HSlider = $TabContainer/VolumeTab/VoiceSection/VoiceHSlider
@onready var voice_value : Label = $TabContainer/VolumeTab/VoiceSection/VoiceValue
@onready var music_hslider : HSlider = $TabContainer/VolumeTab/MusicSection/MusicHSlider
@onready var music_value : Label = $TabContainer/VolumeTab/MusicSection/MusicValue


var max_extra_tabs : int


signal return_pressed
signal button_pressed


func _ready() -> void:
	set_buttons_options()
	tab_container.current_tab = 0
	max_extra_tabs = extra_tab_container.get_tab_count() -1


func set_buttons_options() -> void: 
	# how_to tab
	
	# volume tab
	_on_voice_h_slider_value_changed(conf_data.voice_volume)
	voice_slider.value = conf_data.voice_volume
	_on_sound_fxh_slider_value_changed(conf_data.sfx_volume)
	sound_fx_hslider.value = conf_data.sfx_volume
	_on_music_h_slider_value_changed(conf_data.music_volume)
	music_hslider.value = conf_data.music_volume
	
	# secret tab
	enemies_lock_rotation_button.button_pressed = not conf_data.enemies_lock_rotation


func _on_HowToButton_pressed() -> void:
	emit_signal("button_pressed")
	tab_container.current_tab = 0


func _on_VolumeButton_pressed() -> void:
	emit_signal("button_pressed")
	tab_container.current_tab = 1


func _on_extras_button_pressed() -> void:
	emit_signal("button_pressed")
	extra_tab_container.current_tab = 0
	tab_container.current_tab = 2


func _on_SecretButton_pressed() -> void:
	emit_signal("button_pressed")
	tab_container.current_tab = 3


func _on_ResetButton_pressed() -> void:
	emit_signal("button_pressed")
	tab_container.current_tab = 4


func _on_ReturnButton_pressed() -> void:
	emit_signal("button_pressed")
	#Globals.set_config_data("enemies_lock_rotation", conf_data.enemies_lock_rotation)
	#Globals.set_config_data("voice_volume", conf_data.voice_volume)
	Globals.save_config_to_file()
	emit_signal("return_pressed")


# Volumen tab ------------------------------------------------------------
# Voices
func _on_voice_h_slider_value_changed(value : float) -> void:
	conf_data.voice_volume = value
	AudioServer.set_bus_volume_db(1, linear_to_db(value))
	voice_value.text = str(value * 100.0) + "%"
	Globals.set_config_data("voice_volume", value)


func _on_voice_h_slider_drag_started() -> void:
	audio_stream_player.playing = true
	audio_stream_player.bus = "VoiceAudio"


func _on_voice_h_slider_drag_ended(_value_changed : float) -> void:
	audio_stream_player.playing = false


# SoundFX
func _on_sound_fxh_slider_value_changed(value : float) -> void:
	conf_data.sfx_volume = value
	AudioServer.set_bus_volume_db(2, linear_to_db(value))
	sound_fx_value.text = str(value * 100.0) + "%"
	Globals.set_config_data("sfx_volume", value)


func _on_sound_fxh_slider_drag_started() -> void:
	audio_stream_player.playing = true
	audio_stream_player.bus = "SoundFX"


func _on_sound_fxh_slider_drag_ended(_value_changed : float) -> void:
	audio_stream_player.playing = false


# Music
func _on_music_h_slider_value_changed(value : float) -> void:
	conf_data.music_volume = value
	AudioServer.set_bus_volume_db(3, linear_to_db(value))
	music_value.text = str(value * 100.0) + "%"
	Globals.save_config_to_file()
	Globals.set_config_data("music_volume", value)


func _on_music_h_slider_drag_started() -> void:
	pass


func _on_music_h_slider_drag_ended(_value_changed : float) -> void:
	pass


# Secret tab -------------------------------------------------------------
func _on_enemies_lock_rotation_toggled(toggled_on : bool) -> void:
	# Changed the name option to "rolling enemies"
	# so inverted the toggled_on bool to make sense
	conf_data.enemies_lock_rotation = not toggled_on


# Reset tab --------------------------------------------------------------
func _on_button_pressed() -> void:
	emit_signal("button_pressed")
	Globals.resset_config_data()
	conf_data = Globals.config_data
	set_buttons_options()


# Extras tab -------------------------------------------------------------
func _on_left_extra_button_pressed() -> void:
	emit_signal("button_pressed")
	extra_tab_container.current_tab = clamp(extra_tab_container.current_tab -1 , 0, max_extra_tabs)


func _on_right_extra_button_pressed() -> void:
	emit_signal("button_pressed")
	extra_tab_container.current_tab = clamp(extra_tab_container.current_tab +1 , 0, max_extra_tabs)

