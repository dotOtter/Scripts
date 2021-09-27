--[[__      __  _                    _____                     _
    \ \    / / (_)                  |  __ \                   (_)
     \ \  / /__ _  __ _  __ _ _ __  | |  | |_ __ __ ___      ___ _ __   __ _ ___ 
      \ \/ / _ \ |/ _` |/ _` | '__| | |  | | '__/ _` \ \ /\ / / | '_ \ / _` / __|
       \  /  __/ | (_| | (_| | |    | |__| | | | (_| |\ V  V /| | | | | (_| \__ \
        \/ \___|_|\__, |\__,_|_|    |_____/|_|  \__,_| \_/\_/ |_|_| |_|\__, |___/
                   __/ |                                                __/ |
                  |___/                                                |___/     ]]

if Player.CharName ~= "Veigar" then
    return false
end

module("VeigarDrawings", package.seeall, log.setup)
clean.module("VeigarDrawings", package.seeall, log.setup)



-- Globals
local CoreEx = _G.CoreEx
local Libs = _G.Libs
local os_clock = _G.os.clock
local ObjectManager = CoreEx.ObjectManager
local EventManager = CoreEx.EventManager
local Enums = CoreEx.Enums
local Renderer = CoreEx.Renderer
local Events = Enums.Events

local LocalPlayer = ObjectManager.Player.AsHero

local ScriptVersion = "0.0.1"
local ScriptLastUpdate = "9/26/21"

-- Globals
local Veigar = {}
local Utils = {}

Veigar.TargetSelector = nil
Veigar.Logic = {}

local Menu = _G.Libs.NewMenu

function Veigar.LoadMenu()
    Menu.RegisterMenu("VeigarDrawings", "VeigarDrawings", function()

        Menu.NewTree("VeigarDrawings", "Drawings", function()
            Menu.Checkbox("Drawings.W", "Q + W Range", true)
            Menu.Checkbox("Drawings.E", "E", true)


        end)
    end)
end


function Veigar.OnDraw()
    if not LocalPlayer.IsOnScreen then
        return false
    end ;

    -- Get spells ranges
    local Spells = { Q = Veigar.Q, W = Veigar.W, E = Veigar.E, R = Veigar.R }

    if Menu.Get("Drawings.W") then
        Renderer.DrawCircle3D(LocalPlayer.Position, 900, 30, 1, 0xFF31FFFF)
    end
    
    if Menu.Get("Drawings.E") then
        Renderer.DrawCircle3D(LocalPlayer.Position, 725, 30, 1, 0x0000FFFF)
    end

    return true
end

function OnLoad()

    Veigar.LoadMenu()
    for EventName, EventId in pairs(Events) do
        if Veigar[EventName] then
            EventManager.RegisterCallback(EventId, Veigar[EventName])
        end
    end

    return true

end