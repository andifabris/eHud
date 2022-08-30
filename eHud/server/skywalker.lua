local Tunnel = module('vrp','lib/Tunnel')
local Proxy = module('vrp','lib/Proxy')
vRP = Proxy.getInterface('vRP')
vRPclient = Tunnel.getInterface('vRP')

local hours = 20
local minutes = 0

AddEventHandler('vRP:playerSpawn',function(user_id, source)
	TriggerClientEvent('eHud:syncTimers', source, { minutes,hours })
end)

Citizen.CreateThread(function()
	while true do
		minutes = minutes + 1
		if minutes >= 60 then
			minutes = 0
			hours = hours + 1
			if hours >= 24 then
				hours = 0
			end
		end
		TriggerClientEvent('eHud:syncTimers', -1, {minutes, hours})
		Citizen.Wait(10000)
	end
end)

RegisterServerEvent('eHud:GetVehicleType')
AddEventHandler('eHud:GetVehicleType',function(car)
	
end)