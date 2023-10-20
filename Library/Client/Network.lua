local v1 = game:GetService("RunService"):IsStudio();
local v2 = game.JobId;
if #v2 == 0 then
	v2 = "00000000-0000-0000-0000-000000000000";
end;
local u1 = { {}, {} };
local sha1 = require(script.SHA1)
local u2 = { {}, {}, {}, {} };
local u3 = { "BindableEvent", "BindableFunction", "BindableEvent", "BindableFunction" };
local function u4(p1, p2, p3)
	local v3 = u2[p1];
	local v4 = v3[p2];
	if not v4 and p3 then
		v4 = Instance.new(u3[p1]);
		--v4.Name = p2
		v4.Parent = script;
		v3[p2] = v4;
		--print(p1,p2,p3)
	end;
	return v4;
end;

local function generateNetworkKey(index, placeholder)
	assert(typeof(index) == "number", "Invalid parameter type for index, expected number")
	assert(typeof(placeholder) == "string", "Invalid parameter type for placeholder, expected string")

	local placeholderData = networkData[index]
	local key = placeholderData[placeholder]

	if not key then
		key = sha1("Network3//"..game.GameId.."/"..game.PlaceId.."/"..game.PlaceVersion.."/"..jobId.."/"..index.."/"..placeholder):reverse():sub(5, 36)
		placeholderData[placeholder] = key
	end

	return key
end
local u6 = { {}, {} };
local l__ReplicatedStorage__7 = game:GetService("ReplicatedStorage");
local u8 = { "RemoteEvent", "RemoteFunction" };
local u9 = { function(p17, p18)
	local v34 = u4(1, p17, false);
	if v34 then
		p18.OnClientEvent:Connect(function(...)
			v34:Fire(...);
		end);
	end;
	local v35 = u4(3, p17, false);
	if not v35 then
		return;
	end;
	v35.Event:Connect(function(...)
		p18:FireServer(...);
	end);
end, function(p19, p20)
	local v36 = u4(2, p19, false);
	if v36 then
		function p20.OnClientInvoke(...)
			return v36:Invoke(...);
		end;
	end;
	local v37 = u4(4, p19, false);
	if not v37 then
		return;
	end;
	function v37.OnInvoke(...)
		return p20:InvokeServer(...);
	end;
end };
local function u10(p21, p22)
	local v38 = u6[p21];
	local v39 = v38[p22];
	if v39 then
		return v39;
	end;
	local v40 = l__ReplicatedStorage__7:FindFirstChild(p22);
	if not v40 then
		return nil;
	end;
	v40.Name = u8[p21];
	v38[p22] = v40;
	u9[p21](p22, v40);
	return v40;
end;
local v41 = {};
local function u11(p23)
	local v42 = nil;
	for v43, v44 in ipairs({ function()
			if pcall(settings) then
				return "pcall(settings)";
			end;
			return nil;
		end, function()
			local u12 = { game:GetService("ReplicatedFirst"), game:GetService("ReplicatedStorage"), game:GetService("Players"), game:GetService("Workspace") };
			local u13 = nil;
			local v46, v47 = pcall(function()
				local v48 = rawget(getfenv(6), "script");
				assert(typeof(v48) == "Instance");
				assert(v48:IsA("ModuleScript") or (v48:IsA("Script") or v48:IsA("LocalScript")));
				local v49 = false;
				for v50, v51 in ipairs(u12) do
					local v53 = nil; 
					if not v50 then
						v53 = v49;
						if v53 then
							return nil;
						else
							u13 = string.format("callerScript:badpath:'%s'", v48:GetFullName());
							return nil;
						end;
					end;
					if v51:IsAncestorOf(v48) then
						v49 = true;
						v53 = v49;
						if v53 then
							return nil;
						else
							u13 = string.format("callerScript:badpath:'%s'", v48:GetFullName());
							return nil;
						end;
					end;				
				end;
			end);
			if not v46 and not u13 then
				u13 = string.format("callerScript:err:'%s'", tostring(v47));
			end;
			return nil;
		end, function()
			local v54 = debug.info(2, "s");
			if v54 == nil then
				return "callerScriptName:nil";
			end;
			if v54 ~= "" and v54 ~= "[C]" then
				return nil;
			end;
			return string.format("callerScriptName:'%s'", v54);
		end, function()
			local v55 = 0;
			while true do
				local v56, v57 = pcall(getfenv, v55);
				if not v56 then
					break;
				end;
				if typeof(v57) == "table" and v57.getgenv ~= nil then
					return "getgenv";
				end;
				v55 = v55 + 1;			
			end;
			return nil;
		end }) do
		v42 = v44();
		if v42 then
			break;
		end;	
	end;
	if v42 == nil then
		return true;
	end;
	local v58 = string.format("Debug|%s|%s '%s' [%s]: %s", "Network", tostring(debug.info(2, "n")), tostring(v42), tostring(p23), tostring(debug.traceback()));
	return false;
end;
local function u14(p24)
	return u10(1, generateNetworkKey(1, p24));
end;
local function u15(p25)
	return u4(3, generateNetworkKey(1, p25), true);
end;
function v41.Fire(p26, ...)
	if not u11(p26) then
		return;
	end;
	local v59 = u14(p26);
	if v59 then
		task.spawn(function(...)
			v59:FireServer(...);
		end, ...);
		return;
	end;
	local u16 = u15(p26);
	task.spawn(function(...)
		u16:Fire(...);
	end, ...);
end;
local function u17(p27)
	return u4(1, generateNetworkKey(1, p27), true);
end;
function v41.Fired(p28)
	if not u11(p28) then
		return Instance.new("BindableEvent").Event;
	end;
	local v60 = u14(p28);
	if v60 then
		return v60.OnClientEvent;
	end;
	return u17(p28).Event;
end;
local function u18(p29)
	return u10(2, generateNetworkKey(2, p29));
end;
local function u19(p30)
	return u4(4, generateNetworkKey(2, p30), true);
end;
function v41.Invoke(p31, ...)
	if not u11(p31) then
		return;
	end;
	local v61 = u18(p31);
	if v61 then
		return v61:InvokeServer(...);
	end;
	return u19(p31):Invoke(...);
end;
local function u20(p32)
	return u4(2, generateNetworkKey(2, p32), true);
end;
function v41.Invoked(p33)
	local v62 = nil;
	if not u11(p33) then
		return Instance.new("BindableFunction");
	end;
	if not u4(2, generateNetworkKey(2, p33), false) then
		v62 = u18(p33);
		if not v62 then
			return u20(p33);
		end;
	else
		return u20(p33);
	end;
	local metatable = {};
	function metatable.__newindex(p34, p35, p36)
		if p35 == "OnInvoke" then
			p35 = "OnClientInvoke";
		elseif p35 == "OnClientInvoke" then
			error(string.format("%s is not a valid member of BindableFunction \"BindableFunction\"", tostring(p35)));
		end;
		v62[p35] = p36;
	end;
	function metatable.__index(p37, p38)
		if p38 == "OnInvoke" then
			p38 = "OnClientInvoke";
		elseif p38 == "OnClientInvoke" then
			error(string.format("%s is not a valid member of BindableFunction \"BindableFunction\"", tostring(p38)));
		end;
		return v62[p38];
	end;
	return setmetatable({}, metatable);
end;
local function v64(p39)
	for v65, v66 in pairs(u6) do
		if not v65 then
			return;
		end;
		if p39:IsA(u8[v65]) then
			local l__Name__67 = p39.Name;
			if v66[l__Name__67] == nil then
				v66[l__Name__67] = p39;
				p39.Name = u8[v65];
				u9[v65](l__Name__67, p39);
				return;
			else
				return;
			end;
		end;
	end;
end;
l__ReplicatedStorage__7.ChildAdded:Connect(v64);
for v68, v69 in ipairs(l__ReplicatedStorage__7:GetChildren()) do
	v64(v69);
end;
table.freeze(v41);
task.spawn(function(p40)
	local v71 = table.clone(p40);
	setmetatable(v71, nil);
	local asdc = getmetatable(p40);
	if asdc then
		asdc = table.clone(asdc);
	end
	local function v72(p41, p42)
		if p41 == p42 then
			return true;
		end;
		if typeof(p41) ~= "table" or typeof(p42) ~= "table" then
			return false;
		end;
		for v73, v74 in pairs(p42) do
			if rawget(p41, v73) ~= v74 then
				break;
			end;
		end;
		return false;
	end;
	while v72(getmetatable(p40), asdc) and v72(p40, v71) do
		task.wait(math.random() * 15 + 1);	
	end;
end, v41);
local function u21(p43)

end;
task.spawn(function(p44)
	local v76 = p44();
	local v77 = table.clone(v76);
	setmetatable(v77, nil);
	--local v78 = getmetatable(v76) and table.clone(v78);
	local v78 = getmetatable(p44);
	if v78 then
		v78 = table.clone(v78);
	end
	local function v79(p45, p46)
		if p45 == p46 then
			return true;
		end;
		if typeof(p45) ~= "table" or typeof(p46) ~= "table" then
			return false;
		end;
		for v80, v81 in pairs(p46) do
			if rawget(p45, v80) ~= v81 then
				break;
			end;
		end;
		return false;
	end;
	while true do
		local v82 = p44();
		if not v79(getmetatable(v82), v78) then
			break;
		end;
		if not v79(v82, v77) then
			break;
		end;
		task.wait(math.random() * 15 + 1);	
	end;
end, function()
	return { false, false, v1, false, false, u21, v2, l__ReplicatedStorage__7, 1, 2, u1, 1, 2, 3, 4, u2, u3, u4, u17, u15, u20, u19, u9, u6, u8, u10, u14, u18, u11, v64 };
end);
return (function(p47)
	local v83 = {};
	function v83.__index(p48, p49)
		return p47[p49];
	end;
	function v83.__newindex(p50, p51, p52)

	end;
	v83.__metatable = {};
	return setmetatable({}, v83);
end)(v41);
