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
		if configTable.views ~= nil then
			for i=1,#configTable.views do
				local view = configTable.views[i]
				local viewType = view[1]
				if viewType == "text" then
					addText(view)
				elseif viewType == "image" then
					addImage(view)
				elseif viewType == "image_button" then
					addImageButton(view)
				elseif viewType == "button" then
					addButton(view)
				elseif viewType == "rect" then
					addRect(view)
				end
			end
		end
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

-- View Builders ----------------------------------------------------------------------

function addText(view)
	viewManager:add(Text(view[2], view[3], view[4], view[5]))
end

function addImage(view)
	viewManager:add(Image(view[2], view[3], view[4], view[5]))
end

function addRect(view)
	viewManager:add(Rect(view[2], view[3], view[4], view[5], view[6], view[7], view[8], view[9]))
end

function addImageButton(view)
	local buttonType = view[5]
	if buttonType == "config" then
		viewManager:add(ImageButton(view[2], view[3], view[4], function() 
			love.system.openURL("file://"..love.filesystem.getSaveDirectory())
		end))
	end
	if buttonType == "web" then
		viewManager:add(ImageButton(view[2], view[3], view[4], function() 
			love.system.openURL(view[6])
		end))
	end
	if buttonType == "action" then
		viewManager:add(ImageButton(view[2], view[3], view[4], function() 
			os.execute(view[6])
		end))
	end
	if buttonType == "copy" then
		viewManager:add(ImageButton(view[2], view[3], view[4], function() 
			love.system.setClipboardText(view[6])
			toast("Text Copied")
		end))
	end
end

function addButton(view)
	local buttonType = view[7]
	if buttonType == "web" then
		viewManager:add(Button(view[2], view[3], view[4], view[5], view[6], function() 
			love.system.openURL(view[8])
		end))
	elseif buttonType == "action" then
		viewManager:add(Button(view[2], view[3], view[4], view[5], view[6], function() 
			os.execute(view[8])
		end))
	elseif buttonType == "copy" then
		viewManager:add(Button(view[2], view[3], view[4], view[5], view[6], function() 
			love.system.setClipboardText(view[8])
			toast("Text Copied")
		end))
	elseif buttonType == "config" then
			viewManager:add(Button(view[2], view[3], view[4], view[5], view[6], function() 
				love.system.openURL("file://"..love.filesystem.getSaveDirectory())
			end))
	end
end
