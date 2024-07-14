local ZoneVisual = {}

function ZoneVisual.newSquare(part:BasePart, height: number, color:ColorSequence, lightEmission: number, lightInfluence: number, transparency:number, segments: number)
	if part == nil then
		error("No part selected")
	elseif not part:IsA("BasePart") then
		error('Selected "' .. part.Name .. '" is not a BasePart')
	end
	if height == nil then
		error("No height inputted")
	elseif height == 0 or height <= 0 then
		error("Height must be over 0")
	end
	
	local height = height*2
	local color = color or ColorSequence.new(Color3.new(1,1,1))
	local lightEmission = lightEmission or 0
	local lightInfluence = lightInfluence or 1
	if transparency ~= nil then
		transparency = NumberSequence.new(transparency)
	else
		transparency = NumberSequence.new(.5)
	end
	local segments = segments or 200
	local texture = "http://www.roblox.com/asset/?id=18153329100"

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

	for i,v in attachments do
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

	for i,v in beams do
		v.Parent = part
		v.Color = color
		v.Texture = texture
		v.Width0 = height
		v.Width1 = height
		v.Segments = segments
		v.LightEmission = lightEmission
		v.LightInfluence = lightInfluence
		v.Transparency = transparency
		v.TextureMode = Enum.TextureMode.Static
		v.TextureSpeed = 0
	end

	B1.Attachment0 = A1
	B1.Attachment1 = A2

	B2.Attachment0 = A2
	B2.Attachment1 = A3

	B3.Attachment0 = A3
	B3.Attachment1 = A4

	B4.Attachment0 = A4
	B4.Attachment1 = A1

	return beams
end

function ZoneVisual.newCircle(part:BasePart, height: number, color:ColorSequence, lightEmission: number, lightInfluence: number, transparency:number, segments: number)
	if part == nil then
		error("No part selected")
	elseif not part:IsA("BasePart") then
		error('Selected "' .. part.Name .. '" is not a BasePart')
	end
	if height == nil then
		error("No height inputted")
	elseif height == 0 or height <= 0 then
		error("Height must be over 0")
	end
	
	local height = height*2
	local color = color or ColorSequence.new(Color3.new(1,1,1))
	local lightEmission = lightEmission or 0
	local lightInfluence = lightInfluence or 1
	if transparency ~= nil then
		transparency = NumberSequence.new(transparency)
	else
		transparency = NumberSequence.new(.5)
	end
	local segments = segments or 200
	local texture = "http://www.roblox.com/asset/?id=18153329100"

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

	for i,v in attachments do
		v.Parent = part
	end

	A1.Position = Vector3.new(0, -y, radius)
	A2.Position = Vector3.new(0, -y, -radius)

	local B1 = Instance.new("Beam")
	local B2 = Instance.new("Beam")
	local beams = {}

	table.insert(beams, B1)
	table.insert(beams, B2)

	for i,v in beams do
		v.Parent = part
		v.Color = color
		v.Texture = texture
		v.Width0 = height
		v.Width1 = height
		v.Segments = segments
		v.LightEmission = lightEmission
		v.LightInfluence = lightInfluence
		v.Transparency = transparency
		v.TextureMode = Enum.TextureMode.Static
		v.TextureSpeed = 0
	end

	B1.Attachment0 = A1
	B1.Attachment1 = A2

	B2.Attachment0 = A2
	B2.Attachment1 = A1

	B1.CurveSize0 = curve1
	B1.CurveSize1 = curve2

	B2.CurveSize0 = curve2
	B2.CurveSize1 = curve1

end

return ZoneVisual