--# selene: allow(shadowing)

local Tweening = {}
Tweening.__index = Tweening

local TweenService = game:GetService("TweenService")

-- from roblox documentation on NumberSequence
local function evalNumberSequence(sequence: NumberSequence, time: number)
    -- If time is 0 or 1, return the first or last value respectively
    if time == 0 then
        return sequence.Keypoints[1].Value
    elseif time == 1 then
        return sequence.Keypoints[#sequence.Keypoints].Value
    end

    -- Otherwise, step through each sequential pair of keypoints
    for i = 1, #sequence.Keypoints - 1 do
        local currKeypoint = sequence.Keypoints[i]
        local nextKeypoint = sequence.Keypoints[i + 1]
        if time >= currKeypoint.Time and time < nextKeypoint.Time then
            -- Calculate how far alpha lies between the points
            local alpha = (time - currKeypoint.Time) / (nextKeypoint.Time - currKeypoint.Time)
            -- Return the value between the points using alpha
            return currKeypoint.Value + (nextKeypoint.Value - currKeypoint.Value) * alpha
        end
    end
end
-- from roblox documentation on ColorSequence
local function evalColorSequence(sequence: ColorSequence, time: number)
    -- If time is 0 or 1, return the first or last value respectively
    if time == 0 then
        return sequence.Keypoints[1].Value
    elseif time == 1 then
        return sequence.Keypoints[#sequence.Keypoints].Value
    end

    -- Otherwise, step through each sequential pair of keypoints
    for i = 1, #sequence.Keypoints - 1 do
        local thisKeypoint = sequence.Keypoints[i]
        local nextKeypoint = sequence.Keypoints[i + 1]
        if time >= thisKeypoint.Time and time < nextKeypoint.Time then
            -- Calculate how far alpha lies between the points
            local alpha = (time - thisKeypoint.Time) / (nextKeypoint.Time - thisKeypoint.Time)
            -- Evaluate the real value between the points using alpha
            return Color3.new(
                (nextKeypoint.Value.R - thisKeypoint.Value.R) * alpha + thisKeypoint.Value.R,
                (nextKeypoint.Value.G - thisKeypoint.Value.G) * alpha + thisKeypoint.Value.G,
                (nextKeypoint.Value.B - thisKeypoint.Value.B) * alpha + thisKeypoint.Value.B
            )
        end
    end
end

local function tweenNumSeq(self)
    local instance = self.instance
    local tweenInfo = self.tweenInfo
    local goal = self.goal

    local property, goal = next(goal, nil)

    local num = Instance.new("NumberValue")
    num.Value = evalNumberSequence(instance[property], 0)
    local tween = TweenService:Create(num, tweenInfo, {Value = goal})
    
    num.Changed:Connect(function()
        instance[property] = NumberSequence.new(num.Value)
    end)

    tween:Play()
    tween.Completed:Connect(function()
        num:Destroy()
    end)
    return tween
end

local function tweenColorSeq(self)
    local instance = self.instance
    local tweenInfo = self.tweenInfo
    local goal = self.goal

    local property, goal = next(goal, nil)

    local clr = Instance.new("Color3Value")
    clr.Value = evalColorSequence(instance[property], 0)
    local tween = TweenService:Create(clr, tweenInfo, {Value = goal})
    
    clr.Changed:Connect(function()
        instance[property] = ColorSequence.new(clr.Value)
    end)

    tween:Play()
    tween.Completed:Connect(function()
        clr:Destroy()
    end)
    return tween
end

function Tweening.NumSeq(instance: Instance, tweenInfo: TweenInfo, goal: table)
    local self = setmetatable({}, Tweening)
    self.type = "NumSeq"
    self.instance = instance
    self.tweenInfo = tweenInfo
    self.goal = goal

    return self
end

function Tweening.ColorSeq(instance: Instance, tweenInfo: TweenInfo, goal: table)
    local self = setmetatable({}, Tweening)
    self.type = "ColorSeq"
    self.instance = instance
    self.tweenInfo = tweenInfo
    self.goal = goal

    return self
end

function Tweening:Play()
    if self.realtween then
        self.realtween:Play()
    else
        if self.type == "NumSeq" then
            local tween = tweenNumSeq(self)
            self.realtween = tween
        elseif self.type == "ColorSeq" then
            local tween = tweenColorSeq(self)
            self.realtween = tween
        end
    end
end

function Tweening:Pause()
    self.realtween:Cancel()
end

function Tweening:Cancel()
    self.realtween:Cancel()
end

return Tweening