-- DebuffType Colors for the Debuff Border
local DebuffColor      = {}
DebuffColor["none"]    = { r = 0.80, g = 0, b = 0 };
DebuffColor["Magic"]   = { r = 0.20, g = 0.60, b = 1.00 };
DebuffColor["Curse"]   = { r = 0.60, g = 0.00, b = 1.00 };
DebuffColor["Disease"] = { r = 0.60, g = 0.40, b = 0 };
DebuffColor["Poison"]  = { r = 0.00, g = 0.60, b = 0 };

local function UpdateDuration(self, timeLeft)
  if timeLeft >= 86400 then
    self.duration:SetFormattedText("%dd", ceil(timeLeft / 86400))
  elseif timeLeft >= 3600 then
    self.duration:SetFormattedText("%dh", ceil(timeLeft / 3600))
  elseif timeLeft >= 60 then
    self.duration:SetFormattedText("%dm", ceil(timeLeft / 60))
  else
    self.duration:SetFormattedText("%ds", timeLeft)
  end
end

local function ButtonDefault(button)
  local border = CreateFrame("Frame", nil, button)
  border:SetSize(button.Icon:GetWidth() + 4, button.Icon:GetHeight() + 4)
  border:SetFrameLevel(0)
  if BuffFrame.AuraContainer.isHorizontal then
    if BuffFrame.AuraContainer.addIconsToTop then
      border:SetPoint("CENTER", button, "CENTER", 0, -5)
    else
      border:SetPoint("CENTER", button, "CENTER", 0, 5)
    end
  elseif not BuffFrame.AuraContainer.isHorizontal then
    if not BuffFrame.AuraContainer.addIconsToRight then
      border:SetPoint("CENTER", button, "CENTER", 15, 0)
    else
      border:SetPoint("CENTER", button, "CENTER", -15, 0)
    end
  end

  border.texture = border:CreateTexture()
  border.texture:SetAllPoints()
  border.texture:SetColorTexture(0, 0, 0, 1)
  border.texture:SetDrawLayer("BACKGROUND", -7)

  button.customBorder = border
end

function UpdateDebuffs()
  local Children = { DebuffFrame.AuraContainer:GetChildren() }

  for index, child in pairs(Children) do
    local frame = select(index, DebuffFrame.AuraContainer:GetChildren())
    local icon = frame.Icon
    local duration = frame.duration
    local count = frame.count

    if child.Border then
      child.Border:Hide()
    end

    icon:SetTexCoord(0.08, 0.92, 0.08, 0.92)

    if (count) then
      -- Set Stack Font size and reposition it
      count:SetFont(BUI.font, 13, "OUTLINE")
      count:ClearAllPoints()
      if DebuffFrame.AuraContainer.isHorizontal then
        if DebuffFrame.AuraContainer.addIconsToTop then
          count:SetPoint("TOPRIGHT", frame, "TOPRIGHT", 0, -12)
        else
          count:SetPoint("TOPRIGHT", frame, "TOPRIGHT", 0, -2)
        end
      elseif not DebuffFrame.AuraContainer.isHorizontal then
        if not DebuffFrame.AuraContainer.addIconsToRight then
          count:SetPoint("TOPRIGHT", frame, "TOPRIGHT", 0, -2)
        else
          count:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -30, -2)
        end
      end
    end

    -- Set Duration Font size and reposition it
    duration:SetFont(BUI.font, 12, "OUTLINE")
    duration:ClearAllPoints()
    if DebuffFrame.AuraContainer.isHorizontal then
      if DebuffFrame.AuraContainer.addIconsToTop then
        duration:SetPoint("CENTER", frame, "BOTTOM", 0, 5)
      else
        duration:SetPoint("CENTER", frame, "BOTTOM", 0, 15)
      end
    elseif not DebuffFrame.AuraContainer.isHorizontal then
      if not DebuffFrame.AuraContainer.addIconsToRight then
        duration:SetPoint("CENTER", frame, "BOTTOM", 15, 5)
      else
        duration:SetPoint("CENTER", frame, "BOTTOM", -13.5, 5)
      end
    end
    duration:SetDrawLayer("OVERLAY")

    if frame.customBorder == nil then
      ButtonDefault(frame)
    end

    -- Set the color of the Debuff Border
    local debuffType
    if (child.buttonInfo) then
      debuffType = child.buttonInfo.debuffType
    end
    if (frame.customBorder) then
      local color
      if (debuffType) then
        color = DebuffColor[debuffType]
      else
        color = DebuffColor["none"]
      end
      frame.customBorder.texture:SetColorTexture(color.r, color.g, color.b, 1)
    end
  end
end

local frame = CreateFrame("Frame")
frame:RegisterEvent("PLAYER_ENTERING_WORLD", self, "Update")
frame:RegisterUnitEvent("UNIT_AURA", self, "Update")
frame:RegisterEvent("GROUP_ROSTER_UPDATE")
frame:SetScript("OnEvent", function(self, event, ...)
  UpdateDebuffs()
end)

hooksecurefunc(DebuffButtonMixin, "UpdateDuration", UpdateDuration)
