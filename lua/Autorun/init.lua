JZ_CBRN = {}
JZ_CBRN.Path = table.pack(...)[1]

dofile(JZ_CBRN.Path.."/lua/Scripts/Shared/Shared.lua")

if Game.IsMultiplayer then
	dofile(JZ_CBRN.Path.."/lua/Scripts/Shared/Shared.lua")
end

if CLIENT and Game.IsMultiplayer then
	--dofile(JZ_CBRN.Path.."/lua/Scripts/Client/HUD.lua")  --Unfinished GUI works
	dofile(JZ_CBRN.Path.."/lua/Scripts/Client/Client.lua")
end

if SERVER and Game.IsMultiplayer then
	dofile(JZ_CBRN.Path.."/lua/Scripts/Server/Server.lua")
end

if Game.IsSingleplayer then
	dofile(JZ_CBRN.Path.."/lua/Scripts/Client/SP.lua")
	--dofile(JZ_CBRN.Path.."/lua/Scripts/Client/HUD.lua")  --Unfinished GUI works
end