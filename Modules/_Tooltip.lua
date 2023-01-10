local Tooltip = BlokyUI:NewModule("Tooltip")

function Tooltip:OnEnable()
  hooksecurefunc(GameTooltip, "Show", function(self)
    -- GameTooltip:

    GameTooltipStatusBar:SetStatusBarTexture(BlokyUI.statusbarTexture)
    GameTooltipStatusBar:SetStatusBarColor(0, 0.8, 0)

    -- GameTooltip.NineSlice.Center:Hide()
  end)
end
