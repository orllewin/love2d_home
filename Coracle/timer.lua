--[[
	

	
]]--
class('Timer').extends()

function Timer:init(tag, durationMs, onFinished)
	Timer.super.init()
	
	self.tag = tag
	self.durationMs = durationMs
	self.onFinished = onFinished
	self.started = false
	self.finished = false
	self.elapsed = 0
	
end

function Timer:getTag()
	return self.tag
end

function Timer:start()
	self.started = true
end

function Timer:isStarted()
	return self.started
end

function Timer:isFinished()
	return self.finished
end

function Timer:update(deltaTime)
	if self.started == false then return end
	
	local deltaMs = deltaTime*1000
	
	self.elapsed = self.elapsed + deltaMs
	
	if self.elapsed >= self.durationMs then
		
		if self.onFinished ~= nil then self.onFinished() end
		self.finished = true
	end
end