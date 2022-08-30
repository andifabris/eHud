local Tunnel = module('vrp', 'lib/Tunnel')
local Proxy = module('vrp', 'lib/Proxy')
vRP = Proxy.getInterface('vRP')

z = {}
Tunnel.bindInterface('eHud', z)
zSERVER = Tunnel.getInterface('eHud')

local ped = 0
local openPhone = false
local openGps = false
local showHud = false
local showMovie = false
local health = 0
local armour = 0
local hunger = 100
local thirst = 100
local stress = 0
local radioDisplay = nil
local voiceMode = 'Normal'
local address = ''
local x, y, z = 0.0, 0.0, 0.0
local district = {['AIRP'] = 'Aeroporto Internacional', ['ALAMO'] = 'Alamo Sea', ['ALTA'] = 'Alta', ['ARMYB'] = 'Fort Zancudo', ['BANHAMC'] = 'Banham Canyon Dr', ['BANNING'] = 'Banning', ['BEACH'] = 'Vespucci Beach', ['BHAMCA'] = 'Banham Canyon', ['BRADP'] = 'Braddock Pass', ['BRADT'] = 'Braddock Tunnel', ['BURTON'] = 'Burton', ['CALAFB'] = 'Calafia Bridge', ['CANNY'] = 'Raton Canyon', ['CCREAK'] = 'Cassidy Creek', ['CHAMH'] = 'Chamberlain Hills', ['CHIL'] = 'Vinewood Hills', ['CHU'] = 'Chumash', ['CMSW'] = 'Chiliad Mountain State Wilderness', ['CYPRE'] = 'Cypress Flats', ['DAVIS'] = 'Davis', ['DELBE'] = 'Del Perro Beach', ['DELPE'] = 'Del Perro', ['DELSOL'] = 'La Puerta', ['DESRT'] = 'Grand Senora Desert', ['DOWNT'] = 'Downtown', ['DTVINE'] = 'Downtown Vinewood', ['EAST_V'] = 'East Vinewood', ['EBURO'] = 'El Burro Heights', ['ELGORL'] = 'El Gordo Lighthouse', ['ELYSIAN'] = 'Elysian Island', ['GALFISH'] = 'Galilee', ['GOLF'] = 'GWC and Golfing Society', ['GRAPES'] = 'Grapeseed', ['GREATC'] = 'Great Chaparral', ['HARMO'] = 'Harmony', ['HAWICK'] = 'Hawick', ['HORS'] = 'Vinewood Racetrack', ['HUMLAB'] = 'Humane Labs and Research', ['JAIL'] = 'Bolingbroke Penitentiary', ['KOREAT'] = 'Little Seoul', ['LACT'] = 'Land Act Reservoir', ['LAGO'] = 'Lago Zancudo', ['LDAM'] = 'Land Act Dam', ['LEGSQU'] = 'Legion Square', ['LMESA'] = 'La Mesa', ['LOSPUER'] = 'La Puerta', ['MIRR'] = 'Mirror Park', ['MORN'] = 'Morningwood', ['MOVIE'] = 'Richards Majestic', ['MTCHIL'] = 'Mount Chiliad', ['MTGORDO'] = 'Mount Gordo', ['MTJOSE'] = 'Mount Josiah', ['MURRI'] = 'Murrieta Heights', ['NCHU'] = 'North Chumash', ['NOOSE'] = 'N.O.O.S.E', ['OCEANA'] = 'Pacific Ocean', ['PALCOV'] = 'Paleto Cove', ['PALETO'] = 'Paleto Bay', ['PALFOR'] = 'Paleto Forest', ['PALHIGH'] = 'Palomino Highlands', ['PALMPOW'] = 'Palmer-Taylor Power Station', ['PBLUFF'] = 'Pacific Bluffs', ['PBOX'] = 'Pillbox Hill', ['PROCOB'] = 'Procopio Beach', ['RANCHO'] = 'Rancho', ['RGLEN'] = 'Richman Glen', ['RICHM'] = 'Richman', ['ROCKF'] = 'Rockford Hills', ['RTRAK'] = 'Redwood Lights Track', ['SANAND'] = 'San Andreas', ['SANCHIA'] = 'San Chianski Mountain Range', ['SANDY'] = 'Sandy Shores', ['SKID'] = 'Mission Row', ['SLAB'] = 'Stab City', ['STAD'] = 'Maze Bank Arena', ['STRAW'] = 'Strawberry', ['TATAMO'] = 'Tataviam Mountains', ['TERMINA'] = 'Terminal', ['TEXTI'] = 'Textile City', ['TONGVAH'] = 'Tongva Hills', ['TONGVAV'] = 'Tongva Valley', ['VCANA'] = 'Vespucci Canals', ['VESP'] = 'Vespucci', ['VINE'] = 'Vinewood', ['WINDF'] = 'Ron Alternates Wind Farm', ['WVINE'] = 'West Vinewood', ['ZANCUDO'] = 'Zancudo River', ['ZP_ORT'] = 'Port of South Los Santos', ['ZQ_UAR'] = 'Davis Quartz'}
local hours = 0
local minutes = 0
local fuel = 0
local seatbelt = 1
local beltSpeed = 0
local entVelocity = 0
local beltLock = false
local ready = false


function CalculateTimeToDisplay()
	hours = GetClockHours()
	minutes = GetClockMinutes()
	if hours <= 9 then
		hours = '0'..hours
	end
	if minutes <= 9 then
		minutes = '0'..minutes
	end
end

function UpdateOverlay()
  	CalculateTimeToDisplay()
end

RegisterNetEvent('vRP:playerReady')
AddEventHandler('vRP:playerReady', function(status)
	ready = status
end)

RegisterNetEvent('eHud:changeHudOnOff')
AddEventHandler('eHud:changeHudOnOff',function(status)
	showHud = status
	SendNUIMessage({ display = status})
end)

RegisterCommand('hud', function(source, args)
	TriggerEvent('eHud:chgangeStatusHud')
end)

RegisterNetEvent('eHud:chgangeStatusHud')
AddEventHandler('eHud:chgangeStatusHud',function()
	if showHud then
		showHud = false
		SendNUIMessage({ display = showHud})
	else
		showHud = true
	end
end)

RegisterNetEvent('eHud:statusHud')
AddEventHandler('eHud:statusHud',function(status)
	showHud = status
end)


RegisterNetEvent('eHud:statusPhone')
AddEventHandler('eHud:statusPhone',function(status)
	openPhone = status
end)

RegisterNetEvent('eHud:statusGps')
AddEventHandler('eHud:statusGps',function(status)
	openGps = status
end)

RegisterNetEvent('statusHunger')
AddEventHandler('statusHunger',function(number)
	hunger = parseInt(number)
end)

RegisterNetEvent('statusThirst')
AddEventHandler('statusThirst',function(number)
	thirst = parseInt(number)
end)

RegisterNetEvent('statusStress')
AddEventHandler('statusStress',function(number)
	stress = parseInt(number)
end)

RegisterNetEvent('eHud:voiceMode')
AddEventHandler('eHud:voiceMode', function(number)
	if number == 1 then
		voiceMode = 'Normal'
	elseif number == 2 then
		voiceMode = 'Gritando'
	elseif number == 3 then
		voiceMode = 'Susurrando'
	end
end)

RegisterNetEvent('eHud:radioMode')
AddEventHandler('eHud:radioMode',function(number)
	if parseInt(number) <= 0 then
		radioMode = nil
	else
		if parseInt(number) == 911 then
			radioMode = 'Policia:Mhz'
		elseif parseInt(number) == 912 then
			radioMode = 'Policia:Mhz'
		elseif parseInt(number) == 112 then
			radioMode = 'Paramédico:Mhz'
		elseif parseInt(number) == 704 then
			radioMode = 'Reboque:Mhz'
		else
			radioMode = parseInt(number)..':Mhz'
		end
	end
end)

RegisterNetEvent('eHud:belt')
AddEventHandler('eHud:belt',function()
  local ped = PlayerPedId()
  local car = GetVehiclePedIsIn(ped)
	if car ~= 0 and (ExNoCarro or IsCar(car)) then
		TriggerEvent('cancelando',true)
		if seatbelt then
			TriggerEvent('vrp_sounds:source','unbelt', 0.5)
			SetTimeout(2000,function()
				seatbelt = false
				TriggerEvent('cancelando',false)
			end)
		else
			TriggerEvent('vrp_sounds:source','belt', 0.5)
			SetTimeout(3000,function()
				seatbelt = true
				TriggerEvent('cancelando',false)
			end)
		end
	end
end, false)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(100)
		if showHud then
			health = (GetEntityHealth(PlayerPedId())-100)/300*100
      		x, y, z = table.unpack(GetEntityCoords(ped))
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(500)
		if showHud then
      		local pos = GetEntityCoords(ped)
			local var1, var2 = GetStreetNameAtCoord(pos.x, pos.y, pos.z, Citizen.ResultAsInteger(), Citizen.ResultAsInteger())
      		local current_zone = district[GetNameOfZone(pos.x, pos.y, pos.z)]
  
			ped = PlayerPedId()
			armour = GetPedArmour(ped)
			heading = GetEntityHeading(ped)

			if (GetStreetNameFromHashKey(var1) and GetNameOfZone(pos.x, pos.y, pos.z)) then
				if (district[GetNameOfZone(pos.x, pos.y, pos.z)] and tostring(GetStreetNameFromHashKey(var1))) then
					address = tostring(GetStreetNameFromHashKey(var1))..', '..district[GetNameOfZone(pos.x, pos.y, pos.z)]
				end
			end
		end
    	UpdateOverlay()
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(2000)
    	local ped = PlayerPedId()
    	if IsPedInAnyVehicle(ped) then
     		local vehicle = GetVehiclePedIsUsing(ped)
      		local engine = GetIsVehicleEngineRunning(vehicle)
      		if engine and not IsPedOnAnyBike(ped) and not IsPedInAnyHeli(ped) and not IsPedInAnyPlane(ped) then
				if not beltLock then
				TriggerEvent('vrp_sounds:source','sem-cinto', 0.5)
				end
      		end
    	end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(100)
    	local playerId = PlayerId()
    	local playerTalking = NetworkIsPlayerTalking(playerId)
		if showHud then
			if IsPedInAnyVehicle(ped) then
				local vehicle = GetVehiclePedIsUsing(ped)
				local fuel = parseInt(GetVehicleFuelLevel(vehicle))
				local speed = GetEntitySpeed(vehicle) * 3.605936 -- 2.
				local vehicleGear = GetVehicleCurrentGear(vehicle)
				local speedNail = 0
				local rpmNail = 0
				local rpm = GetVehicleCurrentRpm(vehicle)
				local auto, low, hight = GetVehicleLightsState(GetVehiclePedIsIn(PlayerPedId()))
				local engine = GetIsVehicleEngineRunning(vehicle)
				rpm = math.ceil(rpm * 10000, 2)
				speedNail = math.ceil( 283 - math.ceil( math.ceil(speed * 205) / 380) )
				rpmNail = 285 - math.ceil( math.ceil((rpm-2000) * 140) / 10000)
				
				if low == 1 and hight == 0 then
					headlight = 1
				elseif  hight == 1 then
					headlight = 2
				else
					headlight = 0
				end

				if not engine then
					seatbelt = 1
				elseif engine and not beltLock then
					seatbelt = 2
				else
					seatbelt = 3
				end

				if (speed == 0 and vehicleGear == 0) or (speed == 0 and vehicleGear == 1) then
					vehicleGear = 'N'
				elseif speed > 0 and vehicleGear == 0 then
					vehicleGear = 'R'
				end
				
				DisplayRadar(true)

				SendNUIMessage({ display = showHud, vehicle = true, health = health, armour = armour, thirst = thirst, hunger = hunger, stress = stress, address = address, radio = radioMode, hours = hours, minutes = minutes, voice = voiceMode, talking = playerTalking, fuel = fuel, speed = speed, speedNail = speedNail, rpmNail = rpmNail, gear = vehicleGear, seatbelt = seatbelt, headlight = headlight, engine = engine })
			else

				if openGps then
					DisplayRadar(true)
				else
					DisplayRadar(false)
				end

				SendNUIMessage({ display = showHud, vehicle = false, health = health, armour = armour, thirst = thirst, hunger = hunger, stress = stress, address = address, radio = radioMode, hours = hours, minutes = minutes, voice = voiceMode, talking = playerTalking })
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		local timeDistance = 500
		if IsPedInAnyVehicle(ped) then
			timeDistance = 4
			local veh = GetVehiclePedIsUsing(ped)
			local vehClass = GetVehicleClass(veh)
			if (vehClass >= 0 and vehClass <= 7) or (vehClass >= 9 and vehClass <= 12) or (vehClass >= 17 and vehClass <= 20) then
				local speed = GetEntitySpeed(veh) * 3.605936
				if speed ~= beltSpeed then
					if (beltSpeed - speed) >= 30 and not beltLock then
						local entCoords = GetOffsetFromEntityInWorldCoords(veh,0.0,7.0,0.0)
						SetEntityHealth(ped,GetEntityHealth(ped)-50)

						SetEntityCoords(ped,entCoords.x,entCoords.y,entCoords.z+1)
						SetEntityVelocity(ped,entVelocity.x,entVelocity.y,entVelocity.z)
						Citizen.Wait(1)
						SetPedToRagdoll(ped,5000,5000,0,0,0,0)
					end
					beltSpeed = speed
					entVelocity = GetEntityVelocity(veh)
				end

				if beltLock then
					DisableControlAction(1,75,true)
				end

				if IsControlJustReleased(1,47) then
					beltLock = not beltLock

					if not beltLock then
						TriggerEvent('vrp_sounds:source','unbelt',0.5)
					else
						TriggerEvent('vrp_sounds:source','belt',0.5)
					end
				end
			end
		else
			if beltSpeed ~= 0 then
				beltSpeed = 0
			end

			if beltLock then
				beltLock = false
			end
		end
		Citizen.Wait(timeDistance)
	end
end)

Citizen.CreateThread(function()
	while true do
		local ped = PlayerPedId()
		local health = GetEntityHealth(ped)

		if ready  then
			if health > 101 then
				if hunger >= 10 and hunger <= 20 then
					SetFlash(0,0,500,1000,500)
					SetEntityHealth(ped,health-1)
				elseif hunger <= 9 then
					SetFlash(0,0,500,1000,500)
					SetEntityHealth(ped,health-2)
				end

				if thirst >= 10 and thirst <= 20 then
					SetFlash(0,0,500,1000,500)
					SetEntityHealth(ped,health-1)
				elseif thirst <= 9 then
					SetFlash(0,0,500,1000,500)
					SetEntityHealth(ped,health-2)
				end
			end
		end
		Citizen.Wait(5000)
	end
end)

Citizen.CreateThread(function()
	while true do
		local ped = PlayerPedId()
		local health = GetEntityHealth(ped)

		if health > 101 then
			if stress >= 80 then
				ShakeGameplayCam('LARGE_EXPLOSION_SHAKE',0.10)
				if parseInt(math.random(3)) >= 3 and not IsPedInAnyVehicle(ped) then
					SetPedToRagdoll(ped,5000,5000,0,0,0,0)
					TriggerServerEvent('vrp_inventory:Cancel')
				end
			elseif stress >= 60 and stress <= 79 then
				ShakeGameplayCam('LARGE_EXPLOSION_SHAKE',0.05)
				if parseInt(math.random(3)) >= 3 and not IsPedInAnyVehicle(ped) then
					SetPedToRagdoll(ped,3000,3000,0,0,0,0)
					TriggerServerEvent('vrp_inventory:Cancel')
				end
			end
		end
		Citizen.Wait(10000)
	end
end)