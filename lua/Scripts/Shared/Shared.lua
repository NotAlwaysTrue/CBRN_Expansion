activeCharge = { }

Hook.Add("roundStart()", "Drones.resettable", function()
    if activeCharge == nil then return end
    activeCharge = { }
end)

Hook.Add("character.death", "Drones.resetOndead", function(character)  --Reset on death
    if activeCharge == nil then return end
    for i,v in pairs(activeCharge) do
        if v == character then
            local light = i.GetComponentString("LightComponent")
            light.isOn = false
            i.remove()
        end
    end
end)

Hook.Add("item.use", "Drones.itemused", function(item, usingCharacter)
    if item == nil or  usingCharacter == nil then return end
    local identifier = item.Prefab.Identifier.Value
    local methodtorun = KACBRN.ItemMethods[identifier]
    if(methodtorun~=nil) then 
        methodtorun(item, usingCharacter)
        return
    end
end)

KACBRN.ItemMethods = {}

KACBRN.ItemMethods.m57detonator = function(item, usingCharacter)
    if usingCharacter == nil or activeCharge == nil then return end
    for i,v in pairs(activeCharge) do
        if v == usingCharacter then
            i.Condition = 0
        end
    end
end

KACBRN.ItemMethods.c4_stickcharge = function(item, usingCharacter)
    if usingCharacter == nil then return end
    item.AddTag(usingCharacter)
    activeCharge[item] = usingCharacter
    local light = item.GetComponentString("LightComponent")
    light.isOn = true
end