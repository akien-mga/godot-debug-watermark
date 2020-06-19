extends Label


func _ready():
	$Tooltip.hide()


func _make_custom_tooltip(for_text):
	var tooltip = $Tooltip.duplicate()
	var rtl = tooltip.get_node("MarginContainer/RichTextLabel")
	rtl.bbcode_text = for_text
	return tooltip

