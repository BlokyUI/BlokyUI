local Module = BlokyUI:NewModule("General.HideQuests");

function Module:OnEnable()
  local g = CreateFrame("Frame")
  g:RegisterEvent("PLAYER_ENTERING_WORLD")
  g:SetScript("OnEvent", function()
    local _, instanceType = IsInInstance()
    if instanceType == "none" then
      if not ObjectiveTrackerFrame:IsShown() then
        ObjectiveTrackerFrame:Show()
      end
      return
    end

    ObjectiveTrackerFrame:Hide()
  end)
end
