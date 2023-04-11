require "Coracle/object"
require "Coracle/love_config"
require "Coracle/Views/view_manager"
require "Coracle/Views/button"
require "Coracle/Views/image"
require "Coracle/Views/slider"

local config = LoveConfig()
local viewManager = ViewManager()

local debug = ""

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
				
			end
		end
		--config()
	else
		debug = debug .. "\nno config..."
		love.filesystem.write("config.lua", "{}")
		--todo - show info on writing config or something
	end
	
	viewManager:add(Button("Orllewin.uk", 095, 70, 180, 40, function() 
		love.system.openURL("http://orllewin.uk/")
	end))
	
	viewManager:add(Button("Open Nova", 095, 115, 180, 40, function() 
		os.execute("open /Applications/Nova.app")
	end))
	
	
	
end	

function love.keypressed(key)
		if key == "s" then
				love.system.openURL("file://"..love.filesystem.getSaveDirectory())
		end
end


function love.update(dt)
end

function love.draw()
	 love.graphics.print("Home", 10, 10)
	 love.graphics.print(debug, 10, 150)
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
