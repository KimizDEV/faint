---------------------------------
--Paikalliset ja yleiset muuttujat
---------------------------------
local Ragdoll = false
ragdol = true

---------------------------------
--KeyMapping Register
---------------------------------
RegisterKeyMapping('faint', 'Pyörry', 'keyboard', 'u') -- ('(Chat Commandi)', '(Keybind Menu Descriptioni)', '(Input Device)', '(Default nappula)')
-- Tämän avulla pelaaja voi vaihtaa ragdoll napin.

---------------------------------
--Ragdoll Toggle
---------------------------------

RegisterCommand('faint', function()
    TriggerEvent("Ragdoll", source)
end, false)
TriggerEvent( "chat:addSuggestion", "/faint", "Käyttäessäsi tätä komentoa, hahmosi pyörtyy." )


RegisterNetEvent("Ragdoll")
AddEventHandler("Ragdoll", function()
    if (ragdol) then
        setRagdoll(true)
        ragdol = false
    else
        setRagdoll(false)
        ragdol = true
    end
end)

---------------------------------
--Functions
---------------------------------
function setRagdoll(rag)
	Ragdoll = rag
	if Ragdoll then
		Citizen.CreateThread(function()
			while Ragdoll do 
				Citizen.Wait(0)

				vehCheck() -- Estää pelaajaa tekemästä ragdollia ajoneuvossa

				if Ragdoll then
					SetPedToRagdoll(GetPlayerPed(-1), 1000, 1000, 0, 0, 0, 0)
					if ragdol then
						Ragdoll = false
					end
				end
			end
		end)
	end
end

function vehCheck()
    if Ragdoll then
        if IsPedInAnyVehicle(GetPlayerPed(-1), false) then
            Ragdoll = false
            notify("Meinasitko autoon kupsahtaa?")
        end
    end
end

function notify(text)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(text)
    DrawNotification(true, true)
end
