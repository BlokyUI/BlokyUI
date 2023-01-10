local Buffs = BlokyUI:NewModule("Buffs")

function Buffs:OnEnable()
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

  function UpdateBuffs()
    local Children = { BuffFrame.AuraContainer:GetChildren() }

    for index, child in pairs(Children) do
      local frame = select(index, BuffFrame.AuraContainer:GetChildren())
      local icon = frame.Icon
      local duration = frame.duration
      local count = frame.count

      icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)

      if frame.Border then frame.Border:Hide() end

      -- Set Stack Font size and reposition it
      if count then
        count:SetFont(BlokyUI.font, 11, "OUTLINE")
        count:ClearAllPoints()
        if BuffFrame.AuraContainer.isHorizontal then
          if BuffFrame.AuraContainer.addIconsToTop then
            count:SetPoint("TOPRIGHT", frame, "TOPRIGHT", 0, -12)
          else
            count:SetPoint("TOPRIGHT", frame, "TOPRIGHT", 0, -2)
          end
        elseif not BuffFrame.AuraContainer.isHorizontal then
          if not BuffFrame.AuraContainer.addIconsToRight then
            count:SetPoint("TOPRIGHT", frame, "TOPRIGHT", 0, -2)
          else
            count:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -30, -2)
          end
        end
      end

      -- Set Duration Font size and reposition it
      duration:SetFont(BlokyUI.font, 11, "OUTLINE")
      duration:ClearAllPoints()
      if BuffFrame.AuraContainer.isHorizontal then
        if BuffFrame.AuraContainer.addIconsToTop then
          duration:SetPoint("CENTER", frame, "BOTTOM", 0, 5)
        else
          duration:SetPoint("CENTER", frame, "BOTTOM", 0, 15)
        end
      elseif not BuffFrame.AuraContainer.isHorizontal then
        if not BuffFrame.AuraContainer.addIconsToRight then
          duration:SetPoint("CENTER", frame, "BOTTOM", 15, 5)
        else
          duration:SetPoint("CENTER", frame, "BOTTOM", -13.5, 5)
        end
      end

      duration:SetDrawLayer("OVERLAY")

      if frame.customBorder == nil then
        ButtonDefault(frame)
      end
    end
  end

  local frame = CreateFrame("Frame")
  frame:RegisterEvent("PLAYER_ENTERING_WORLD")
  frame:RegisterUnitEvent("UNIT_AURA", "player")
  frame:RegisterEvent("WEAPON_ENCHANT_CHANGED")
  frame:RegisterEvent("GROUP_ROSTER_UPDATE")
  frame:SetScript("OnEvent", UpdateBuffs)

  -- Collapse Button
  local hideCollapse = CreateFrame("Frame")
  hideCollapse:RegisterEvent("PLAYER_ENTERING_WORLD")
  hideCollapse:RegisterUnitEvent("UNIT_AURA", "player")
  hideCollapse:SetScript("OnEvent", function()
    BuffFrame.CollapseAndExpandButton:Hide()
  end)

  hooksecurefunc(C_EditMode, "OnEditModeExit", function()
    BuffFrame.CollapseAndExpandButton:Hide()
  end)

  hooksecurefunc(BuffButtonMixin, "UpdateDuration", UpdateDuration)
  hooksecurefunc(TempEnchantButtonMixin, "UpdateDuration", UpdateDuration)
end
