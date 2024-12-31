Hook.Patch("Barotrauma.Character", "ControlLocalPlayer", function(instance, ptable)
    if not instance then return end
    
	-- todo: only zoom out when the character is guiding a missile
    if instance.SelectedItem and instance.SelectedItem.HasTag("periscope") and instance.SelectedItem.HasTag("GUIDENCE_SYSTEM") then
		Screen.Selected.Cam.MinZoom = 0.08
        Screen.Selected.Cam.OffsetAmount = 2500
    end
end, Hook.HookMethodType.After)