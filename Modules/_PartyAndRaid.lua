hooksecurefunc("CompactUnitFrame_UpdateAll", function(self)
  local name = self:GetName()
  if name == nil then return end
  if name:match("^CompactPartyFrame(.+)") then
    CompactPartyFrameTitle:Hide()
    self.healthBar:SetStatusBarTexture(BUI.statusbarTexture)
    self.powerBar:SetStatusBarTexture(BUI.statusbarTexture)

    self.roleIcon:Show()
    self.roleIcon:SetAlpha(1)
    -- self.roleIcon:SetSize(12, 12)
    self.roleIcon:SetDrawLayer("OVERLAY")
    self.roleIcon:ClearAllPoints()
    self.roleIcon:SetPoint("TOPRIGHT", self.healthBar, "TOPRIGHT", -5, -5)

    self.name:ClearAllPoints()
    self.name:SetPoint("TOPLEFT", self.healthBar, "TOPLEFT", 5, -5)
    self.name:SetFont(BUI.font, 11, "OUTLINE")
    self.name:SetShadowOffset(0, 0)
    self.name:SetShadowColor(0, 0, 0, 0)
    self.name:SetWidth(self:GetWidth() - 20)

    _G[name .. "StatusText"]:SetFont(BUI.font, 20, nil)
    _G[name .. "AggroHighlight"]:Hide()
    _G[name .. "AggroHighlight"]:SetAlpha(0)
  end
  if name:match("^CompactRaidFrame(.+)") then
    self.healthBar:SetStatusBarTexture(BUI.statusbarTexture)
    self.powerBar:SetStatusBarTexture(BUI.statusbarTexture)

    self.roleIcon:Show()
    self.roleIcon:SetAlpha(1)
    self.roleIcon:SetSize(10, 10)
    self.roleIcon:SetDrawLayer("OVERLAY")
    self.roleIcon:ClearAllPoints()
    self.roleIcon:SetPoint("TOPRIGHT", self.healthBar, "TOPRIGHT", -5, -5)

    self.name:ClearAllPoints()
    self.name:SetPoint("TOPLEFT", self.healthBar, "TOPLEFT", 5, -5)
    self.name:SetFont(BUI.font, 10, "OUTLINE")
    self.name:SetShadowOffset(0, 0)
    self.name:SetShadowColor(0, 0, 0, 0)
    self.name:SetWidth(self:GetWidth() - 20)

    self.overAbsorbGlow:SetAlpha(0)

    _G[name .. "AggroHighlight"]:Hide()
    _G[name .. "AggroHighlight"]:SetAlpha(0)
  end
end)
