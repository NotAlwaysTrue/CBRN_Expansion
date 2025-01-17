local zoom_init = false
local gzs_inti = false

local zoomSpeed=0.2
local zoomMin=0.15 -- minimum zoom modifier
local zoomMax=1.5 -- maximum zoom modifier
local zoomStart=1.5 -- default zoom level


local resetKey=Keys.Back -- reset zoom key

local zoomStart=math.max(math.min(zoomMax,zoomStart),zoomMin)
local gzsNew=zoomStart
local gzsMin=zoomMin
local gzsMax=zoomMax

local gzsDefaultinit
local gzsDefaultMin
local gzsDefaultMax


LuaUserData.MakeFieldAccessible(Descriptors["Barotrauma.Camera"],"globalZoomScale")
LuaUserData.MakeMethodAccessible(Descriptors["Barotrauma.Camera"],"CreateMatrices")

Hook.HookMethod("Barotrauma.Camera","CreateMatrices",function(instance,ptable)
    if not gzs_inti then
        gzsDefaultinit = instance.globalZoomScale
        gzs_inti = true
    end
	gzsDefaultMin=instance.MinZoom
	gzsDefaultMax=instance.MaxZoom
	gzsMin=math.min(zoomMin,gzsDefaultinit)
	gzsMax=math.max(zoomMax,gzsDefaultinit)
	gzsNew=math.max(math.min(gzsMax,gzsDefaultinit*zoomStart),gzsMin)
	instance.MinZoom=math.min(gzsMin/2,instance.MinZoom)
	instance.MaxZoom=math.max(gzsMax*2,instance.MaxZoom)
end,Hook.HookMethodType.After)

Hook.HookMethod("Barotrauma.Character","ControlLocalPlayer",function(instance,ptable)
    if not zoom_init then
        ptable.cam.CreateMatrices()
        zoom_init = true
    end
    if instance.SelectedItem and instance.SelectedItem.HasTag("GUIDENCE_SYSTEM") then
        if PlayerInput.ScrollWheelSpeed < 0 then
            gzsNew=math.max(gzsMin,gzsNew*(1-zoomSpeed))
        end
        if PlayerInput.ScrollWheelSpeed > 0 then
            gzsNew=math.min(gzsMax,gzsNew*(1+zoomSpeed))
        end
        if PlayerInput.KeyDown(resetKey) then
            gzsNew=gzsDefaultinit*zoomStart
        end
        ptable.cam.globalZoomScale = gzsNew or gzsDefaultinit
        Screen.Selected.Cam.OffsetAmount = math.max(1,(ptable.cam.globalZoomScale / zoomStart)) * 800
    else
        if gzsDefault then
            --this IS INTENTIONAL to remain blank
        else
            ptable.cam.globalZoomScale = gzsDefaultinit
        end
    end
end,Hook.HookMethodType.After)


--Original code by zomgtehderpy
--From communtiy mod https://steamcommunity.com/sharedfiles/filedetails/?id=2817020588
--Potentially conflict with original mod