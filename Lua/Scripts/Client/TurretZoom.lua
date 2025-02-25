local zoomSpeed=0.2
local zoomMin_c=0.075 -- minimum zoom modifier
local zoomMin=0.15
local zoomMax=1.5 -- maximum zoom modifier
local zoomStart=1.5 -- default zoom level
local modconflict=false

local gzs_inti = false
local gzsDefaultinit = 1.5

local zoomStart=math.max(math.min(zoomMax,zoomStart),zoomMin)
local ZoomNew=zoomStart


LuaUserData.MakeFieldAccessible(Descriptors["Barotrauma.Camera"],"globalZoomScale")
LuaUserData.MakeMethodAccessible(Descriptors["Barotrauma.Camera"],"CreateMatrices")

Hook.HookMethod("Barotrauma.Camera","CreateMatrices",function(instance,ptable)
    if not gzs_inti then
        gzsDefaultinit = instance.globalZoomScale
        gzs_inti = true
    end
end,Hook.HookMethodType.After)

Hook.HookMethod("Barotrauma.Character","ControlLocalPlayer",function(instance,ptable)
    if false and instance.SelectedItem and instance.SelectedItem.HasTag("GUIDENCE_SYSTEM") then --disabled
        if PlayerInput.ScrollWheelSpeed < 0 then
            ZoomNew=math.max(zoomMin,ZoomNew*(1-zoomSpeed))
        end
        if PlayerInput.ScrollWheelSpeed > 0 then
            ZoomNew=math.min(zoomMax,ZoomNew*(1+zoomSpeed))
        end
        ptable.cam.globalZoomScale = ZoomNew
        Screen.Selected.Cam.OffsetAmount = math.max(1,(ptable.cam.globalZoomScale / zoomStart)) * 800
    end
    if instance.SelectedItem and instance.SelectedItem.HasTag("GUIDENCE_SYSTEM") then
        if PlayerInput.ScrollWheelSpeed < 0 then
            ZoomNew=math.max(zoomMin_c,ZoomNew*(1-zoomSpeed))
        end
        if PlayerInput.ScrollWheelSpeed > 0 then
            ZoomNew=math.min(zoomMax,ZoomNew*(1+zoomSpeed))
        end
        Screen.Selected.Cam.MinZoom = ZoomNew
        Screen.Selected.Cam.OffsetAmount = math.max(1,(ptable.cam.globalZoomScale / zoomStart)) * 3000
    end
end,Hook.HookMethodType.After)


--Original code by zomgtehderpy
--From communtiy mod https://steamcommunity.com/sharedfiles/filedetails/?id=2817020588
--Potentially conflict with original mod