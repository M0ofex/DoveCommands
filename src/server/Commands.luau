-- A ModuleScript containing all the commands logic
local Commands = {}

-- ==========================================
-- Helper Functions
-- ==========================================

-- Function to find a player by name, display name, or "me"
local function getPlayerFromString(caller, text)
if not text then return nil end
text = string.lower(text)

-- Shortcut for targeting yourself
if text == "me" then return caller end

for _, player in ipairs(game.Players:GetPlayers()) do
    -- Check Username
    if string.sub(string.lower(player.Name), 1, string.len(text)) == text then
        return player
    end
    -- Check DisplayName
    if string.sub(string.lower(player.DisplayName), 1, string.len(text)) == text then
        return player
    end
end
return nil


end

-- ==========================================
-- Basic Commands
-- ==========================================

-- Kick command: ;kick playername reason
Commands.kick = function(caller, args)
local targetName = args[1]
local reason = table.concat(args, " ", 2)

if reason == "" then reason = "You have been kicked by an Admin." end

local targetPlayer = getPlayerFromString(caller, targetName)
if targetPlayer then
    targetPlayer:Kick(reason)
    print(caller.Name .. " kicked " .. targetPlayer.Name)
end


end

-- ==========================================
-- Abuse / Fun Commands
-- ==========================================

-- Explode command: ;explode playername
Commands.explode = function(caller, args)
local targetName = args[1]
local targetPlayer = getPlayerFromString(caller, targetName)

if targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
    local explosion = Instance.new("Explosion")
    explosion.Position = targetPlayer.Character.HumanoidRootPart.Position
    explosion.Parent = game.Workspace
    print(caller.Name .. " exploded " .. targetPlayer.Name)
end


end

-- Kill command: ;kill playername
Commands.kill = function(caller, args)
local targetName = args[1]
local targetPlayer = getPlayerFromString(caller, targetName)

if targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("Humanoid") then
    targetPlayer.Character.Humanoid.Health = 0
    print(caller.Name .. " killed " .. targetPlayer.Name)
end


end

return Commands