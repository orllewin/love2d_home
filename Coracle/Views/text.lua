
require "Coracle/Views/view_utils"
require "Coracle/colour"

class('Text').extends()

function Text:init(label, x, y, colour)
	Text.super.init()
	
	self.label = label
	self.x = x
	self.y = y
	self.colour = colour
end

function Text:draw()
	love.graphics.print(self.label, self.x, self.y)
end