hooksecurefunc("CompactUnitFrame_UpdateAll", function(self)
  local name = self:GetName()
  if name == nil then return end
  if name:match("^CompactPartyFrame(.+)") then
    self.healthBar:SetStatusBarTexture(BUI.statusbarTexture)
    self.powerBar:SetStatusBarTexture(BUI.statusbarTexture)

    _G[name .. "StatusText"]:SetFont(BUI.font, 20, nil)
    _G[name .. "AggroHighlight"]:Hide()
    _G[name .. "AggroHighlight"]:SetAlpha(0)
  end
  if name:match("^CompactRaidFrame(.+)") then
    self.healthBar:SetStatusBarTexture(BUI.statusbarTexture)
    self.powerBar:SetStatusBarTexture(BUI.statusbarTexture)

    -- _G[name .. "RoleIcon"]:ClearAllPoints()
    -- _G[name .. "RoleIcon"]:SetPoint("TOPLEFT", self, "TOPLEFT", 4, -2)
    -- _G[name .. "Name"]:ClearAllPoints()
    -- _G[name .. "Name"]:SetPoint("TOPLEFT", self, "TOPLEFT", 18, -2)
    -- _G[name .. "Name"]:SetPoint("TOPRIGHT", self, "TOPRIGHT", 18, -2)



    _G[name .. "AggroHighlight"]:Hide()
    _G[name .. "AggroHighlight"]:SetAlpha(0)
  end
end)
