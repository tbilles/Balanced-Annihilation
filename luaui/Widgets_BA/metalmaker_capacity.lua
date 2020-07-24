local GetTeamUnitDefCount = Spring.GetTeamUnitDefCount
local glText = gl.Text

function widget:GetInfo()
return {
    name = "Metal maker capacity bar",
    desc = "This widget display the total energy consumption of all metal makers as a percentage of energy production.",
    author = "tbilles",
    date = "Jul 22, 2020",
    license = "Free",
    layer = 0,
    enabled = false
}
end

local metalMakerEnergyUsage = 0
local energyIncome = 0
local teamID

function widget:Initialize()
	teamID = Spring.GetMyTeamID()
end


function updateEnergyIncome()
	local currentLevel, storage, pull, income = Spring.GetTeamResources(teamID, "energy")
	energyIncome = income
end

function updateMetalMakers()
	local cormakr = GetTeamUnitDefCount(teamID, UnitDefNames["cormakr"].id) * 70
	local armmakr = GetTeamUnitDefCount(teamID, UnitDefNames["armmakr"].id) * 70
	local cormmkr = GetTeamUnitDefCount(teamID, UnitDefNames["cormmkr"].id) * 600
	local armmmkr = GetTeamUnitDefCount(teamID, UnitDefNames["armmmkr"].id) * 600
	metalMakerEnergyUsage = cormakr + cormmkr + armmakr + armmmkr
end

function widget:Update()
	if Spring.GetGameFrame() % 10 ~= 6 then
		return
	end
	
	updateMetalMakers();
	updateEnergyIncome();
end

function widget:DrawScreen()
		local maxx, maxy = Spring.GetViewGeometry()
		local percent = metalMakerEnergyUsage * 100 / energyIncome
		glText("Metal maker capacity: " .. string.format("%d", percent) .. "%", maxx-10, maxy-70, 16, "ro");
end
