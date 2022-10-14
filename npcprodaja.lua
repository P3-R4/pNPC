local prodao = {}

exports.qtarget:Ped({
    options = {
        {
            action = function(entity)
                otvorimenidr()
                prodao[entity] = true
            end,
            label = "Prodaj drogu",
            canInteract = function(entity)
                if IsPedDeadOrDying(entity, true) or IsPedAPlayer(entity) or IsEntityPositionFrozen(entity) or prodao[entity] then return false end
                return true
            end, 
        },
    },
    distance = 3.0
})

--[[CreateThread(function() -- ako hocete da se posle odredjenog vremena isprazni tabela
     while true do 
         Wait(20000)
         if prodao then 
             for k in pairs(prodao) do 
                 prodao[k] = nil
             end
         end
     end
end)]]


function otvorimenidr()
    ESX.TriggerServerCallback('getajiteme', function(kolkoima) 
    lib.registerContext({
        id = 'prodajadroge',
        title = 'Prodaja Droge',
        options = {
            {
                title = 'Prodaj Herion',
                event = 'prodaja',
                args = 'heroin',
                metadata = {
                    {label = 'Kolicina', value = kolkoima.heroin},
                }
            },
            {
                title = 'Prodaj Joint',
                event = 'prodaja',
                args = "joint",
                metadata = {
                    {label = 'Kolicina', value = kolkoima.joint},
                }
            },
            {
                title = 'Prodaj Kokain',
                event = 'prodaja',
                args = "kesicakoksa",
                metadata = {
                    {label = 'Kolicina', value = kolkoima.kesicakoksa},
                }
            },
        },
    })
    lib.showContext('prodajadroge')
end)
end



AddEventHandler('prodaja', function(args)
    local i = args
    local pid = PlayerPedId()
    if i then
        lib.defaultNotify({
            title = '',
            description = 'Pokusaj prodaje droge..',
            status = 'info'
        })
        lib.progressCircle(
            {
            duration = "3000",
            position = "bottom",
            useWhileDead = false,
            disable = {
                move = true,
                combat = true,
                car = true
            },
            anim = {
                dict = 'amb@prop_human_bum_bin@idle_b', 
                clip = 'idle_d'
            }
            }
        )
        TriggerServerEvent('zapocniprodaju', i)
    end
end)



RegisterNetEvent("aa:aa")
AddEventHandler("aa:aa", function(coords)
    lib.showTextUI('Prodaja droge u toku', {
        position = "top-center",
        icon = 'joint',
        style = {
            borderRadius = 0,
            backgroundColor = 'red',
            color = 'white',
            
        }
    })
    Wait(5000)
    lib.hideTextUI()
    TriggerEvent('aa:aa:blipPolice', coords)
end)


RegisterNetEvent("aa:aa:blipPolice")
AddEventHandler("aa:aa:blipPolice", function(coords)
    local alertblip = AddBlipForCoord(coords.x,coords.y,coords.z)
    SetBlipSprite(alertblip, 161)
    SetBlipScale(alertblip, 2.0)
    SetBlipColour(alertblip, 5)
    PulseBlip(alertblip)
    Wait(50000)
    RemoveBlip(alertblip)
end)