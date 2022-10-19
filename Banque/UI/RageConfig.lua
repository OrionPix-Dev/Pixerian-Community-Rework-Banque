

RageConfig = {}

RageConfig.Header = {
    textureDict = "commonmenu",-- "commonmenu",
    textureName = "interaction_bgd", --"interaction_bgd"
    color = {r = 0, g = 200, b = 200, a = 255}, -- {r = 255, g = 255, b = 255, a = 255}
    GLARE = false,
}

RageConfig.Title = {
    x = 215,
    y = 22,
    Scale = 0.90
}

Citizen.CreateThread(function()
while not HasStreamedTextureDictLoaded("commonmenu") do Wait(150) end
TextureMenu = CreateDui("https://i.pinimg.com/originals/81/26/7d/81267dec1d4578c4a954894cf7609415.gif", 500, 283)
CreateRuntimeTextureFromDuiHandle(CreateRuntimeTxd("Riiick"), "Ornichon", GetDuiHandle(TextureMenu))
AddReplaceTexture("root_cause", "gameoverblue", "Riiick", "Ornichon")
end)

Citizen.CreateThread(function()
    while not HasStreamedTextureDictLoaded("commonmenu") do Wait(150) end
    TextureMenu = CreateDui("https://i.pinimg.com/originals/81/26/7d/81267dec1d4578c4a954894cf7609415.gif", 500, 283)
    CreateRuntimeTextureFromDuiHandle(CreateRuntimeTxd("Riiick"), "Ornichon", GetDuiHandle(TextureMenu))
    AddReplaceTexture("commonmenu", "interaction_bgd", "Riiick", "Ornichon")
    end)