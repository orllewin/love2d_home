
require "Coracle/Views/view_utils"
require "Coracle/colour"

class('Image').extends()

function Image:init(path, x, y, scale)
	Image.super.init()
	
	self.path = path
	self.x = x
	self.y = y
	self.scale = scale
	
	self.image = love.graphics.newImage(path)
end

function Image:draw()
	love.graphics.draw(self.image, self.x, self.y, 0, self.scale, self.scale)
end