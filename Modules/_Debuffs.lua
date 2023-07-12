local Debuffs = BlokyUI:NewModule("Debuffs")

function Debuffs:OnEnable()
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

  function UpdateDebuffs()
    local Children = { DebuffFrame.AuraContainer:GetChildren() }

    for index, child in pairs(Children) do
      local frame = select(index, DebuffFrame.AuraContainer:GetChildren())
      local icon = frame.Icon
      local duration = frame.Duration
      local count = frame.Count

      if child.Border then
        child.Border:Hide()
      end

      icon:SetTexCoord(0.08, 0.92, 0.08, 0.92)

      if (count) then
        -- Set Stack Font size and reposition it
        count:SetFont(BlokyUI.font, 13, "OUTLINE")
        count:ClearAllPoints()
        if DebuffFrame.AuraContainer.isHorizontal then
          if DebuffFrame.AuraContainer.addIconsToTop then
            count:SetPoint("TOPRIGHT", frame, "TOPRIGHT", 0, -12)
          else
            count:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -1, -5)
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
      duration:SetFont(BlokyUI.font, 12, "OUTLINE")
      duration:ClearAllPoints()
      if DebuffFrame.AuraContainer.isHorizontal then
        if DebuffFrame.AuraContainer.addIconsToTop then
          duration:SetPoint("CENTER", frame, "BOTTOM", 0, 5)
        else
          duration:SetPoint("CENTER", frame, "BOTTOM", 0, 8)
        end
      elseif not DebuffFrame.AuraContainer.isHorizontal then
        if not DebuffFrame.AuraContainer.addIconsToRight then
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
  frame:RegisterEvent("PLAYER_ENTERING_WORLD", self, "Update")
  frame:RegisterUnitEvent("UNIT_AURA", self, "Update")
  frame:RegisterEvent("GROUP_ROSTER_UPDATE")
  frame:SetScript("OnEvent", function(self, event, ...)
    UpdateDebuffs()
  end)

  hooksecurefunc(AuraFrameMixin, "Update", function(self)
    UpdateDebuffs()
  end)

  hooksecurefunc(C_EditMode, "OnEditModeExit", function()
    UpdateDebuffs()
  end)

  -- hooksecurefunc(AuraButtonMixin, "UpdateDuration", UpdateDuration)
  -- hooksecurefunc(DebuffButtonMixin, "UpdateDuration", UpdateDuration)
end
