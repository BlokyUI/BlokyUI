local Tooltip = BlokyUI:NewModule("Tooltip")

function Tooltip:OnEnable()
  hooksecurefunc(GameTooltip, "Show", function(self)
    GameTooltipStatusBar:SetStatusBarTexture(BlokyUI.statusbarTexture)
    GameTooltipStatusBar:SetStatusBarColor(0, 0.8, 0)
  end)
end
