local url = "https://raw.githubusercontent.com/NexDev-lua/NexoHub/refs/heads/main/games/"

local gameId = game.GameId
local gameName = "Jogo desconhecido"

pcall(function()
    local MarketplaceService = game:GetService("MarketplaceService")
    gameName = MarketplaceService:GetProductInfo(game.PlaceId).Name
end)

local scriptUrl = url .. tostring(gameId) .. ".lua"

local success, result = pcall(function()
    local source = game:HttpGet(scriptUrl)
    local func = loadstring(source)

    if not func then
        error("[NexoLoader] Não foi possível carregar o script do jogo " .. gameName)
    end

    func()
end)

if not success then
    warn("[NexoLoader] Não foi possível carregar o script do jogo " .. gameName .. ": " .. tostring(result))
end