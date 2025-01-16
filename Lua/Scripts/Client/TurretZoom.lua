local zoom_init = false

local zoomSpeed=0.02
local zoomMin=0.01 -- minimum zoom modifier
local zoomMax=2.5 -- maximum zoom modifier
local zoomStart=1.5 -- default zoom level


local resetKey=Keys.Back -- reset zoom key

local zoomStart=math.max(math.min(zoomMax,zoomStart),zoomMin)
local globalzoomNew=zoomStart
local globalzoomMin=zoomMin
local globalzoomMax=zoomMax

local globalzoomDefault
local globalzoomDefaultMin
local globalzoomDefaultMax


LuaUserData.MakeFieldAccessible(Descriptors["Barotrauma.Camera"],"globalZoomScale")
LuaUserData.MakeMethodAccessible(Descriptors["Barotrauma.Camera"],"CreateMatrices")

Hook.HookMethod("Barotrauma.Camera","CreateMatrices",function(instance,ptable)
	globalzoomDefault=instance.globalZoomScale
	globalzoomDefaultMin=instance.MinZoom
	globalzoomDefaultMax=instance.MaxZoom
	globalzoomMin=math.max(zoomMin,globalzoomDefault*zoomMin)
	globalzoomMax=math.min(zoomMax,globalzoomDefault*zoomMax)
	globalzoomNew=math.max(math.min(globalzoomMax,globalzoomDefault*zoomStart),globalzoomMin)
	instance.MinZoom=math.min(globalzoomMin/2,instance.MinZoom)
	instance.MaxZoom=math.max(globalzoomMax*2,instance.MaxZoom)
end,Hook.HookMethodType.After)

Hook.HookMethod("Barotrauma.Character","ControlLocalPlayer",function(instance,ptable)
    if not zoom_init then
        ptable.cam.CreateMatrices()
        zoom_init = true
    end
    if instance.SelectedItem and instance.SelectedItem.HasTag("GUIDENCE_SYSTEM") then
        if PlayerInput.ScrollWheelSpeed < 0 then
            globalzoomNew=math.max(globalzoomMin,globalzoomNew*(1-zoomSpeed))
        end
        if PlayerInput.ScrollWheelSpeed > 0 then
            globalzoomNew=math.min(globalzoomMax,globalzoomNew*(1+zoomSpeed))
        end
        if PlayerInput.KeyDown(resetKey) then
            globalzoomNew=globalzoomDefault*zoomStart
        end
        ptable.cam.globalZoomScale = globalzoomNew or globalzoomDefault
    else
        ptable.cam.globalZoomScale = globalzoomDefault --reset to def
    end
end,Hook.HookMethodType.After)


--Original code by zomgtehderpy
--From communtiy mod https://steamcommunity.com/sharedfiles/filedetails/?id=2817020588
--May conflict with original mod