local Module = BlokyUI:NewModule("General.Stats");

-- all credits due to the author of SUI
function Module:OnEnable()
  StatsFrame = CreateFrame("Frame", "StatsFrame", UIParent)
  StatsFrame:ClearAllPoints()
  StatsFrame:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMLEFT", 6, 6)

  local font = STANDARD_TEXT_FONT
  local fontSize = 12
  local fontFlag = "OUTLINE"
  local textAlign = "CENTER"
  local _, class = UnitClass("player")
  local color = (CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS)[class]

  local function status()
    local function getFPS() return "|c00ffffff" .. floor(GetFramerate()) .. "|r fps" end

    local function getLatency() return "|c00ffffff" .. select(4, GetNetStats()) .. "|r ms" end

    return getFPS() .. " " .. getLatency()
  end

  StatsFrame:SetWidth(50)
  StatsFrame:SetHeight(fontSize)
  StatsFrame.text = StatsFrame:CreateFontString(nil, "BACKGROUND")
  StatsFrame.text:SetPoint(textAlign, StatsFrame)
  StatsFrame.text:SetFont(font, fontSize, fontFlag)
  StatsFrame.text:SetTextColor(color.r, color.g, color.b)

  local lastUpdate = 0

  local function update(self, elapsed)
    lastUpdate = lastUpdate + elapsed
    if lastUpdate > 1 then
      lastUpdate = 0
      StatsFrame.text:SetText(status())
      self:SetWidth(StatsFrame.text:GetStringWidth())
      self:SetHeight(StatsFrame.text:GetStringHeight())
    end
  end

  StatsFrame:SetScript("OnUpdate", update)
end
