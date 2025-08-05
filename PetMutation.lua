-- 🔒 TRADE FREEZER SCRIPT v2 (Grow a Garden) 🔒
-- ✅ Tested and working on mobile executor (Delta, Arceus X)
-- ⚠️ Use on trade screen before confirming

local Players = game:GetService("Players")
local lp = Players.LocalPlayer

local function getTradeUI()
    return lp.PlayerGui:FindFirstChild("TradeUI") or lp.PlayerGui:WaitForChild("TradeUI")
end

-- STEP 1: Hook RemoteEvent
local mt = getrawmetatable(game)
setreadonly(mt, false)

local oldNamecall = mt.__namecall

mt.__namecall = newcclosure(function(self, ...)
    local args = {...}
    local method = getnamecallmethod()

    -- BLOCK REMOVE ITEM FROM TRADE
    if tostring(self):lower():find("remove") and method == "FireServer" then
        print("🚫 Blocked item removal from trade!")
        return -- Stop it
    end

    return oldNamecall(self, ...)
end)

-- STEP 2: Freeze your offered item visuals
local tradeUI = getTradeUI()
if tradeUI then
    local offerFrame = tradeUI:FindFirstChild("YouOffer")
    if offerFrame then
        for _, item in ipairs(offerFrame:GetChildren()) do
            if item:IsA("ImageButton") then
                item.Active = false
                item.AutoButtonColor = false
                item.BackgroundColor3 = Color3.new(1, 0, 0)
            end
        end
        print("❄️ Trade UI visually frozen.")
    end
end

print("✅ Trade Freezer Activated.")
