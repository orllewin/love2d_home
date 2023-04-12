--[[
	
	A container to manage timers.
	
]]--
class('Timers').extends()

function Timers:init()
	Timers.super.init()
	
	self.children = {}
	
end

function Timers:add(timer)
	table.insert(self.children, timer)
end

function Timers:start(tag)
	for i=1,#self.children do
		if self.children[i]:getTag() == tag then
			self.children[i]:start()
			break
		end
	end
end

function Timers:cancel(tag)
	for i=1,#self.children do
		if self.children[i]:getTag() == tag then
			table.remove(self.children, i)
			break
		end
	end
end

function Timers:update(deltaSeconds)
	for i=1,#self.children do
		self.children[i]:update(deltaSeconds)
		if self.children[i]:isFinished() then
			self:cancel(self.children[i]:getTag())
		end
	end
end