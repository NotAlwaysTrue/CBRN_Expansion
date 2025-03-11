local inittickrateexec = 1
Hook.Add("think", "tick.GetTickRate", function()
	if GameTick == nil then GameTick = 0 end
	local now = math.floor(os.time())
	savetimeglobal(now, inittickrateexec)
	inittickrateexec = 0
	GameTick = GameTick + 1
	if now - 1 == mslinittime then
		GameTickRate = GameTick
		print(GameTick)
        GameTick = 0
		print(now)
		print(GameTickRate)
        inittickrateexec = 1
	end
end)
