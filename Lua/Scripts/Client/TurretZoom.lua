Hook.Patch("Barotrauma.Character", "ControlLocalPlayer", function(instance, ptable)
    if not instance then return end

    if instance.SelectedItem and instance.SelectedItem.HasTag("GUIDENCE_SYSTEM") then --
		Screen.Selected.Cam.MinZoom = 0.05
        Screen.Selected.Cam.OffsetAmount = 8000
    end
end, Hook.HookMethodType.After)

