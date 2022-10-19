local tablepositionsandblips = _Banque.PositionsBanque

local nearObject = false 

function ReloadProps()
    local pCoords = GetEntityCoords(PlayerPedId())
    for k,v in pairs(_Banque.PropsAtm) do
        local closestObject = GetClosestObjectOfType(GetEntityCoords(PlayerPedId()), 1.2, GetHashKey(v), false, false)
        if closestObject ~= 0 and closestObject ~= nil then
            nearObject = closestObject
            break
        else
            nearObject = nil
        end
    end
    SetTimeout(1000, function()
        ReloadProps()
    end)
end



CreateThread(function()
    TriggerEvent("Banque:blips")
    while true do
        local sleep = 1000
        local playerPos = GetEntityCoords(PlayerPedId())
        for k,v in pairs(tablepositionsandblips) do
            local PositionBanque = vec3(v.pos)
            local dst1 = #(playerPos - PositionBanque)
            if dst1 < 5.0 then
                sleep = 0
                DrawMarker(6, vector3(PositionBanque.x, PositionBanque.y, PositionBanque.z-0.98), 0.0, 0.0, 0.0, -90, 0.0, 0.0, 0.75, 0.75, 0.75, _Banque.MarkerRGB.r, _Banque.MarkerRGB.g, _Banque.MarkerRGB.b, _Banque.MarkerRGB.a1, false, false, nil, false, false, false, false);
                    DrawMarker(1, vector3(PositionBanque.x, PositionBanque.y, PositionBanque.z-0.98), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.75, 0.75, 0.3, _Banque.MarkerRGB.r, _Banque.MarkerRGB.g, _Banque.MarkerRGB.b, _Banque.MarkerRGB.a2, false, false, nil, false, false, false, false);
                --DrawMarker(_Banque.Markers.Type, PositionBanque.x, PositionBanque.y, PositionBanque.z, 0, 0, 0, 0, 0, 0, _Banque.Markers.TailleX, _Banque.Markers.TailleY, _Banque.Markers.TailleZ, _Banque.Markers.CouleurR, _Banque.Markers.CouleurG, _Banque.Markers.CouleurB, _Banque.Markers.Opacite, 0, 0, 0, 1, 0, 0, 0)
                if dst1 < 2.0 then
                    sleep = 0
                    --ESX.ShowHelpNotification(_Banque.Translations.Menu.HelpNotif)
                    ESX.Game.Utils.DrawText3D(vector3(PositionBanque.x, PositionBanque.y, PositionBanque.z), ("Appuyer sur ~c~[~%s~E~c~]~s~ pour accéder à la ~%s~Banque"):format(_Banque.ServerTextColor,_Banque.ServerTextColor), 0.7, 0)
                    if IsControlJustReleased(1, 38) then
                        BankMainMenu:openMenu()
                    end
                end
            end
        end
        Wait(sleep)
    end
end)

CreateThread(function()
    for k,v in pairs(tablepositionsandblips) do
        blip = AddBlipForCoord(v.pos.x,v.pos.y,v.pos.z)
        SetBlipSprite(blip, _Banque.Blips.Sprite)
        SetBlipScale(blip, _Banque.Blips.Scale)
        SetBlipColour(blip, _Banque.Blips.Color)
        SetBlipDisplay(blip, _Banque.Blips.Display)
        SetBlipAsShortRange(blip, _Banque.Blips.AsShortRange)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(_Banque.Blips.Name)
        EndTextCommandSetBlipName(blip)
    end

    for k, v in pairs(_Banque.Atm) do
        local blip = AddBlipForCoord(v.pos)
        SetBlipDisplay(blip,5)
        SetBlipSprite(blip, 431)
        SetBlipScale(blip, 0.3)
        SetBlipColour(blip, 2)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("ATM")
        EndTextCommandSetBlipName(blip)
    end
end)

function _Banque.KeyboardInput(TextEntry, ExampleText, MaxStringLenght)
    AddTextEntry("FMMC_KEY_TIP1", TextEntry) 
    DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", ExampleText, "", "", "", MaxStringLenght)
    blockinput = true
    while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do 
        Wait(0)
    end
    if UpdateOnscreenKeyboard() ~= 2 then
        local result = GetOnscreenKeyboardResult() 
        Wait(500) 
        blockinput = false
        return result 
    else
        Wait(500) 
        blockinput = false 
        return nil 
    end
end

local options = {
    {
          name = "ox:option1",
          event = "ox_target:debug",
          icon = "fa-solid fa-credit-card",
          label = "Accéder au distributeur",
          
      }
  }
  
  local models = { "prop_atm_02", "prop_atm_03", "prop_fleeca_atm", "prop_atm_01" }
  local optionsNames = { "ox:option1" }



exports.ox_target:addModel(models, options)

AddEventHandler("ox_target:debug", function(data)
	BankMainMenu:openMenu()
end)