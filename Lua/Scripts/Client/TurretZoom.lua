local zoomSpeed=0.2
local zoomMin=0.15 -- minimum zoom modifier
local zoomMax=1.5 -- maximum zoom modifier
local zoomStart=1.5 -- default zoom level

local zoomStart=math.max(math.min(zoomMax,zoomStart),zoomMin)
local ZoomNew=zoomStart


LuaUserData.MakeFieldAccessible(Descriptors["Barotrauma.Camera"],"globalZoomScale")

Hook.HookMethod("Barotrauma.Character","ControlLocalPlayer",function(instance,ptable)
    if instance.SelectedItem and instance.SelectedItem.HasTag("GUIDENCE_SYSTEM") then
        if PlayerInput.ScrollWheelSpeed < 0 then
            ZoomNew=math.max(zoomMin,ZoomNew*(1-zoomSpeed))
        end
        if PlayerInput.ScrollWheelSpeed > 0 then
            ZoomNew=math.min(zoomMax,ZoomNew*(1+zoomSpeed))
        end
        ptable.cam.globalZoomScale = ZoomNew
        Screen.Selected.Cam.OffsetAmount = math.max(1,(ptable.cam.globalZoomScale / zoomStart)) * 800
    end
end,Hook.HookMethodType.After)

Hook.HookMethod("Barotrauma.Character","ControlLocalPlayer",function(instance,ptable)
    if instance.SelectedItem and instance.SelectedItem.HasTag("GUIDENCE_SYSTEM") then
        if ptable.cam.globalZoomScale ~= ZoomNew then
            print("\n WARNING: MOD CONFLICT DETECTED, AFCS SCOPE MALFUNCTION!")
            print("PLEASE CHECK YOUR MODLIST! \n")
        end
    end
end,Hook.HookMethodType.After)


--Original code by zomgtehderpy
--From communtiy mod https://steamcommunity.com/sharedfiles/filedetails/?id=2817020588
--Potentially conflict with original mod