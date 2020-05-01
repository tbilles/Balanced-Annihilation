TaskQueueBehaviour = class(Behaviour)

function TaskQueueBehaviour:Init()
	self.active = false
	u = self.unit
	u = u:Internal()
	self.name = u:Name()
	self.countdown = 0
	if self:HasQueues() then
		self.queue = self:GetQueue()
	end

	self.waiting = {}
	self:OnToNextTask()
	self.inactive_since = nil;

end

function dump(o)
	if type(o) == 'table' then
		local s = '{ '
		for k,v in pairs(o) do
			if type(k) ~= 'number' then
				k = '"'..k..'"'
			end
			s = s .. '['..k..'] = ' .. dump(v) .. ','
		end
		return s .. '} '
	else
		return tostring(o)
	end
end

function TaskQueueBehaviour:Name()
	return "TaskQueueBehaviour"
end

function TaskQueueBehaviour:HasQueues()
	return (taskqueues[self.name] ~= nil)
end

function TaskQueueBehaviour:OwnerBuilt(unit)
	if not self:IsActive() then
		return
	end
	self:OnToNextTask()
end

function TaskQueueBehaviour:OwnerIdle(unit)
	if not self:IsActive() then
		return
	end
	self.countdown = 0
	self:Log("Idle")
	self:OnToNextTask()
end

function TaskQueueBehaviour:OwnerMoveFailed(unit)
	if not self:IsActive() then
		return
	end
	self:OwnerIdle(unit)
end

function TaskQueueBehaviour:OwnerDead()
	if self.waiting ~= nil then
		for k,v in pairs(self.waiting) do
			self.ai.modules.sleep.Kill(self.waiting[k])
		end
	end
	self.waiting = nil
	self.unit = nil
end

function TaskQueueBehaviour:GetQueue()
	q = taskqueues[self.name]
	if type(q) == "function" then
		q = q(self, self.ai, self.unit)
	end
	return q
end
function TaskQueueBehaviour:CanQueueNextTask()
	local unitID = self.unit:Internal().id
	-- must: already have 1 queue (not override default behaviour)
	-- Have less than 2 queues (not cancel the next buildings
	-- Have "secured" the cur spot it has to build on (not cancel 1st in queue to start 2nd in queue == is currently building
	-- We check curqueuelength == 1
	-- Unit is not a factory
	local notfactory = self.unit:Internal():Type():IsFactory() ~= true
	local notprogressing = self.progress ~= true	-- Not already progressing in queue
	local curqueuelength = #(Spring.GetCommandQueue(unitID,2))
	local building = Spring.GetUnitIsBuilding(unitID)	-- we check cur buildspeed/power ~= 0
	local name
	if building ~= nil then
		name = UnitDefs[Spring.GetUnitDefID(building)].name
	end
	self:Log("CanQueueTask? " .. tostring(curqueuelength <= 1) .. "," .. tostring(building) .. "("..tostring(name)..")" .. "," .. tostring(notprogressing) .. "," .. tostring(notfactory))
	if curqueuelength <= 1 and building and notprogressing and notfactory then
		return true
	else
		return
	end
end

function TaskQueueBehaviour:IsRunningAQueue()
	if Spring.GetCommandQueue(self.unit:Internal().id,0) > 0 then
		return true
	else
		return false
	end
end

function TaskQueueBehaviour:IsBusy()
	if Spring.GetUnitCurrentBuildPower(self.unit:Internal().id) == 0 then
		return false
	else
		return true
	end
end

function TaskQueueBehaviour:CompareWithOldPos()
	local result = false
	local x,y,z = Spring.GetUnitPosition(self.unit:Internal().id)
	if self.oldPos then
		if math.sqrt((x-self.oldPos.x)^2+(y-self.oldPos.y)^2+(z-self.oldPos.z)^2) < 16 then
			result = true
		else
			result = false
		end
	end
	self.oldPos = {x = x, y = y, z = z}
	return result
end

function TaskQueueBehaviour:UpdateInactive(frame)
	if frame % 200 == 0 then
		if self.unit:Internal():Type():IsFactory() then
			return
		end

		local inative_now = self:IsRunningAQueue() and (not self:IsBusy()) and self:CompareWithOldPos() -- check stucked cons
		if self.inactive_since == nil and inactive_now then
			self.inactive_now = frame
		elseif self.inactive_since ~= nil and not inactive_now then
			self.inactive_since = nil
		end
	end
end

function TaskQueueBehaviour:IsInactive(now, period)
	return self.inactive_since and now - self.inactive_since >= period
end

function TaskQueueBehaviour:Update()
	local frame = Spring.GetGameFrame()
	self:UpdateInactive(frame)

	if frame % 600 == 0 then
		if self:IsInactive(frame, 600) then
			self:Log("Stopping#1")
			self.unit:Internal():ExecuteCustomCommand(CMD.STOP, {}, {}) --> Triggers UnitIdle -> Next Task
		elseif (not self:IsRunningAQueue()) and (not self:IsBusy()) then
			self:Log("Stopping#2")
			self.unit:Internal():ExecuteCustomCommand(CMD.STOP, {}, {}) --> Triggers UnitIdle -> Next Task
			self:CompareWithOldPos()
		else
			self:CompareWithOldPos() -- still register current position
		end
	end
	if not self:IsActive() then
		self:DebugPoint("nothing")
		return
	end
	if frame%15 == self.unit:Internal().id%15 then
		if self:CanQueueNextTask() then
			self.progress = true
		end
	end
	if self.progress == true then
		if self.countdown > 14 then
			self:ProgressQueue()
		else
			if self.countdown == nil then
				self.countdown = 1
			else
				self.countdown = self.countdown + 1
			end
		end
	end
end

TaskQueueWakeup = class(function(a,tqb)
	a.tqb = tqb
end)
function TaskQueueWakeup:wakeup()
	self:Log("wakeup->ProgressQueue")
	self.tqb:ProgressQueue()
end

function TaskQueueBehaviour:ProgressQueue()
	unit = self.unit:Internal()
	if self:IsWaitingForPosition() then
		self:DebugPoint("waiting")
		self:Log("ProgressQueue: waiting for position")
		return
	end
	if self.queue == nil then
		if self:HasQueues() then
			self.queue = self:GetQueue()
			self:Log("ProgressQueue: getting queue")
		else
			self:DebugPoint("nothing")
			self:Log("ProgressQueue: has no queue")
			return
		end
	end
	self.countdown = 0
	self.progress = false

	if self.queue == nil then
		self.game:SendToConsole("Warning: A "..self.name.." unit, has an empty task queue")
		self:OnToNextTask()
		self:DebugPoint("nothing")
		self:Log("ProgressQueue: getqueue returned null")
		return
	end
	local idx, val = next(self.queue,self.idx)
	self.idx = idx
	if idx == nil then
		self:DebugPoint("nothing")
		self:Log("ProgressQueue: queue empty, get another queue")
		self.queue = self:GetQueue(name)
		self:OnToNextTask()
		return
	end

	self:Log("ProgressQueue: queue type: "..type(val))
	local utype = nil
	local value = val
	if type(val) == "function" then
		self:Log("ProgressQueue: resolving function task")
		value = val(self, self.ai, unit)
	end
	if value == "next" then
		self:DebugPoint("nothing")
		self:Log("ProgressQueue: next")
		self:OnToNextTask()
		return
	end
	if type(val) == "table" then
		self:Log("ProgressQueue: val table")
		self:HandleActionTask( value )
		return
	end
	if type(value) == "table" then
		self:Log("ProgressQueue: value table")
		self:HandleActionTask( value )
		return
	end

	self:Log("ProgressQueue: try to build: " .. value)
	success = self:TryToBuild( value )
	if success ~= true then
		self:Log("Unsuccessful build")
		self:DebugPoint("nothing")
		self:OnToNextTask()
		return
	end
end

function TaskQueueBehaviour:TryToBuild( unit_name, pos )
	--Spring.Echo(unit_name)
	utype = self.game:GetTypeByName(unit_name)
	if not utype then
		self.game:SendToConsole("Cannot build:"..unit_name..", could not grab the unit type from the engine")
		return false
	end
	if unit:CanBuild(utype) ~= true then
		return false
	end
	local success = false
	if utype:Extractor() then
		success = self:BuildExtractor(utype)
	elseif utype:Geothermal() then
		success = self:BuildGeo(utype)
	elseif unit:Type():IsFactory() then
		success = self.unit:Internal():Build(utype)
	else
		success = self:BuildOnMap(utype,pos)
	end
	return success
end

function TaskQueueBehaviour:FightRelativeLog(msg)
	if self.ai.id == 1 and self.unit then
		--Spring.Echo("Unit: " .. tostring(self.unit.engineID) .. "(" .. self.unit:Internal():Name() .."): " .. msg)
	end
end

function TaskQueueBehaviour:Log(msg)
	if self.ai.id == 1 and self.name == "corcom" then
		--Spring.Echo(msg)
	end
end

function tabletostring(t)
	if t == nil then
		return "nil"
	end

	output = "{"
	for k, v in pairs(t) do
		output = output .. ", [" .. tostring(k) .. "]= "
		if type(v) == "table" then
			output = output .. tabletostring(v)
		else
			output = output .. tostring(v)
		end
	end
	output = output .. "}"
	return output
end

function buildsummary(command)
	if command.id < 0 then
		local unitdefid = -command.id
		return "Build(" .. UnitDefs[unitdefid].name .. ")"
	else
		return ""
	end
end

function TaskQueueBehaviour:RemoveFightRelative()
	--self:FightRelativeLog("Looking for fight order")
	if self.unit == nil then
		return
	end

	local commands = Spring.GetUnitCommands(self.unit.engineID, 2)
	if commands == nil then
		--self:FightRelativeLog("unit has no queue")
		return
	end

	--self:FightRelativeLog("Commands: " .. tabletostring(commands))
	for idx, command in ipairs(commands) do
		if command.id == nil then
			--self:FightRelativeLog("no id")
			return
		end

		if command.id == CMD.FIGHT then
			--self:FightRelativeLog("Removing fight order " .. tostring(idx))
			self.unit:Internal():ExecuteCustomCommand(CMD.REMOVE, {command.id}, { "alt" })
			local commands2 = Spring.GetUnitCommands(self.unit.engineID, 2)
			--self:FightRelativeLog("Commands after remove: " .. tabletostring(commands2))
			return
		else
			--self:FightRelativeLog(tostring(idx) .. ". order is " .. buildsummary(command) .. ": " .. tabletostring(command))
		end
	end
	--self:FightRelativeLog("Fight order not found")

end

function TaskQueueBehaviour:HandleActionTask( task )
	local action = task.action
	self:Log("HandleActionTask: " .. action)
	if action == "nexttask" then
		self:OnToNextTask()
	elseif action == "wait" then
		if task.frames == "infinite" then
			return
		end
		t = TaskQueueWakeup(self)
		local tqb = self
		self.ai.sleep:Wait({ wakeup = function() tqb:Log("wakeup lambda -> prgoressqueue"); tqb:ProgressQueue() end, },task.frames)
	elseif action == "command" then
		if task.params then
			self.unit:Internal():ExecuteCustomCommand(task.params.cmdID, task.params.cmdParams, task.params.cmdOptions)
		end
	elseif UnitDefNames[action] and task.pos then
		if not task.pos.x then
			task.pos = nil
		end
		self:TryToBuild(action, task.pos)
	elseif action == "move" then
		self.unit:Internal():Move(task.position, {"shift"})
	elseif action == "moverelative" then
		local upos = unit:GetPosition()
		local newpos = api.Position()
		newpos.x = upos.x + task.position.x
		newpos.y = upos.y + task.position.y
		newpos.z = upos.z + task.position.z
		self.unit:Internal():Move(newpos)
	elseif action == "fight" then
		self.unit:Internal():MoveAndFire(task.position)
	elseif action == "fightrelative" then
		local upos = self.unit:Internal():GetPosition()
		local newpos = api.Position()
		newpos.x = upos.x + task.position.x
		newpos.y = upos.y + task.position.y
		newpos.z = upos.z + task.position.z
		--self:FightRelativeLog("Giving fightrelative command")
		self.unit:Internal():MoveAndFire(newpos, {"shift"})
		local tqb = self
		self.ai.sleep:Wait({ wakeup = function() tqb:RemoveFightRelative() end, }, 60 * 30 )
	elseif action == "patrol" then
		self.unit:Internal():MoveAndPatrol(task.position)
		self.active = false
		return
	elseif action == "patrolrelative" then
		local upos = self.unit:Internal():GetPosition()
		local newpos = api.Position()
		newpos.x = upos.x + task.position.x
		newpos.y = upos.y + task.position.y
		newpos.z = upos.z + task.position.z
		self.unit:Internal():MoveAndPatrol(newpos)
		self.active = false
		return
	elseif action == "repair" then
		self:Log("Repairing " .. task.target:ID())
		self.unit:Internal():Repair(task.target, {"shift"})
		return
	else
		self.game:SendToConsole("Error: Unknown action task "..value.." given to a "..self.name)
		self:DebugPoint("nothing")
		self:OnToNextTask()
	end
end

function onsuccess( job, pos )
	job.tqb:OnBuildingPlacementSuccess( job, pos )
end

function onfail( job )
	job.tqb:OnBuildingPlacementFailure( job )
end

function TaskQueueBehaviour:IsWaitingForPosition()
	return self.placementInProgress
end


function TaskQueueBehaviour:BeginWaitingForPosition()
	self.placementInProgress = true
end

function TaskQueueBehaviour:StopWaitingForPosition()
	self.placementInProgress = false
end

function TaskQueueBehaviour:BuildOnMap(utype,pos)
	unit = self.unit:Internal()
	local facing = 0
	if pos then
		pos, facing = self.ai.newplacementhandler:CreateNewPlan(unit, utype, pos)
	else
		pos = unit:GetPosition()
		pos, facing = self.ai.newplacementhandler:CreateNewPlan(unit, utype, pos)
	end
	job = {
			start_position=pos,
			max_radius=1500,
			onSuccess=onsuccess,
			onFail=onfail,
			unittype=utype,
			cleanup_on_unit_death=self.unit.engineID,
			tqb=self
	}
	if pos then
		self:OnBuildingPlacementSuccess( job, pos, facing )
		return true
	else
		self:OnBuildingPlacementFailure( job, pos )
		return false
	end
end

function TaskQueueBehaviour:BuildGeo(utype)
	-- find a free spot!
	unit = self.unit:Internal()
	local facing = 0
	p = unit:GetPosition()
	p = self.ai.geospothandler:ClosestFreeGeo(utype,p,2500)
	if p == nil or self.game.map:CanBuildHere(utype,p) ~= true then
		self:Log("Geo")
		self:OnToNextTask()
		return false
	end
	p, facing = self.ai.newplacementhandler:CreateNewPlanNoSearch(unit,utype,p)
	return self.unit:Internal():Build(utype,p,facing,{"shift"})
end

function TaskQueueBehaviour:BuildExtractor(utype)
	-- find a free spot!
	unit = self.unit:Internal()
	local p = unit:GetPosition()
	local up = p
	local facing = 0
	p = self.ai.metalspothandler:ClosestFreeSpot(utype,p)
	local sp = p
	if p and self.game.map:CanBuildHere(utype,p) ~= true then
		p = self.ai.metalspothandler:GetClosestMexPosition(p, up.x, up.z, utype.id, "s")
		if p == nil or self.game.map:CanBuildHere(utype,p) ~= true then
			local blockingUnits = Spring.GetUnitsInCylinder(sp.x, sp.z, 160)
			for ct, bunitID in pairs(blockingUnits) do
				if not (UnitDefs[Spring.GetUnitDefID(bunitID)].canMove == true) then
					unit:ExecuteCustomCommand(CMD.INSERT, {-1, CMD.RECLAIM, CMD.OPT_INTERNAL, bunitID}, {"alt"})
				end
			end
			p, facing = self.ai.newplacementhandler:CreateNewPlanNoSearch(unit,utype,p)
			unit:ExecuteCustomCommand(CMD.INSERT, {-1,-utype.id,CMD.OPT_INTERNAL,sp.x, sp.y, sp.z, facing}, {"alt"})
			return true
		end
	elseif not p then
		self:Log("Extractor")
		self:OnToNextTask()
		return false
	end
	p, facing = self.ai.newplacementhandler:CreateNewPlanNoSearch(unit,utype,p)
	return self.unit:Internal():Build(utype,p,facing,{"shift"})
end

function TaskQueueBehaviour:OnToNextTask()
	self:Log("OntoNextTask")
	self.progress = true
end

function TaskQueueBehaviour:IsDoingSomething()
	return ( self.progress == false )
end

function TaskQueueBehaviour:OnBuildingPlacementSuccess( job, pos, facing )
	self:StopWaitingForPosition()
	local p = dump( pos )
	local success self.unit:Internal():Build( job.unittype, pos, facing,{"shift"})
	if success == false then
		self:Log("Building unsuccessful after successful placement")
		self:OnToNextTask()
	end
end

function TaskQueueBehaviour:OnBuildingPlacementFailure( job )
	self:StopWaitingForPosition()
	self:Log("Building placement failure")
	self:OnToNextTask()
end

function TaskQueueBehaviour:Activate()
	self.progress = true
	self.active = true
end

function TaskQueueBehaviour:Deactivate()
	self.active = false
end

function TaskQueueBehaviour:Priority()
	return 50
end

function TaskQueueBehaviour:DebugPoint( type )
	local unit = self.unit:Internal()
	local p = unit:GetPosition()
	SendToUnsynced("shard_debug_position",p.x,p.z,type)
end
