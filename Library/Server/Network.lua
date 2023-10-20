
local JobId = game.JobId
if #JobId == 0 then
	JobId = "00000000-0000-0000-0000-000000000000"
end

local u1 = { {}, {} }
local SHA1 = require(script.SHA1)
local u3 = { {}, {} }
local u4 = { "RemoteEvent", "RemoteFunction" }
local l__ReplicatedStorage__5 = game:GetService("ReplicatedStorage")
local function u6(p1, p2)
	assert(typeof(p1) == "number")
	assert(typeof(p2) == "string")
	local v3 = u1[p1]
	local v4 = v3[p2]
	if not v4 then
		v4 = SHA1("Network3/" .. "/" .. game.GameId .. "/" .. game.PlaceId .. "/" .. game.PlaceVersion .. "/" .. JobId .. "/" .. p1 .. "/" .. p2):reverse():sub(5, 36)
		v3[p2] = v4
	end
	return v4
end
local v5 = {
	Fire = function(p3, p4, ...)
		local v6 = false
		if typeof(p4) == "Instance" then
			v6 = p4:IsA("Player")
		end
		assert(v6)
		if not p4:FindFirstChild("__LOADED") then
			return
		end
		local v7 = u6(1, p3)
		local v8 = u3[1]
		local v9 = v8[v7]
		if not v9 then
			v9 = Instance.new(u4[1])
			v9.Name = v7
			v9.Parent = l__ReplicatedStorage__5
			v8[v7] = v9
		end
		task.spawn(function(...)
			v9:FireClient(p4, ...)
		end, ...)
	end
}
local l__Players__7 = game:GetService("Players")
function v5.FireAll(p5, ...)
	local v10 = l__Players__7:GetPlayers()
	local v11 = {}
	for v12, v13 in ipairs(v10) do
		if v13:FindFirstChild("__LOADED") then
			table.insert(v11, v13)
		end	
	end
	local v15 = u6(1, p5)
	local v16 = u3[1]
	local v17 = v16[v15]
	if not v17 then
		v17 = Instance.new(u4[1])
		v17.Name = v15
		v17.Parent = l__ReplicatedStorage__5
		v16[v15] = v17
	end
	if #v11 <= #v10 then
		task.spawn(function(...)
			v17:FireAllClients(...)
		end, ...)
		return
	end
	for v18, v19 in ipairs(v11) do
		task.spawn(function(...)
			v17:FireClient(v19, ...)
		end, ...)	
	end
end
function v5.Fired(p6)
	local v21 = u6(1, p6)
	local v22 = u3[1]
	local v23 = v22[v21]
	if not v23 then
		v23 = Instance.new(u4[1])
		v23.Name = v21
		v23.Parent = l__ReplicatedStorage__5
		v22[v21] = v23
	end
	return v23.OnServerEvent
end
function v5.Invoke(p7, p8, ...)
	local v24 = false
	if typeof(p8) == "Instance" then
		v24 = p8:IsA("Player")
	end
	assert(v24)
	if not p8:FindFirstChild("__LOADED") then
		return
	end
	local v25 = u6(2, p7)
	local v26 = u3[2]
	local v27 = v26[v25]
	if not v27 then
		v27 = Instance.new(u4[2])
		v27.Name = v25
		v27.Parent = l__ReplicatedStorage__5
		v26[v25] = v27
	end
	return v27:InvokeClient(p8, ...)
end
function v5.Invoked(p9)
	local v28 = u6(2, p9)
	local v29 = u3[2]
	local v30 = v29[v28]
	if not v30 then
		v30 = Instance.new(u4[2])
		v30.Name = v28
		v30.Parent = l__ReplicatedStorage__5
		v29[v28] = v30
	end
	local v31 = {}
	function v31.__newindex(p10, p11, p12)
		if p11 == "OnInvoke" then
			p11 = "OnServerInvoke"
		elseif p11 == "OnServerInvoke" then
			error(string.format("%s is not a valid member of BindableFunction \"BindableFunction\"", tostring(p11)))
		end
		v30[p11] = p12
	end
	function v31.__index(p13, p14)
		if p14 == "OnInvoke" then
			p14 = "OnServerInvoke"
		elseif p14 == "OnServerInvoke" then
			error(string.format("%s is not a valid member of BindableFunction \"BindableFunction\"", tostring(p14)))
		end
		return v30[p14]
	end
	return setmetatable({}, v31)
end
return v5
