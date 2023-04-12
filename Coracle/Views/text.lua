
require "Coracle/Views/view_utils"
require "Coracle/colour"

class('Text').extends()

function Text:init(label, x, y, colour)
	Text.super.init()
	
	self.label = label
	self.x = x
	self.y = y
	
	if colour ~= nil then
		self.colour = rgb(colour)
	else
		self.colour = white()
	end
	
end

function Text:draw()
	local r, g, b, a = love.graphics.getColor()
	love.graphics.setColor(self.colour)
	
	love.graphics.print(self.label, self.x, self.y)
	
	love.graphics.setColor(r, g, b, a)
end