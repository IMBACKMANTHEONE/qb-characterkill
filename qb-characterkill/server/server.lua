local QBCore = exports['qb-core']:GetCoreObject()

CreateThread(function()
    for _, alias in pairs(Config.command_alliases) do
        QBCore.Commands.Add(alias, Lang:t("command.info"), {{name = 'id', help = Lang:t("command.playerid")}}, true, function(source, args)
            local src = source
            local playerId = args[1]
            local Player = QBCore.Functions.GetPlayer(tonumber(playerId))
            local User = QBCore.Functions.GetPlayer(src)
            
            if not User then return end
            
            -- Berechtigungen prüfen
            local hasPermission = false
            
            -- Überprüfung per citizenid (falls aktiviert)
            if Config.use_citizenid and Config.allowed_citizenids and Config.allowed_citizenids[User.PlayerData.citizenid] then
                hasPermission = true
            end
            
            -- Überprüfung per Job & Rang (falls aktiviert)
            if Config.use_jobs and not hasPermission and Config.allowed_jobs then
                local userJob = User.PlayerData.job.name
                local userJobGrade = User.PlayerData.job.grade.level
                
                if Config.allowed_jobs[userJob] and userJobGrade >= Config.allowed_jobs[userJob] then
                    hasPermission = true
                end
            end
            
            if not hasPermission then
                TriggerClientEvent('QBCore:Notify', src, Lang:t("command.no_permission"), 'error')
                return
            end
            
            if Player then
                local citizenid = Player.PlayerData.citizenid
                DropPlayer(playerId, Lang:t("info.kick_message"))
                CreateThread(function()
                    Wait(200)
                    
                    exports.oxmysql:execute('DELETE FROM players WHERE citizenid = ?', { citizenid })
                    exports.oxmysql:execute('DELETE FROM player_vehicles WHERE citizenid = ?', { citizenid })
                    exports.oxmysql:execute('DELETE FROM player_outfits WHERE citizenid = ?', { citizenid })
                    exports.oxmysql:execute('DELETE FROM player_houses WHERE citizenid = ?', { citizenid })
                    exports.oxmysql:execute('DELETE FROM player_contacts WHERE citizenid =?', { citizenid })
                    exports.oxmysql:execute('DELETE FROM playerskins WHERE citizenid =?', { citizenid })
                    
                    TriggerClientEvent("QBCore:Notify", src, Lang:t("info.command_executed"))
                    Config.finish_function(src, playerId)
                end)
            else
                TriggerClientEvent('QBCore:Notify', src, Lang:t("command.player_not_found"), 'error')
            end
        end)
    end
end)