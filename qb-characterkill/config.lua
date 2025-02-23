Config = {}

-- Configuration for activating/deactivating the authorization check
Config.use_citizenid = false  
Config.use_jobs = false      

-- citizenids (wenn use_citizenid aktiviert ist)
Config.allowed_citizenids = {
    ["citizenids"] = true, --(please insert a ID this player can use the command)
}

-- job using (aktiv when use_jobs on = true)
Config.allowed_jobs = {
    ["police"] = 3,  -- Rank (your choise)
    ["ambulance"] = 3,
}

-- Aliase für den Befehl
Config.command_alliases = {"deleteplayer", "wipeplayer"}

-- Funktion, die nach der Löschung aufgerufen wird
Config.finish_function = function(src, playerId)
    print("Spieler " .. playerId .. " wurde erfolgreich gelöscht.")
end
