local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Require settings and commands
local Shared = ReplicatedStorage:WaitForChild("Shared")
local AdminConfig = require(Shared:WaitForChild("AdminConfig"))
local Commands = require(script.Parent:WaitForChild("Commands"))

-- Function to check if a player is an admin
local function isAdmin(player)
return AdminConfig.Admins[player.UserId] == true
end

-- The function that handles everything when a player is in the game
local function onPlayerAdded(player)
print("=")
print("[ADMIN SYSTEM] Player Joined: " .. player.Name)
print("[ADMIN SYSTEM] YOUR REAL USER ID IS: " .. player.UserId)
print("=")

if isAdmin(player) then
    print("[ADMIN SYSTEM] " .. player.Name .. " IS AN ADMIN! ✅")
else
    print("[ADMIN SYSTEM] " .. player.Name .. " IS NOT AN ADMIN. ❌ (Fix UserId in AdminConfig)")
end

-- When a player sends a message in chat
player.Chatted:Connect(function(message)
    
    -- 1. Check if the player is an admin
    if not isAdmin(player) then return end
    
    -- 2. Check if the message starts with the configured Prefix
    if string.sub(message, 1, string.len(AdminConfig.Prefix)) ~= AdminConfig.Prefix then return end
    
    -- 3. Parse the message (remove prefix and split by spaces)
    local messageWithoutPrefix = string.sub(message, string.len(AdminConfig.Prefix) + 1)
    local args = string.split(messageWithoutPrefix, " ")
    
    local commandName = string.lower(args[1]) -- The command name (e.g., kick)
    table.remove(args, 1) -- Remove the command name from the args table
    
    -- 4. Execute the command if it exists
    if Commands[commandName] then
        Commands[commandName](player, args)
    else
        print("[ADMIN SYSTEM] Command not found: " .. commandName)
    end
end)


end

-- Connect to players who join AFTER the script starts
Players.PlayerAdded:Connect(onPlayerAdded)

-- CRITICAL FIX FOR STUDIO: Catch players who loaded BEFORE the script started
for _, player in ipairs(Players:GetPlayers()) do
onPlayerAdded(player)
end