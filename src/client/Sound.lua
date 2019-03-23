local SoundService = game:GetService("SoundService")

local Sound = {}

local function newSoundGroup()
    local soundGroup = Instance.new("SoundGroup")
    soundGroup.Volume = 1

    soundGroup.Parent = SoundService

    return soundGroup
end

Sound.soundGroups = {
    MUSIC = newSoundGroup(),
    EFFECT = newSoundGroup(),
}

Sound.sounds = {
    COIN_COLLECT = {
        id = "rbxassetid://1453122289",
        volume = 0.5,
        group = Sound.soundGroups.EFFECT
    },
}

Sound.soundBin = Instance.new("Folder")
Sound.soundBin.Name = "soundBin"
Sound.soundBin.Parent = game:GetService("Workspace")

function Sound:playSound(deffinition,cframe)
    local soundPart = Instance.new("Part")
    local newSound = Instance.new("Sound")

    soundPart.Size = Vector3.new(1,1,1)
    soundPart.Transparency = 1
    soundPart.Anchored = true
    soundPart.CanCollide = false
    soundPart.CFrame = cframe

    soundPart.Parent = Sound.soundBin

    newSound.SoundId = deffinition.id or ""
    newSound.Volume = deffinition.volume
    newSound.SoundGroup = deffinition.group

    newSound.Parent = soundPart

    newSound.Ended:connect(function()
        newSound:Destroy()
        soundPart:Destroy()
    end)

    newSound:Play()

    return newSound
end

return Sound