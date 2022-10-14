ESX.RegisterServerCallback('getajiteme', function(source, cb)
	local items = exports.ox_inventory:Search(source, 'count', {'joint', 'kesicakoksa', 'heroin'})
	cb(items)
end)

function jelhoce()
    local oce = math.random(1,2)
    if oce == 1 then 
        return true 
    else
        return false
    end
end

local cenedroga = {
    ['heroin'] = 450,
    ['joint'] = 250,
    ['kesicakoksa'] = 470,
}

RegisterServerEvent('zapocniprodaju', function(i, deal)
    local x = ESX.GetPlayerFromId(source)
    local xPlayers = ESX.GetExtendedPlayers('job', 'police')
    local coords = x.getCoords(true)
    if cenedroga[i] then
        if jelhoce() then
            if exports.ox_inventory:Search(source, 'count', i) >= 1 then 
                exports.ox_inventory:RemoveItem(source, i, 1)
                exports.ox_inventory:AddItem(source, 'black_money', cenedroga[i])
            else 
                TriggerClientEvent('ox_lib:defaultNotify',source, {title = 'Greska', description = 'Nemas dovoljno' .. i .. ' kod sebe', status = 'error'})

            end
        else
            for j=1, #xPlayers, 1 do
                local xPlayerx = xPlayers[j]
                TriggerClientEvent('aa:aa', xPlayerx.source, coords)
            end
            TriggerClientEvent('ox_lib:defaultNotify',source, {title = 'Bezi', description = 'Kupac je zvao policiju', status = 'info'})
        end
    end
end)
