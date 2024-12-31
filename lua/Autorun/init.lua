JZ_CBRN = {}
JZ_CBRN.Path = table.pack(...)[1]


if Game.IsMultiplayer then
	dofile(JZ_CBRN.Path.."/lua/Scripts/Shared/DronesShared.lua")
end

if SERVER then
	dofile(JZ_CBRN.Path.."/lua/Scripts/Shared/C4Shared.lua")
	dofile(JZ_CBRN.Path.."/lua/Scripts/Server/DroneServer.lua")
	dofile(JZ_CBRN.Path..'/lua/Scripts/Shared/MSL_GUIDE.lua')
end

if CLIENT and Game.IsMultiplayer then
	dofile(JZ_CBRN.Path.."/lua/Scripts/Client/DroneClient.lua")
end

if CLIENT then
	--dofile(JZ_CBRN.Path.."/lua/Scripts/Client/HUD.lua")  --Unfinished GUI works
	dofile(JZ_CBRN.Path .. '/lua/Scripts/Client/TurretZoom.lua')
end

if Game.IsSingleplayer then
	dofile(JZ_CBRN.Path.."/lua/Scripts/Shared/C4Shared.lua")
	dofile(JZ_CBRN.Path..'/lua/Scripts/Shared/MSL_GUIDE.lua')
	dofile(JZ_CBRN.Path.."/lua/Scripts/Client/DroneSP.lua")
end