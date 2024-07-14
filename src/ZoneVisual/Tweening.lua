local Tweening = {}
Tweening.__index = Tweening

local TweenService = game:GetService("TweenService")

local function numSeq()

end

function Tweening.NumSeq(instances, tweenInfo, numSeq)
    local self = setmetatable({}, Tweening)
    self.instances = {}
end

function Tweening.ColorSeq()
    local self = setmetatable({}, Tweening)
    self.instances = {}
end

return Tweening