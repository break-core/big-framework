

-- Check if the current environment is a server
local isServer = game:GetService("RunService"):IsServer()

-- Custom assertion function
local function assertTypeNumber(num)
	assert(typeof(num) == "number", "Expected a number")
end

local function assertTypeString(str)
	assert(typeof(str) == "string", "Expected a string")
end

--- Dictionary for BindableEvents
local events = {}
local functions = {}

--- List of services
local services = { 
	game:GetService("ReplicatedFirst"), 
	game:GetService("ReplicatedStorage"), 
	game:GetService("Players") 
}
if isServer then
	table.insert(services, game:GetService("ServerScriptService"))
	table.insert(services, game:GetService("ServerStorage"))
end

--- Handle errors and warnings
local function handleErrorsAndWarnings(errMsg)
	local success, result = pcall(settings)
	if success then
		return nil
	else
		local callerScript = nil
		local success2, error2 = pcall(function()
			local scriptInstance = rawget(getfenv(5), "script")
			assert(typeof(scriptInstance) == "Instance")
			assert(scriptInstance:IsA("ModuleScript") or scriptInstance:IsA("Script") or scriptInstance:IsA("LocalScript"))

			local foundServiceAncestor = false
			for _, service in ipairs(services) do
				if service:IsAncestorOf(scriptInstance) then
					foundServiceAncestor = true
					break
				end
			end

			if foundServiceAncestor then
				return nil
			end

			callerScript = string.format("callerScript:badpath:'%s'", scriptInstance:GetFullName())
			return nil
		end)

		if not success2 and not callerScript then
			callerScript = string.format("callerScript:err:'%s'", tostring(error2))
		end

		if not callerScript then
			return true
		end

		local debugMessage = string.format("Debug|%s|%s '%s' [%s]: %s", "Signal", tostring(debug.info(2, "n")), callerScript, tostring(errMsg), tostring(debug.traceback()))
		if not pcall(_G.Blunder, Enum.MessageType.MessageWarning, debugMessage) then
			warn(debugMessage)
		end

		return false
	end
end

-- Create or retrieve a BindableEvent
local function getEvent(eventName)
	assertTypeString(eventName)
	eventName = eventName:lower()
	local event = events[eventName]
	if not event then
		event = Instance.new("BindableEvent")
		events[eventName] = event
	end
	return event
end

local Signal = {}

Signal.Fire = function(eventName, ...)
	if not handleErrorsAndWarnings(eventName) then
		return
	end
	assertTypeString(eventName)
	eventName = string.lower(eventName)
	if not isServer and eventName ~= "core signal fired" then
		Signal.Fire("CORE Signal Fired", eventName)
	end
	getEvent(eventName):Fire(...)
end

Signal.Fired = function(eventName)
	if not handleErrorsAndWarnings(eventName) then
		return Instance.new("BindableEvent").Event
	end
	assertTypeString(eventName)
	eventName = string.lower(eventName)
	return getEvent(eventName).Event
end
-- Crate or retrieve a BindableFunction
local function getFunction(functionName)
	assertTypeString(functionName)
	functionName = functionName:lower()
	local signalFunction = functions[functionName]
	if not signalFunction then
		signalFunction = Instance.new("BindableFunction")
		functions[functionName] = signalFunction
	end
	return signalFunction
end

Signal.Invoke = function(functionName, ...)
	if not handleErrorsAndWarnings(functionName) then
	  return
	end
	assertTypeString(functionName)
	functionName = string.lower(functionName)
	if not isServer and functionName ~= "core signal fired" then
		Signal.Fire("CORE Signal Fired", functionName)
	end
	return getFunction(functionName):Invoke(...)
end

Signal.Invoked = function(functionName)
	if not handleErrorsAndWarnings(functionName) then
		return Instance.new("BindableFunction")
	end
	assertTypeString(functionName)
	functionName = string.lower(functionName)
	return getFunction(functionName)
end

Signal.Get = function(eventName)
	if not handleErrorsAndWarnings(eventName) then
		return Instance.new("BindableEvent")
	end
	assertTypeString(eventName)
	eventName = string.lower(eventName)
	return getEvent(eventName)
end

-- Freeze the Signal dictionary
table.freeze(Signal)

-- If the environment is a client, add external modification detection
if game:GetService("RunService"):IsClient() then
	task.spawn(function(modifiedSignal)
		local clonedSignal = table.clone(modifiedSignal)
		setmetatable(clonedSignal, nil)

		local function compareTables(table1, table2)
			if table1 ~= table2 then
				if typeof(table1) ~= "table" or typeof(table2) ~= "table" then
					return false
				end
				for key, value in next, table2 do
					if rawget(table1, key) ~= value then
						return false
					end
				end
			end
			return true
		end

		while compareTables(getmetatable(modifiedSignal), getmetatable(modifiedSignal) and table.clone(clonedSignal)) and compareTables(modifiedSignal, clonedSignal) do
			wait(math.random() * 15 + 1)
		end

		local errorMessage = "ExternalModification : Signal"
		if not pcall(_G.Blunder, Enum.MessageType.MessageWarning, errorMessage) then
			warn(errorMessage)
		end
	end, Signal)
end

return Signal



