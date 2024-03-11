extends Control


signal return_pressed


@onready var tab_container : TabContainer = $TabContainer
@onready var enemies_lock_rotation_button : CheckButton = $TabContainer/Tabs2/EnemiesLockRotation

@onready var conf_data : Dictionary = Globals.config_data


func _ready() -> void:
	set_buttons_options()


func set_buttons_options() -> void: 
	enemies_lock_rotation_button.button_pressed = conf_data.enemies_lock_rotation


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


# Secret section ---------------------------------------------------------
func _on_enemies_lock_rotation_toggled(toggled_on : bool) -> void:
	conf_data.enemies_lock_rotation = toggled_on


# Reset section ----------------------------------------------------------
func _on_button_pressed() -> void:
	Globals.resset_config_data()
	conf_data = Globals.config_data
	set_buttons_options()
