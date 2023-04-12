require "Coracle/colour"

class('Rect').extends()

function Rect:init(x, y, width, height, lineWidth, cornerRadius, colour, drawType)
	Rect.super.init()
	
	self.x = x
	self.y = y
	self.width = width
	self.height = height
	self.lineWidth = lineWidth
	self.cornerRadius = cornerRadius
	self.drawType = drawType
	
	if colour ~= nil then
		self.colour = rgb(colour)
	else
		self.colour = white()
	end
	
end

function Rect:draw()
	local r, g, b, a = love.graphics.getColor()
	love.graphics.setColor(self.colour)
	
	if self.drawType == "fill" then
		love.graphics.rectangle("fill", self.x, self.y, self.width, self.height, self.cornerRadius, self.cornerRadius)
	else
		love.graphics.setLineWidth(self.lineWidth)
		love.graphics.rectangle("line", self.x, self.y, self.width, self.height, self.cornerRadius, self.cornerRadius)
		love.graphics.setLineWidth(1)
	end
	
	love.graphics.setColor(r, g, b, a)
end