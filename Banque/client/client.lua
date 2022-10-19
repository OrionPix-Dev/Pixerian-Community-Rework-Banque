
_Banque.Menu = _Banque.Menu or {}
_Banque.Historique = _Banque.Historique or {}
_Banque.SuppHistorique = _Banque.SuppHistorique or {}

BankMainMenu = RageUI.CreateMenu(_Banque.Translations.Menu.Title, " ")
BankSubMainMenu = RageUI.CreateSubMenu(BankMainMenu,_Banque.Translations.Menu.Title, " ")

BankMainMenu:setMenu(function()
    BankMainMenu:IsVisible(function(item)
        ESX.PlayerData = ESX.GetPlayerData()
        item:AddLine()
        item:AddSeparator("Nom du compte : ~o~"..GetPlayerName(PlayerId()))
        for key, value in pairs(ESX.PlayerData.accounts) do 
            if value.name == "bank" then 
                item:AddSeparator(("Argent en banque : ~b~%s$"):format(value.money))
            end
        end
        item:AddLine()
        item:AddButton("Déposer", nil, {LeftBadge = RageUI.BadgeStyle.Star, RightLabel = ("→→")}, function(s)
            if s then
                local number = _Banque.KeyboardInput("MONTANT", "", 5)
                if tonumber(number) == 0 or tonumber(number) == nil then
                    ESX.ShowNotification("Vous devez entrer un numéro valide")
                else
                    TriggerServerEvent(("%s:Deposer_"):format(_Banque.Event.Prefix), tonumber(number))
                    TriggerServerEvent(("%s:InsertHistorique_"):format(_Banque.Event.Prefix), "[~g~+~s~] - ~g~Dépot~s~", tonumber(number))
                    Wait(100)
                    ESX.PlayerData = ESX.GetPlayerData()
                end
        
            end
        end)
        item:AddButton("Retirer", nil, {LeftBadge = RageUI.BadgeStyle.Star, RightLabel = ("→→")}, function(s)
            if s then
                local number = _Banque.KeyboardInput("MONTANT", "", 5)
                if tonumber(number) == 0 or tonumber(number) == nil then
                    ESX.ShowNotification("Vous devez entrer un numéro valide")
                else
                    TriggerServerEvent(("%s:Retirer_"):format(_Banque.Event.Prefix), tonumber(number))
                    TriggerServerEvent(("%s:InsertHistorique_"):format(_Banque.Event.Prefix), "[~r~-~s~] - ~r~Retrait~s~", tonumber(number))
                    Wait(100)
                    ESX.PlayerData = ESX.GetPlayerData()
                end
            end
        end)
        item:AddButton("Transférer de l'argent", nil, {LeftBadge = RageUI.BadgeStyle.Star, RightLabel = ("→→")}, function(s)
            if s then
                local ID = _Banque.KeyboardInput("ID DU JOUEUR", "", 5)
                local number = _Banque.KeyboardInput("MONTANT", "", 5)
                if tonumber(number) == 0 and tonumber(ID) or tonumber(number) == nil and tonumber(ID) == nil then
                    ESX.ShowNotification("Vous devez entrer un numéro valide")
                else
                    TriggerServerEvent(("%s:VerifTransferer_"):format(_Banque.Event.Prefix), tonumber(number), tonumber(ID))
                end
            end
        end)
        item:AddButton("Historique des transactions", nil, {LeftBadge = RageUI.BadgeStyle.Star, RightLabel = ("→→")}, function(s)
            if s then
                TriggerServerEvent(("%s:Historique_"):format(_Banque.Event.Prefix))
            end
        end,BankSubMainMenu)


    end)
    BankSubMainMenu:getMenu()
end)

RegisterNetEvent(("%s:Transferer_"):format(_Banque.Event.Prefix))
AddEventHandler(("%s:Transferer_"):format(_Banque.Event.Prefix), function(number, ID)
    TriggerServerEvent(("%s:Transferer_"):format(_Banque.Event.Prefix), tonumber(number), tonumber(ID))
    TriggerServerEvent(("%s:InsertHistorique_"):format(_Banque.Event.Prefix), "[~r~-~s~] - ~r~Transfére~s~", tonumber(number))
end)



RegisterNetEvent(("%s:Historique_"):format(_Banque.Event.Prefix))
AddEventHandler(("%s:Historique_"):format(_Banque.Event.Prefix), function(Historique)
    _Banque.Historique = Historique
end)

BankSubMainMenu:setMenu(function()
    BankSubMainMenu:IsVisible(function(item)

        item:AddLine()
        if #_Banque.Historique < 1 then 
            item:AddSeparator("~r~Aucune transaction~s~")
            item:AddLine()
        else
            item:AddSeparator("↓ ~b~Vos transactions~s~ ↓")
            for key, value in pairs(_Banque.Historique) do
                item:AddButton("N°"..key..(" %s ~o~%s$~s~"):format(value.type, value.amount), value.date, {RightLabel = ("~r~Supprimer →")}, function(s)
                    if s then
                        local variable = _Banque.KeyboardInput("SUPPRIMER LA TRANSACTION ? (~b~OUI~s~/~r~NON~s~)", "", 10)
                        if variable == nil or variable == "" then
                            ESX.ShowNotification("Vous devez entrer ~b~OUI~s~ ou ~r~NON~s~")
                        elseif variable:lower() == "oui" or variable:upper() == "OUI" then
                            TriggerServerEvent(("%s:SupprimerHistorique_"):format(_Banque.Event.Prefix), value.id)
                            Wait(100)
                            TriggerServerEvent(("%s:Historique_"):format(_Banque.Event.Prefix))
                            ESX.ShowNotification("~r~Vous avez supprimé la transaction~s~ N° ~b~"..key)
                        elseif variable:lower() == "non" or variable:upper() == "NON" then
                            ESX.ShowNotification("~r~La transaction n'a pas été supprimée~s~")
                        end
                    end
                end)
            end
        end
    end)
end)

print("^1Credit Officiel https://github.com/StaxFD/Banque")
print("^1Cette version a été rework par OrionPix")
print("^1Modif de la version de rageui")
print("^1Modif des marker et de certain truc dans le code")
print("^1Ajout des blips des atm uniquement vissible dans un vehicule")