LuaUserData.MakeFieldAccessible(Descriptors["Barotrauma.StatusEffect"],"user")
activeCharge = { }
Controllers = { }

--Hook Part

Hook.Add("roundEnd", "Charge.resetonend", function() --Endround reset
    for i,v in pairs(activeCharge) do
        local light = i.GetComponentString("LightComponent")
        light.isOn = false
    end
    activeCharge = { }
end)

Hook.Add("character.death", "Charge.resetOndead", function(character)  --Reset on death
    if activeCharge == nil or character == nil then return end
    for i,v in pairs(activeCharge) do
        if v == character then
            local light = i.GetComponentString("LightComponent")
            light.isOn = false
            activeCharge[i] = nil
        end
    end
end)

Hook.Add("item.use", "Charge.itemused", function(item, usingCharacter)
    if item == nil or  usingCharacter == nil then return end
    local identifier = item.Prefab.Identifier.Value
    local methodtorun = JZ_CBRN.ItemMethods[identifier]
    if(methodtorun~=nil) then 
        methodtorun(item, usingCharacter)
        return
    end
end)

Hook.Add("Drone.control", "Drone.control", function(effect, deltaTime, item, targets, worldPosition)
    if targets == nil then return end
    local targetCharacter = targets[1]
    if targetCharacter == nil or targetCharacter.IsPlayer or tostring(targetCharacter.SpeciesName) ~= "Cbrn_mech" then return end
    if effect.type == ActionType.OnUse then
        if SERVER then
            local usingCharacter = effect.user
            local usingclient = Util.FindClientCharacter(usingCharacter)
            if usingCharacter == nil or usingclient == nil then return end
            if not targetCharacter.IsFriendly(usingCharacter) then
                local message = Networking.Start("notallowed")
                message.WriteString(true)
                Networking.Send(message, usingclient.Connection)
                return
            end
            Controllers[usingclient] = usingCharacter
            usingclient.SetClientCharacter(targetCharacter)
            local message = Networking.Start("user")
            message.WriteString(tostring(usingCharacter.ID))
            Networking.Send(message, usingclient.Connection)
        end
        if CLIENT then
            charCurrentControlling = targetCharacter
            controlling = true
        end
    end
end)

--Item Method

JZ_CBRN.ItemMethods = {}

JZ_CBRN.ItemMethods.m57detonator = function(item, usingCharacter)
    if usingCharacter == nil or activeCharge == nil then return end
    for i,v in pairs(activeCharge) do
        if v == usingCharacter then
            i.Condition = 0
            activeCharge[i] = nil
        end
    end
end

JZ_CBRN.ItemMethods.c4_stickcharge = function(item, usingCharacter)
    if usingCharacter == nil then return end
    activeCharge[item] = usingCharacter
    local light = item.GetComponentString("LightComponent")
    light.isOn = true
end