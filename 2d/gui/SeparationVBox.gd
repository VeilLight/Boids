extends VBoxContainer


# Called when the node enters the scene tree for the first time.
func _ready():
	_set_label_text($HSlider.value)

func _on_h_slider_value_changed(value):
	_set_label_text(value)

func _set_label_text(value):
	$Label.text = "Separation: " + str(value)
