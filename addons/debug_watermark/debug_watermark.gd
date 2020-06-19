# Debug watermark for Godot
# Public domain / Unlicense


extends CanvasLayer

## Placement

enum Corner {
	TOP_LEFT = Control.PRESET_TOP_LEFT,
	TOP_RIGHT = Control.PRESET_TOP_RIGHT,
	BOTTOM_LEFT = Control.PRESET_BOTTOM_LEFT,
	BOTTOM_RIGHT = Control.PRESET_BOTTOM_RIGHT,
}
export(Corner) var corner = Corner.BOTTOM_RIGHT
export(float) var margin_ratio = 0.05


## Content

export(String) var label_text = "Debug build"
export(bool) var enable_tooltip = true

# The following substitution tokens can be used:
#   {engine_version}        Godot version (auto)
#   {engine_platform}       Operating system (auto)
#   {project_name}          Project name (auto)
#   {project_user_data}     Project's user:// data folder (auto)
#
#   {project_version}       Project version (script variable)
#   {project_website}       Project website (script variable)
#   {project_reports_uri}   Issue reports URL or email (script variable)
export(String, MULTILINE) var tooltip = \
"""{project_name} {project_version} on {engine_platform}
Godot version: {engine_version}
Project website: {project_website}

Report issues at: {project_reports_uri}
Find logs at: {project_user_data}
"""

export(String) var project_version = "1.0"
export(String) var project_website = "https://godotengine.org"
export(String) var project_reports_uri = "https://github.com/akien-mga/godot-debug-watermark/issues"


## Style

export(Font) var custom_font = null


## Behavior

export(bool) var dismiss_with_right_click = true


func _ready():
	$DebugLabel.text = label_text

	if enable_tooltip:
		var engine_version = Engine.get_version_info()
		engine_version.hash = engine_version.hash.left(7)
		var tooltip_data = {
			engine_version = "{string} ({hash})".format(engine_version),
			engine_platform = OS.get_name(),
			project_name = ProjectSettings.get_setting("application/config/name"),
			project_user_data = OS.get_user_data_dir(),
			project_version = project_version,
			project_website = project_website,
			project_reports_uri = project_reports_uri,
		}
		$DebugLabel.hint_tooltip = tooltip.format(tooltip_data)
	else:
		$DebugLabel.hint_tooltip = ""

	if custom_font != null:
		$DebugLabel.set("custom_fonts/font", custom_font)

	place_watermark()
	# Recompute margin on size change.
	get_tree().get_root().connect("size_changed", self, "place_watermark")


func place_watermark():
	"""Handles replacing the watermark when the root Viewport size changes."""
	var window_size = OS.window_size
	var margin = int(min(window_size.x, window_size.y) * margin_ratio)
	$DebugLabel.set_anchors_and_margins_preset(corner, Control.PRESET_MODE_KEEP_SIZE, margin)


func _on_DebugLabel_gui_input(event):
	if not dismiss_with_right_click:
		return
	if event is InputEventMouseButton and event.button_index == BUTTON_RIGHT and event.pressed:
		queue_free()
