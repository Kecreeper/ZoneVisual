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

local function numSeq(instance: Instance, property: string, tweenInfo: TweenInfo, goal: number)
    local num = Instance.new("NumberValue")
    local tween = TweenService:Create(num, tweenInfo, {Value = goal})
    
    num.Changed:Connect(function()
        instance[property] = num.Value
    end)

    tween:Play()
    tween.Completed:Connect(function()
        num:Destroy()
    end)
    return tween
end

local function numSeq(instance: Instance, property: string, tweenInfo: TweenInfo, goal: Color3)
    local num = Instance.new("Color3Value")
    local tween = TweenService:Create(num, tweenInfo, {Value = goal})
    
    num.Changed:Connect(function()
        instance[property] = num.Value
    end)

    tween:Play()
    tween.Completed:Connect(function()
        num:Destroy()
    end)
    return tween
end

function Tweening.NumSeq(instance, tweenInfo, goal)
    local self = setmetatable({}, Tweening)
    self.type = "NumSeq"
    self.instance = instance
    self.tweenInfo = tweenInfo
    self.target = goal

    return self
end

function Tweening.ColorSeq(instance, tweenInfo, goal: Color3)
    local self = setmetatable({}, Tweening)
    self.type = "ColorSeq"
    self.instance = instance
    self.tweenInfo = tweenInfo
    self.target = goal

    return self
end

function Tweening:Tween()
    if self.type == "NumSeq" then
        -- tween numseq
    elseif self.type == "ColorSeq" then
        -- tween colorseq
    end
end

return Tweening