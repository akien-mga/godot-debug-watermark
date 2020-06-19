# Debug watermark for Godot

This simple scene can be used to add a watermark to **Debug** builds of Godot
Engine projects, to visually identify them as such.

It can be used to prevent confusion between Release and Debug builds which
have different optimizations and validation code, and thus performance.
Additionally, the watermark includes a tooltip which can be used to provide
information to testers.

## Setup

To enable it, copy the files to your project folder while preserving the
folder structure (i.e. as ``addons/debug_watermark``), and add the
``debug_watermark.tscn`` scene in your project settings' AutoLoad tab.

## Configuration

Some options are provided as script variables in ``debug_watermark.tscn`` to
change the position of the watermark, customize the font and tooltip, etc.

More customization can be done by changing the nodes' properties directly to
best fit your project's needs.

## License

This project is dedicated to the public domain via the Unlicense license.
See LICENSE.txt for details.
