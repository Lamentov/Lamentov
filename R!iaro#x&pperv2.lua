local Creator = loadstring(game:HttpGet("https://raw.githubusercontent.com/MuhXd/DoorSuff/main/OtherSuff/DoorEntitySpawn%2BSource"))()
-- Create entity


local entity = Creator.createEntity({
    CustomName = "R!iaro#x&pper", -- Custom name of your entity
    Model = "https://github.com/Lamentov/Lamentov/blob/main/R!iaro%23x%26pper.rbxm", -- Can be GitHub file or rbxassetid
    Speed = 120, -- Percentage, 100 = default Rush speed
    DelayTime = 5, -- Time before starting cycles (seconds)
    HeightOffset = 1,
    CanKill = true,
    KillRange = 100,
    BreakLights = true,
    BackwardsMovement = false,
    FlickerLights = {
        true, -- Enabled/Disabled
        5, -- Time (seconds)
    },
    Cycles = {
        Min = 2,
        Max = 2,
        WaitTime = 0.3,
    },
    CamShake = {
        true, -- Enabled/Disabled
        {20, 20, 1, 2}, -- Shake values (don't change if you don't know)
        100, -- Shake start distance (from Entity to you)
    },
    Jumpscare = {
        true, -- Enabled/Disabled
        {
            Image1 = "rbxassetid://11417375410", -- Image1 url
            Image2 = "rbxassetid://11417375410", -- Image2 url
            Shake = true,
            Sound1 = {
                5263560566, -- SoundId
                { Volume = 10 }, -- Sound properties
            },
            Sound2 = {
                5263560566, -- SoundId
                { Volume = 10 }, -- Sound properties
            },
            Flashing = {
                true, -- Enabled/Disabled
                Color3.fromRGB(255, 0, 0), -- Color
            },
            Tease = {
                false, -- Enabled/Disabled
                Min = 4,
                Max = 4,
            },
        },
    },
    CustomDialog = {"You died to who you call Ripper.", "You can tell his presence by the lights and his scream.", "Hide when he does this!"}, -- Custom death message
})
 
-----[[ Advanced ]]-----
entity.Debug.OnEntitySpawned = function(entityTable)
    print("Entity has spawned:", entityTable.Model)
end
 
entity.Debug.OnEntityDespawned = function(entityTable)

---====== Load achievement giver ======---
local achievementGiver = loadstring(game:HttpGet("https://raw.githubusercontent.com/RegularVynixu/Utilities/main/Doors/Custom%20Achievements/Source.lua"))()

---====== Display achievement ======---
achievementGiver({
    Title = "Income The Frowners",
    Desc = "Stop Smiling",
    Reason = "Encounter and Survive Smiler",
    Image = "rbxassetid://10546902956"
})
end
 
entity.Debug.OnEntityStartMoving = function(entityTable)
    print("Entity has started moving:", entityTable.Model)
end
 
entity.Debug.OnEntityFinishedRebound = function(entityTable)
    print("Entity has finished rebound:", entityTable.Model)
end
 
entity.Debug.OnEntityEnteredRoom = function(entityTable, room)
    print("Entity:", entityTable.Model, "has entered room:", room)
end
 
entity.Debug.OnLookAtEntity = function(entityTable)
    print("Player has looked at entity:", entityTable.Model)
end
 
entity.Debug.OnDeath = function(entityTable)
    warn("Player has died.")

local func, setupval, getinfo, typeof, getgc, next = nil, debug.setupvalue or setupvalue, debug.getinfo or getinfo, typeof, getgc, next

for i,v in next, getgc(false) do
    if typeof(v) == "function" then
        local info = getinfo(v)
        if info.currentline == 54 and info.nups == 2 and info.is_vararg == 0 then
            func = v
            break
        end
    end
end

local function DeathHint(hints, type: string)
    setupval(func, 1, hints)
    if type ~= nil then
        setupval(func, 2, type)
    end
end

DeathHint({
    "ВЎВЎ THIS SMILE IS LIKE ABMUSH !!",
    "Hide and don't Smile",
    "Don't get Tricked"
}, "Blue") -- "Blue" or "Yellow"

---====== Load achievement giver ======---
local achievementGiver = loadstring(game:HttpGet("https://raw.githubusercontent.com/RegularVynixu/Utilities/main/Doors/Custom%20Achievements/Source.lua"))()

---====== Display achievement ======---
achievementGiver({
    Title = "Smile to Fail",
    Desc = "Don't Smile",
    Reason = "Encounter And Dont Survive Smiler",
    Image = "rbxassetid://10546902956"
})
end
------------------------
 
-- Run the created entity
Creator.runEntity(entity)
