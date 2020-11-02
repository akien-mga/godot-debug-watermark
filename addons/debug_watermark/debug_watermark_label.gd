extends Label


func _ready():
	$Tooltip.hide()


func _make_custom_tooltip(for_text):
	var tooltip = $Tooltip.duplicate()
	# Must be made visible beforehand, otherwise Viewport size calculations
	# would be incorrect (see https://github.com/godotengine/godot/issues/39677).
	tooltip.visible = true
	var rtl = tooltip.get_node("PanelContainer/MarginContainer/RichTextLabel")
	rtl.bbcode_text = for_text
	# Work around https://github.com/godotengine/godot/issues/18260.
	rtl.rect_min_size = rtl.rect_size
	return tooltip

