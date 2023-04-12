require "Coracle/object"
require "Coracle/love_config"
require "Coracle/Views/view_manager"
require "Coracle/Views/button"
require "Coracle/Views/image"
require "Coracle/Views/image_button"
require "Coracle/Views/text"
require "Coracle/Views/rect"
require "Coracle/timer"
require "Coracle/timers"

local config = LoveConfig()
local viewManager = ViewManager()
local timers = Timers()

local debug = ""

local toastMessage = ""

function love.load()
	love.filesystem.write(".orllewin_home", "")
	config:initFont("Fonts/Proggy/proggy-square-rr.ttf", 32)
	viewManager:setConfig(config)

	local configPath = "config.lua"
	debug = debug .. "load: " .. configPath
	local configInfo = love.filesystem.getInfo(configPath)
	if configInfo ~= nil then
		debug = debug .. "\nfound config..."
		configTable = love.filesystem.load(configPath)()
		if configTable.views ~= nil then
			for i=1,#configTable.views do
				local view = configTable.views[i]
				if view[1] == "text" then
					viewManager:add(Text(view[2], view[3], view[4]))
				elseif view[1] == "rect" then
					viewManager:add(Rect(view[2], view[3], view[4], view[5], view[6], view[7], view[8]))

				end
			end
		end
		if configTable.title ~= nil then love.window.setTitle(configTable.title) end
		if configTable.background ~= nil then love.graphics.setBackgroundColor(rgb(configTable.background)) end
		if configTable.fullscreen ~= nil then 
			love.window.setFullscreen(configTable.fullscreen, "desktop")	
		end
		if configTable.font ~= nil then
			local fontPath = configTable.font
			local fontSize = 32
			if configTable.font_size ~= nil then
				config:initFont(fontPath, configTable.font_size)
			else
				config:initFont(fontPath, 32)
			end
			
		end
		if configTable.images ~= nil then
			for i=1,#configTable.images do
				local im = configTable.images[i]
				viewManager:add(Image(im[1], im[2], im[3], im[4]))
			end
		end
		if configTable.buttons ~= nil then
			for i=1,#configTable.buttons do
				local b = configTable.buttons[i]
				if b[6] == "web" then
					viewManager:add(Button(b[1], b[2], b[3], b[4], b[5], function() 
						love.system.openURL(b[7])
					end))
				end
				if b[6] == "action" then
					viewManager:add(Button(b[1], b[2], b[3], b[4], b[5], function() 
						os.execute(b[7])
					end))
				end
				if b[6] == "copy" then
					viewManager:add(Button(b[1], b[2], b[3], b[4], b[5], function() 
						love.system.setClipboardText(b[7])
						toast("Text Copied")
					end))
				end
				
			end
		end
		if configTable.image_buttons ~= nil then
			for i=1,#configTable.image_buttons do
				local b = configTable.image_buttons[i]
				if b[4] == "config" then
					viewManager:add(ImageButton(b[1], b[2], b[3], function() 
						love.system.openURL("file://"..love.filesystem.getSaveDirectory())
					end))
				end
				if b[4] == "web" then
					viewManager:add(ImageButton(b[1], b[2], b[3], function() 
						love.system.openURL(b[7])
					end))
				end
				if b[4] == "action" then
					viewManager:add(ImageButton(b[1], b[2], b[3], function() 
						os.execute(b[7])
					end))
				end
				if b[4] == "copy" then
					viewManager:add(ImageButton(b[1], b[2], b[3], function() 
						love.system.setClipboardText(b[7])
						toast("Text Copied")
					end))
				end
			end
		end
		if configTable.text ~= nil then
			for i=1,#configTable.text do
				local t = configTable.text[i]
				viewManager:add(Text(t[1], t[2], t[3]))
			end
		end
		--config()
	else
		debug = debug .. "\nno config..."
		love.filesystem.write("config.lua", "{}")
		--todo - show info on writing config or something
	end	
end	

function toast(message)
	timers:cancel("toast")
	toastMessage = message
	
	timers:add(Timer("toast", 2000, function()
			toastMessage = ""
		end))
	timers:start("toast")
end

function love.keypressed(key)
		if key == "s" then
				love.system.openURL("file://"..love.filesystem.getSaveDirectory())
		end
end


function love.update(dt)
	timers:update(dt)
end

function love.draw()
	 love.graphics.print("Home", 10, 10)
	 love.graphics.print(debug, 800, 150)
	 if toastMessage ~= nil and toastMessage ~= "" then
	     love.graphics.print(toastMessage, 10, 860)
   end
	 viewManager:drawViews()
end

function love.mousepressed(x, y, button)
	if button == 1 then viewManager:clickDown(x, y) end
end

function love.mousereleased(x, y, button)
	 if button == 1 then viewManager:clickUp(x, y) end
end

function love.mousemoved(x, y, dx, dy, istouch)
	viewManager:mousemoved(x, y, dx, dy, istouch)
end
