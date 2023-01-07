hooksecurefunc("CompactUnitFrame_UpdateAll", function(self)
  local name = self:GetName()
  if name == nil then return end
  if name:match("^CompactPartyFrame(.+)") then
    self.healthBar:SetStatusBarTexture(BUI.statusbarTexture)
    self.powerBar:SetStatusBarTexture(BUI.statusbarTexture)

    _G[name .. "RoleIcon"]:Show()
    _G[name .. "RoleIcon"]:SetAlpha(1)
    _G[name .. "RoleIcon"]:SetDrawLayer("OVERLAY")
    _G[name .. "RoleIcon"]:ClearAllPoints()
    _G[name .. "RoleIcon"]:SetPoint("TOPLEFT", self, "TOPLEFT", 4, -5.5)

    _G[name .. "Name"]:ClearAllPoints()
    _G[name .. "Name"]:SetPoint("TOPLEFT", self, "TOPLEFT", 20, -6)
    _G[name .. "Name"]:SetFont(BUI.font, 11, "OUTLINE")
    _G[name .. "Name"]:SetShadowOffset(0, 0)
    _G[name .. "Name"]:SetShadowColor(0, 0, 0, 0)
    _G[name .. "Name"]:SetWidth(self:GetWidth() - 20)

    _G[name .. "StatusText"]:SetFont(BUI.font, 20, nil)
    _G[name .. "AggroHighlight"]:Hide()
    _G[name .. "AggroHighlight"]:SetAlpha(0)
  end
  if name:match("^CompactRaidFrame(.+)") then
    self.healthBar:SetStatusBarTexture(BUI.statusbarTexture)
    self.powerBar:SetStatusBarTexture(BUI.statusbarTexture)

    _G[name .. "RoleIcon"]:Show()
    _G[name .. "RoleIcon"]:SetAlpha(1)
    _G[name .. "RoleIcon"]:SetDrawLayer("OVERLAY")
    _G[name .. "RoleIcon"]:ClearAllPoints()
    _G[name .. "RoleIcon"]:SetPoint("TOPLEFT", self, "TOPLEFT", 4, -5.5)

    _G[name .. "Name"]:ClearAllPoints()
    _G[name .. "Name"]:SetPoint("TOPLEFT", self, "TOPLEFT", 20, -6)
    _G[name .. "Name"]:SetFont(BUI.font, 11, "OUTLINE")
    _G[name .. "Name"]:SetShadowOffset(0, 0)
    _G[name .. "Name"]:SetShadowColor(0, 0, 0, 0)
    _G[name .. "Name"]:SetWidth(self:GetWidth() - 20)


    _G[name .. "AggroHighlight"]:Hide()
    _G[name .. "AggroHighlight"]:SetAlpha(0)
  end
end)
