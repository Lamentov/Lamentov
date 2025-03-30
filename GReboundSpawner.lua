local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Create a Part
local part = Instance.new("Part")
part.Name = "Bound"
part.Parent = Workspace

-- Lighting Effects
if Lighting:FindFirstChild("MainColorCorrection") then
    local colorCorrection = Lighting.MainColorCorrection
    colorCorrection.TintColor = Color3.fromRGB(61, 171, 98)
    colorCorrection.Contrast = 0.2
    colorCorrection.Saturation = -0.7
    
    -- Apply Tweens
    TweenService:Create(colorCorrection, TweenInfo.new(5), { Contrast = 0, Saturation = 0, TintColor = Color3.fromRGB(255, 255, 255) }):Play()
end

-- Function to Create Sound
local function createSound(id, parent, volume)
    local sound = Instance.new("Sound")
    sound.Parent = parent
    sound.SoundId = "rbxassetid://" .. id
    sound.Volume = volume

    -- Apply Effects
    local distort = Instance.new("DistortionSoundEffect", sound)
    distort.Level = 1

    local pitch = Instance.new("PitchShiftSoundEffect", sound)
    pitch.Octave = 0.5

    sound:Play()
    return sound
end

-- Create Sounds
local screamSound = createSound("9114397505", Workspace, 0.1)
local spawnSound = createSound("9114221327", Workspace, 3)

-- Camera Shake
local CameraShaker = require(ReplicatedStorage:WaitForChild("CameraShaker"))
local camera = Workspace.CurrentCamera
local camShake = CameraShaker.new(Enum.RenderPriority.Camera.Value, function(shakeCf)
    camera.CFrame = camera.CFrame * shakeCf
end)

camShake:Start()
camShake:ShakeOnce(10, 3, 0.1, 6)

-- Delay Time Randomization
local delayTimes = {2, 2.5, 1.5, 1, 2.1}
local delayTime = delayTimes[math.random(1, #delayTimes)]
task.wait(2.8)

-- Load Entity Creator
local Creator = loadstring(game:HttpGet("https://raw.githubusercontent.com/DripCapybara/Doors-Mode-Remakes/main/ReboundSpawner.lua"))()

-- Function to Create and Run an Entity
local function createReboundEntity(speed, cycles, killRange)
    -- Ensure No Existing Entity Before Spawning
    if Workspace:FindFirstChild("Rebound") then
        Workspace.Rebound:Destroy()
    end

    local entity = Creator.createEntity({
        CustomName = "R×e&b0und",
        Model = "https://raw.githubusercontent.com/Lamentov/Lamentov/main/GReboundV7.rbxm",
        Speed = speed,
        DelayTime = delayTime,
        HeightOffset = 1.0,
        CanKill = true,
        BreakLights = false,
        KillRange = killRange,
        BackwardsMovement = true,
        FlickerLights = { false, 2.5 },
        Cycles = { Min = cycles, Max = cycles },
        CamShake = {
            true,
            {5, 15, 0.1, 1},
            100
        },
        Jumpscare = { false },
        CustomDialog = {"You were killed by R×e&b0und"}
    })

    -- Debug Events
    entity.Debug.OnEntityEnteredRoom = function(room)
        print("Entity entered room:", room)
    end

    entity.Debug.OnEntitySpawned = function(entityModel)
        print("Entity has spawned:", entityModel)
        task.wait(15)
        if entityModel and entityModel.Parent then
            entityModel:Destroy()  -- Ensures the entity is deleted after 15 sec
        end
    end

    entity.Debug.OnEntityDespawned = function(entityModel)
        print("Entity has despawned:", entityModel)
        if screamSound then screamSound:Destroy() end
        if spawnSound then spawnSound:Destroy() end
    end

    entity.Debug.OnEntityStartMoving = function(entityModel)
        print("Entity started moving:", entityModel)
        
        -- Ensure we don't infinitely wait
        local success, _ = pcall(function()
            ReplicatedStorage.GameData.LatestRoom.Changed:Wait()
        end)
        
        if not success then
            warn("Failed to wait for LatestRoom change.")
        end
    end

    entity.Debug.OnDeath = function()
        warn("You died.")
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Lamentov/Lamentov/refs/heads/main/GReboundJumpscarev2.txt"))()
        task.wait(1.8)
        loadstring(game:HttpGet("https://raw.githubusercontent.com/check78/GuidingLight/main/BoundDie.txt"))()
    end

    -- Run Entity
    Creator.runEntity(entity)
end

-- Create Rebound Entity
createReboundEntity(178, 1, 23)