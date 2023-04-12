# LÖVE Home

A personal home launcher written in Love2D/LÖVE. 

![Screenshot](./readme_assets/screenshot.png)

## Instructions

Install Love etc etc, clone, open in Nova, run.

On first launch hit 's' to open the save directory and duplicate the following example in `config.lua`, note the separate type tables are being replaced by a common `views` table:

```
local buttonWidth = 220

return {
	title = "Orllewin Home",
	background = "#547867",
	fullscreen = true,
	font = "HelveticaNeue.ttc",
	font_size = 22,
	views = {
		{"rect", 645, 5, 180, 280, 1, 3, "#eeffee"},
		{"text", "Orllewin Dev", 650, 10}
	},
	
	--title, x, y, width, height, type, url/action/text
	buttons = {
		{"Orllewin", 10, 10, buttonWidth, 40, "web", "https://orllewin.uk"},
		{"Open Nova", 10, 60, buttonWidth, 40, "action", "open /Applications/Nova.app"},
		{"Merveilles", 10, 110, buttonWidth, 40, "web", "https://merveilles.town/home"},
		{"Copy Password", 10, 160, buttonWidth, 40, "copy", "secret_password"}
	},
	
	--image path, x, y, type, optional url/action
	image_buttons = {
		{"images/open_save_dir.png", 1395, 855, "config"}
	},
	
	--path, x, y, scale
	images = {
		{"images/sp.png", 300, 10, 0.5},
		{"images/a.png", 300, 400, 0.5}
	},
	
	--text, x, y
	text = {
		{"Hello, World!", 10, 500}
	}
}
```

## Views

The available view types and their syntax.

### Rect

![Rect](./readme_assets/rect.png)

A border used to group a collection of views:


"rect" - String, the view type identifier  
x - Int  
y - Int   
width - Int  
height - Int  
lineWidth - Int   
cornerRadius - Int   
colour - Hex colour String, eg. "#112233" 

Example: 
```
{"rect", 645, 5, 180, 280, 1, 3, "#eeffee"}
```



