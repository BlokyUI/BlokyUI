local Buffs = BlokyUI:NewModule("Buffs")

function Buffs:OnEnable()
  local function UpdateDuration(self, timeLeft)
    if timeLeft >= 86400 then
      self.Duration:SetFormattedText("%dd", ceil(timeLeft / 86400))
    elseif timeLeft >= 3600 then
      self.Duration:SetFormattedText("%dh", ceil(timeLeft / 3600))
    elseif timeLeft >= 60 then
      self.Duration:SetFormattedText("%dm", ceil(timeLeft / 60))
    else
      self.Duration:SetFormattedText("%ds", timeLeft)
    end
  end

  function UpdateBuffs()
    local Children = { BuffFrame.AuraContainer:GetChildren() }

    for index, child in pairs(Children) do
      local frame = select(index, BuffFrame.AuraContainer:GetChildren())
      local duration = frame.Duration
      local count = frame.Count

      -- if frame.TempEnchantBorder then frame.TempEnchantBorder:Hide() end

      -- Set Stack Font size and reposition it
      if count then
        count:SetFont(BlokyUI.font, 11, "OUTLINE")
        count:ClearAllPoints()
        if BuffFrame.AuraContainer.isHorizontal then
          if BuffFrame.AuraContainer.addIconsToTop then
            count:SetPoint("TOPRIGHT", frame, "TOPRIGHT", 0, -12)
          else
            count:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -1, -5)
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
          duration:SetPoint("CENTER", frame, "BOTTOM", 0, 8)
        end
      elseif not BuffFrame.AuraContainer.isHorizontal then
        if not BuffFrame.AuraContainer.addIconsToRight then
          duration:SetPoint("CENTER", frame, "BOTTOM", 15, 5)
        else
          duration:SetPoint("CENTER", frame, "BOTTOM", -13.5, 5)
        end
      end

      duration:SetDrawLayer("OVERLAY")

      frame:SetSize(32, 32)
      BlokyUI.msq:AddButton(frame)
    end
  end

  local frame = CreateFrame("Frame")
  frame:RegisterEvent("PLAYER_ENTERING_WORLD")
  frame:RegisterUnitEvent("UNIT_AURA", "player")
  frame:RegisterEvent("WEAPON_ENCHANT_CHANGED")
  frame:RegisterEvent("GROUP_ROSTER_UPDATE")
  frame:SetScript("OnEvent", UpdateBuffs)

  hooksecurefunc(AuraFrameMixin, "Update", function(self)
    UpdateBuffs()
  end)

  -- Collapse Button
  local hideCollapse = CreateFrame("Frame")
  hideCollapse:RegisterEvent("PLAYER_ENTERING_WORLD")
  hideCollapse:RegisterUnitEvent("UNIT_AURA", "player")
  hideCollapse:SetScript("OnEvent", function()
    BuffFrame.CollapseAndExpandButton:Hide()
  end)

  hooksecurefunc(C_EditMode, "OnEditModeExit", function()
    BuffFrame.CollapseAndExpandButton:Hide()
    UpdateBuffs()
  end)
end
