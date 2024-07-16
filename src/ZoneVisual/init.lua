--# selene: allow(shadowing)

local ZoneVisual = {}
ZoneVisual.__index = ZoneVisual

--------------services
local TweenService = game:GetService("TweenService")
local Tweening = require(script.Tweening)
----------------------

---------------------------- local functions
local function checkColor(color: ColorSequence | Color3)
	if typeof(color) == "Color3" then
		color = ColorSequence.new(color)
	end

	return color
end

local function checkTransparency(transparency: NumberSequence | number)
	if type(transparency) == "number" then
		transparency = NumberSequence.new(transparency)
	end

	return transparency
end

local function checkProperties(properties: table): table
	if properties["Color"] then
		properties["Color"] = checkColor(properties["Color"])
	end
	if properties["Transparency"] then
		properties["Transparency"] = checkTransparency(properties["Transparency"])
	end

	return properties
end
-----------------------------------------------

--------module---------
function ZoneVisual.newSquare(part:BasePart, height: number, properties: table)
	if part == nil then
		error("No part inputted")
	elseif not part:IsA("BasePart") then
		error('Inputted "' .. part.Name .. '" is not a BasePart')
	end

	if height == nil then
		error("No height inputted")
	elseif height == 0 or height <= 0 then
		error("Height must be over 0")
	end

	local height = height*2

	local x = part.Size.X/2
	local y = part.Size.Y/2
	local z = part.Size.Z/2

	local A1 = Instance.new("Attachment")
	local A2 = Instance.new("Attachment")
	local A3 = Instance.new("Attachment")
	local A4 = Instance.new("Attachment")
	local attachments = {}

	table.insert(attachments, A1)
	table.insert(attachments, A2)
	table.insert(attachments, A3)
	table.insert(attachments, A4)

	for _,v in attachments do
		v.Parent = part
	end

	A1.Position = Vector3.new(x,-y,z)
	A2.Position = Vector3.new(-x,-y,z)
	A3.Position = Vector3.new(-x,-y,-z)
	A4.Position = Vector3.new(x,-y,-z)

	local B1 = Instance.new("Beam")
	local B2 = Instance.new("Beam")
	local B3 = Instance.new("Beam")
	local B4 = Instance.new("Beam")
	local beams = {}

	table.insert(beams, B1)
	table.insert(beams, B2)
	table.insert(beams, B3)
	table.insert(beams, B4)

	for _,v: Beam in beams do
		v.Parent = part
		v.Width0 = height
		v.Width1 = height
		v.Segments = 200
		v.Texture = "http://www.roblox.com/asset/?id=18153329100"
		v.TextureMode = Enum.TextureMode.Static
		v.TextureSpeed = 0
	end

	if properties then
		properties = checkProperties(properties)
		for i,v in properties do
			for _,beam in beams do
				beam[i] = v
			end
		end
	end

	B1.Attachment0 = A1
	B1.Attachment1 = A2

	B2.Attachment0 = A2
	B2.Attachment1 = A3

	B3.Attachment0 = A3
	B3.Attachment1 = A4

	B4.Attachment0 = A4
	B4.Attachment1 = A1

	local self = setmetatable({}, ZoneVisual)
	self.beams = beams
	self.tweens = {}

	print(self)
	return self
end

function ZoneVisual:Destroy()
	for _,v in self.beams do
		v:Destroy()
	end
	for _,v in self.tweens do
		v:Destroy()
	end
end

function ZoneVisual:Tween(tweenInfo: TweenInfo, properties: table)
	for _,v in self.beams do
		local tween = TweenService:Create(v, tweenInfo, properties)
		table.insert(self.beams, tween)
		tween:Play()
	end
end

function ZoneVisual:Cancel()
	for _,v in self.tweens do
		v:Cancel()
	end
end

function ZoneVisual:Pause()
	for _,v in self.tweens do
		v:Pause()
	end
end

function ZoneVisual:Resume()
	if self.tweens then
		for _,v in self.tweens do
			v:Play()
		end
	end
end

function ZoneVisual.getTweens(zone)
	return zone.tweens
end

function ZoneVisual:TweenColor(tweenInfo: TweenInfo, color: Color3)
	for _,v in self.beams do
		local tween = Tweening.ColorSeq(v, tweenInfo, {Color = color})
		table.insert(self.tweens, tween)
		tween:Play()
	end
end

function ZoneVisual:TweenTransparency()

end

function ZoneVisual.newCircle(part:BasePart, height: number, properties: table)
	if part == nil then
		error("No part inputted")
	elseif not part:IsA("BasePart") then
		error('Inputted "' .. part.Name .. '" is not a BasePart')
	end

	if height == nil then
		error("No height inputted")
	elseif height == 0 or height <= 0 then
		error("Height must be over 0")
	end
	
	local height = height*2

	local x = part.Size.X/2
	local y = part.Size.Y/2
	local z = part.Size.Z/2
	local radius
	if x > z then
		radius = x
	elseif z > x then
		radius = z
	elseif x == z then
		radius = x or z
	end

	local curve1 = (radius*4)/3
	local curve2 = (-radius*4)/3

	local A1 = Instance.new("Attachment")
	local A2 = Instance.new("Attachment")
	local attachments = {}

	table.insert(attachments, A1)
	table.insert(attachments, A2)

	for _,v in attachments do
		v.Parent = part
	end

	A1.Position = Vector3.new(0, -y, radius)
	A2.Position = Vector3.new(0, -y, -radius)

	local B1 = Instance.new("Beam")
	local B2 = Instance.new("Beam")
	local beams = {}

	table.insert(beams, B1)
	table.insert(beams, B2)

	for _,v: Beam in beams do
		v.Parent = part
		v.Width0 = height
		v.Width1 = height
		v.Segments = 200
		v.Texture = "http://www.roblox.com/asset/?id=18153329100"
		v.TextureMode = Enum.TextureMode.Static
		v.TextureSpeed = 0
	end

	if properties then
		properties = checkProperties(properties)
		for i,v in properties do
			for _,beam in beams do
				beam[i] = v
			end
		end
	end

	B1.Attachment0 = A1
	B1.Attachment1 = A2

	B2.Attachment0 = A2
	B2.Attachment1 = A1

	B1.CurveSize0 = curve1
	B1.CurveSize1 = curve2

	B2.CurveSize0 = curve2
	B2.CurveSize1 = curve1

	local self = setmetatable({}, ZoneVisual)
	self.beams = beams
	self.tweens = {}

	return self
end
-----------------------

return ZoneVisual