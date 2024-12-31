LuaUserData.MakeFieldAccessible(Descriptors["Barotrauma.Items.Components.Turret"], "targetRotation")
--init

-- Steer the missile towards the direction the cursor is pointing at, smaller num means the msl will try harder to follow cursor
-- In this way the cursor works as a rangefinder
local MAX_STEERING_FORCE = 0.02
-- Correct the missile flying path towards the LOS , smaller num means the msl how hard the msl will try to go to LOS
local MAX_CORRECTION_FORCE = 0.7
-- Accelerate the missile in its current direction
local MAX_PROPULSION_FORCE = 0.13

local Missile = {}
Missile.__index = Missile

-- helpfunc

function Missile:getMissile(item, user, Launcher, isTurretLaunched)
    local data = {}
    setmetatable(data, Missile)
	data.item = item
	data.launcher = Launcher
	data.user = user
	data.launchItem = user.SelectedItem
	data.isTurretLaunched = isTurretLaunched
	data.isDead = false
    return data
end

local function sign(value)
	if value > 0 then return 1 end
	if value < 0 then return -1 end
	return 0
end
local function lerp(initval, endval, t)
	return initval + (endval - initval) * t
end
local function clamp(value, min, max)
	if value < min then return min end
	if value > max then return max end
	return value
end
local function radToVec(rad)
	return Vector2(math.cos(rad), math.sin(rad))
end
local function getDirection(vector)
	return math.atan2(vector.Y, vector.X)
end
local function checklenth(l, max)
	if max > l then return 0 end
	return l
end

local ActiveMissiles = {}

Hook.Patch("Barotrauma.Items.Components.Projectile", "Launch",function(instance,ptable)
	local projectile = instance.item
	if projectile == nil or not projectile.HasTag("saclosmsl") then return end
	local user = ptable["user"]
	if user == nil then return end
	local newMissile = Missile:getMissile(projectile, user, instance.Launcher, false)
	table.insert(ActiveMissiles, newMissile)
end,Hook.HookMethodType.After)--Add projectile to upd table when launched, for handholds
-- Very fair, turret launch doesn't counts for projectile launch :)

Hook.Patch("Barotrauma.Items.Components.Turret", "Launch", function(instance,ptable)
	local projectile = ptable["projectile"]
	if projectile == nil or not projectile.HasTag("saclosmsl") then return end
	local user = ptable["user"]
	if user == nil then return end
	local newMissile = Missile:getMissile(projectile, user, instance, true)
	table.insert(ActiveMissiles, newMissile)
end,Hook.HookMethodType.After)--Add projectile to upd table when launched, for turrets

Hook.Add("item.removed", "CBRN_SACLOS_RemoveMissile", function(item)
	if not item.HasTag("saclosmsl") then return end
	for index, value in pairs(ActiveMissiles) do
		if value == item then
			table.remove(ActiveMissiles, index)
			break
		end
	end
end)--Remove projectile from upd table when it is removed

Hook.Patch("Barotrauma.Item", "ApplyWaterForces", function(instance,ptable)
	if instance.HasTag("saclosmsl") then
		ptable.PreventExecution = false --Should water resistance work or not, recommended to set to false to enable resistance, so that the missle looks really flying in water
		return
	end
end)--Water Drag, will follow missile config

Hook.Patch("Barotrauma.Items.Components.Projectile", "Use", {"Barotrauma.Character", "System.Single"}, function(instance,ptable)
	if instance.item.HasTag("saclosmsl") then
		ptable["launchImpulseModifier"] = Single(10)--Launch velocity of missle
		return
	end
end)


-- todo: Lost LOS when LOS was cut off by something
Hook.Add("think", "CBRN_SACLOS_Guide", function ()
	if CLIENT and Game.Paused then return end
	if Game.GameSession == nil then return end
	
    for missile in ActiveMissiles do
		if not missile.item.removed and not missile.isDead then
			--Turrets will not lost LOS since it is stationary
			--Handholds may lost LOS due to weapon dir change
			missileVelocity = missile.item.body.LinearVelocity
			missileDirection = getDirection(missileVelocity)

			if missile.isTurretLaunched then
				WeaponDirection = missile.launcher.targetRotation
			else
				WeaponDirection = missile.launcher.Rotation
			end
			--math works related to weapon directions
			WeaponDirection = sign(WeaponDirection) * ( math.pi - math.abs(WeaponDirection))
			WeaponDirection = WeaponDirection - math.floor(WeaponDirection / 2.0 / math.pi) * 2.0 * math.pi - math.pi

			steeringForce = (radToVec(WeaponDirection) - radToVec(missileDirection)) / 0.05 * MAX_STEERING_FORCE
			--smaller num means less maneuver closer to LOS center

			missilePosition = missile.item.WorldPosition
			WeaponPosition = missile.launcher.item.WorldPosition
			WeaponDirectionVector = radToVec(WeaponDirection)
			closestPointOnLOS = WeaponPosition + Vector2.dot(missilePosition - WeaponPosition, WeaponDirectionVector) * WeaponDirectionVector
			correctionDirection = Vector2.Normalize(closestPointOnLOS - missilePosition)

			correctionMagnitude = lerp(0, MAX_CORRECTION_FORCE, clamp((closestPointOnLOS - missilePosition).Length() / (1000 * 3.5), 0, 0.8))
			--Larger multiplier means less force, means a softer curve

			correctionForce = correctionDirection * correctionMagnitude

			--propulsion force
			propulsionForce = radToVec(missileDirection) * MAX_PROPULSION_FORCE

			missile.item.body.ApplyLinearImpulse(steeringForce + correctionForce + propulsionForce)
				
			-- missle visual turning
			bodyDirection = missile.item.body.TransformedRotation
			bodyDirection = bodyDirection - math.floor((bodyDirection + math.pi)/ 2.0 / math.pi) * 2.0 * math.pi
			turnMagnitude = (radToVec(missileDirection) - radToVec(bodyDirection)).Length() * 0.1
			bodyDirectionVector = radToVec(bodyDirection)
			turnDirection = sign(bodyDirectionVector.X * missileVelocity.Y - bodyDirectionVector.Y * missileVelocity.X) -- cross product
			missile.item.body.ApplyTorque(turnMagnitude * turnDirection)
			missile.item.body.SmoothRotate(missileDirection, 100, true)

			end
		end
end)


-- Original Code created by 4SunnyH