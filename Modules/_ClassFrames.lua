-- hide all of the class power bars, for now.
PlayerFrame:HookScript("OnEvent", function(self, event)
  if PlayerFrame.classPowerBar then
    PlayerFrame.classPowerBar:Hide()
  end

  if ComboPointDruidPlayerFrame then
    ComboPointDruidPlayerFrame:Hide()
  end

  if EssencePlayerFrame then
    EssencePlayerFrame:Hide()
  end

  if RuneFrame then
    RuneFrame:Hide()
  end
end)
-- local function UpdateRuneFrame()
--   RuneFrame:ClearAllPoints()
--   RuneFrame:SetPoint("BOTTOMRIGHT", PlayerFrame, "BOTTOMRIGHT", 100, 0)

--   for key, value in pairs(RuneFrame.Runes) do
--     -- print(key, value)
--     -- value:Hide()
--     value:SetSize(22, 20)

--     value.Rune:SetSize(20, 20)
--     value.EmptyRune:SetSize(20, 20)
--     --   if type(value) == "table" then
--     --     value:Hide()
--     --   end
--     --   -- RuneFrame[key]:SetWidth(10)
--     --   -- RuneFrameChild
--     --   -- child:SetStatusBarTexture(BUI.statusbarTexture)
--   end
-- end

-- RuneFrame:SetScript("OnEvent", function(self, event, ...)
--   UpdateRuneFrame()
--   if (event == "PLAYER_SPECIALIZATION_CHANGED" or event == "PLAYER_ENTERING_WORLD") then
--     self:UpdateRunes(true);
--     UpdateRuneFrame()
--   elseif (event == "RUNE_POWER_UPDATE") then
--     self:UpdateRunes();
--   end
-- end)
