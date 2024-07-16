# ZoneVisual
Example code
```lua
local ZoneVisual = require(script.ZoneVisual)

local properties = {Color = Color3.new(0,1,0)}

local zone = ZoneVisual.new(script.Parent, 5, "Circle", properties)
--[[
or
local zone = ZoneVisual.new(script.Parent, 5, "Rectangle", properties)
]]

local tweenInfo = TweenInfo.new(1, 0, 0, -1, true)

zone:TweenTransparency(tweenInfo, 1)

task.wait(3)

zone:Pause()

task.wait(3)

zone:ChangeProperties({Transparency = 0})

task.wait(3)

zone:TweenColor(tweenInfo, Color3.new(1,0,0))

task.wait(3)

zone:Resume()
```
https://github.com/user-attachments/assets/62b2805f-c213-4dca-b034-3a15fe27dc42


```
  - ZoneVisual.new(part: BasePart, height: Number, zoneType: String, properties: Table)

  - ZoneVisual:ChangeProperties(properties: Table)
  - ZoneVisual:TweenColor(tweenInfo: TweenInfo, color: Color3)
  - ZoneVisual:TweenTransparency(tweenInfo: TweenInfo, number: Number)
  - ZoneVisual:Tween(tweenInfo: TweenInfo, properties: Table)
  - ZoneVisual:Pause()
  - ZoneVisual:Resume()
  - ZoneVisual:Cancel
  - ZoneVisual:Destroy()
  - ZoneVisual.getTweens(ZoneVisual)
```

Zone Types
- automatically takes the longest length of a basepart for a circle's radius
```
  - "Rectangle"
  - "Circle"
```
