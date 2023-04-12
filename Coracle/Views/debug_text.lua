--[[
	
todo - a multiline text view, 15 lines in a table, when 15 are populated new entries pop the oldest off the stack.
	
]]--

require "Coracle/Views/view_utils"
require "Coracle/colour"

class('DebugText').extends()

function DebugText:init(x, y, colour)
	DebugText.super.init()
	
	self.x = x
	self.y = y
	
	self.lines = {}
	
	if colour ~= nil then
		self.colour = rgb(colour)
	else
		self.colour = white()
	end
	
	self.fontHeight = love.graphics.getFont():getHeight()
end

function DebugText:getTime()
	local now = os.date('*t')
	return "" .. now.hour .. ":" .. now.min .. ":" .. now.sec
end

function DebugText:add(line)
	table.insert(self.lines, 1, self:getTime() .. " - " .. line)
	
	if #self.lines > 15 then
		table.remove(self.lines, 16)
	end
end

function DebugText:draw()
	local r, g, b, a = love.graphics.getColor()
	love.graphics.setColor(self.colour)
	
	for i=1,#self.lines do
		local line = self.lines[i]
		local y = self.y + (i * (self.fontHeight + 6))
		love.graphics.print(line, self.x, y)
	end

	love.graphics.setColor(r, g, b, a)
end