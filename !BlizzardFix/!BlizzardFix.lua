local L = {}

if (UNIT_ATTACK_SPEED_PATCH_VERSION or 0) < 1 then
	UNIT_ATTACK_SPEED_PATCH_VERSION = 1
	
	local frame = CreateFrame("Frame")
	local timeElapsed = 0
	local mainSpeed, offSpeed
	local event = "UNIT_ATTACK_SPEED"
	frame:HookScript("OnUpdate", function(self, elapsed)
		timeElapsed = timeElapsed + elapsed
		if timeElapsed > 0.02 then
			timeElapsed = 0
			local main, off = UnitAttackSpeed("unit")
			if main ~= mainSpeed or off ~= offSpeed then
				mainSpeed = main
				offSpeed = off
				local triggers = {GetFramesRegisteredForEvent("UNIT_ATTACK_SPEED")}
				for _,f in pairs(triggers) do 
					local t = {f=f}
					if not issecurevariable(t, "f") then
						local scr = f.GetScript("OnEvent")
						if scr then 
							scr(f, "UNIT_ATTACK_SPEED")
						end
					end
				end
			end
		end
	end)
end


