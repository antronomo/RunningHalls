extends Control


@onready var conf_data : Dictionary = Globals.config_data

@onready var tab_container : TabContainer = $TabContainer
@onready var voice_slider : HSlider = $TabContainer/Tabs1/VoiceHSlider
@onready var voice_value : Label = $TabContainer/Tabs1/VoiceValue
@onready var enemies_lock_rotation_button : CheckButton = $TabContainer/Tabs2/EnemiesLockRotation


signal return_pressed


func _ready() -> void:
	set_buttons_options()


func set_buttons_options() -> void: 
	#tab 0
	
	#tab1
	_on_voice_h_slider_value_changed(conf_data.voice_volume)
	
	#tab2
	enemies_lock_rotation_button.button_pressed = not conf_data.enemies_lock_rotation


func _on_Button1_pressed() -> void:
	tab_container.current_tab = 0


func _on_Button2_pressed() -> void:
	tab_container.current_tab = 1


func _on_button_3_pressed() -> void:
	tab_container.current_tab = 2
	

func _on_reset_pressed() -> void:
	tab_container.current_tab = 3


func _on_Return_pressed() -> void:
	Globals.set_config_data("enemies_lock_rotation", conf_data.enemies_lock_rotation)
	Globals.save_config_to_file()
	emit_signal("return_pressed")


# Volumen tab ------------------------------------------------------------
func _on_voice_h_slider_value_changed(value : float) -> void:
	conf_data.voice_volume = value
	voice_value.text = str(value * 100.0) + "%"


# Secret tab -------------------------------------------------------------
func _on_enemies_lock_rotation_toggled(toggled_on : bool) -> void:
	# Changed the name option to "rolling enemies"
	# so inverted the toggled_on bool to make sense
	conf_data.enemies_lock_rotation = not toggled_on


# Reset tab --------------------------------------------------------------
func _on_button_pressed() -> void:
	Globals.resset_config_data()
	conf_data = Globals.config_data
	set_buttons_options()

