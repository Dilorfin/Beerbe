local timer = {}
timer.__index = timer

function timer:setEndTime(endTime)
    self.endTime = endTime
end

function timer:update(dt)
    self.timeElapsed = self.timeElapsed + dt
end

function timer:isTime()
    return self.timeElapsed >= self.endTime
end

function timer:restart()
    self.timeElapsed = 0
end

function newTimer(endTime)
    local o = {}

    o.timeElapsed = 0
    o.endTime = endTime or 0

    return setmetatable(o, timer)
end
