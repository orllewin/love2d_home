--[[
	

	
]]--

require "Coracle/Views/view_utils"
require "Coracle/colour"

class('ImageButton').extends()

function ImageButton:init(path, x, y, onClick)
	ImageButton.super.init()
	
	self.imagePath = imagePath
	self.x = x
	self.y = y
	self.onClick = onClick
	
	self.yOffset = 0
	
	self.image = love.graphics.newImage(path)
	self.width = self.image:getWidth()
	self.height = self.image:getHeight()
end

function ImageButton:contains(x, y)
	return inBounds(x, y, self.x, self.y, self.width, self.height)
end

function ImageButton:clickDown()
	self.yOffset = 3
end

function ImageButton:clickUp()
	self.yOffset = 0
	if self.onClick ~= nil then self.onClick() end
end

function ImageButton:draw()
	love.graphics.draw(self.image, self.x, self.y + self.yOffset)
end