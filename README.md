# qb-characterkill
To delete/kill players from the server so that they no longer live

This resource was inspired by https://github.com/IngPleb/qb-characterkill

In this script you can delete job or id bound your players!

How to change the command name?

Config.command_alliases = {"deleteplayer", "wipeplayer"}

Here you can change the Command in your chat !

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

You can use Job or citizenid please for your own safety make your choise whisly!

