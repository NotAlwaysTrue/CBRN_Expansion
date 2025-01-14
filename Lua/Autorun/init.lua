JZ_CBRN = {}
JZ_CBRN.Path = table.pack(...)[1]


if Game.IsMultiplayer then
	dofile(JZ_CBRN.Path.."/Lua/Scripts/Shared/DronesShared.lua")
end

if SERVER then
	dofile(JZ_CBRN.Path.."/Lua/Scripts/Shared/C4Shared.lua")
	dofile(JZ_CBRN.Path.."/Lua/Scripts/Server/DroneServer.lua")
	dofile(JZ_CBRN.Path..'/Lua/Scripts/Shared/MSL_GUIDE.lua')
	GameTickRate = Game.ServerSettings.TickRate
end

if CLIENT and Game.IsMultiplayer then
	dofile(JZ_CBRN.Path.."/Lua/Scripts/Client/DroneClient.lua")
end

if CLIENT then
	--dofile(JZ_CBRN.Path.."/Lua/Scripts/Client/HUD.lua")  --Unfinished GUI works
	dofile(JZ_CBRN.Path..'/Lua/Scripts/Client/TurretZoom.lua')
	GameTickRate = 60
end

if Game.IsSingleplayer then
	dofile(JZ_CBRN.Path.."/Lua/Scripts/Shared/C4Shared.lua")
	dofile(JZ_CBRN.Path..'/Lua/Scripts/Shared/MSL_GUIDE.lua')
	dofile(JZ_CBRN.Path.."/Lua/Scripts/Client/DroneSP.lua")
end
