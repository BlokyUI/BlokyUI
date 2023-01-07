local function handleTargetFrame(self, event)
  self.name:ClearAllPoints()
  self.name:SetFont(BUI.font, 10, "OUTLINE")
  self.name:SetJustifyH("CENTER")
  self.name:SetPoint("CENTER", self.healthbar, "CENTER", 0, 0)
  self.name:SetTextColor(1.0, 1.0, 1.0, 1.0)
  self.name:SetShadowOffset(0, 0)

  self.healthbar:SetFrameLevel(1)
  self.TargetFrameContent:SetFrameLevel(1)

  self.TargetFrameContent.TargetFrameContentContextual:Hide()
  self.TargetFrameContent.TargetFrameContentMain.LevelText:Hide()
  self.TargetFrameContent.TargetFrameContentMain.LevelText:SetAlpha(0)
  self.TargetFrameContainer:Hide()
  self.healthbar.HealthBarMask:Hide()

  -- hide damage text on portrait
  self.portrait:Hide()

  self.TargetFrameContent.TargetFrameContentMain.ReputationColor:Hide()

  local width = 200
  local healthBarHeight = 38
  local manabarHeight = 10
  local totalFrameHeight = healthBarHeight + manabarHeight
  self:SetSize(width + 48, totalFrameHeight * 2 - 5)

  self.healthbar:ClearAllPoints();
  self.healthbar:SetPoint("TOPLEFT", self, "TOPLEFT", 24, -21.5)

  --   -- health bar styling
  -- self.healthbar:SetPoint("TOPLEFT", self, "TOPLEFT", 0, 0)
  -- self.TargetFrameContent:ClearAllPoints()
  -- self.TargetFrameContent:SetPoint("TOPLEFT", self, "TOPLEFT", 40, 0)
  self.healthbar:SetSize(width, healthBarHeight)
  self.healthbar.HealthBarMask:SetSize(width, healthBarHeight)
  self.healthbar:SetStatusBarTexture(BUI.statusbarTexture)

  local r, g, b = BUI.getUnitColor(self.unit)
  self.healthbar:SetStatusBarColor(r, g, b)

  self.healthbar.LeftText:SetPoint("RIGHT", self.healthbar, "RIGHT", -8, 0);
  self.healthbar.LeftText:SetJustifyH("RIGHT")
  self.healthbar.LeftText:SetFont(BUI.font, 10, "OUTLINE")
  self.TargetFrameContent.TargetFrameContentMain.HealthBar.TotalAbsorbBar:SetTexture(BUI.statusbarTexture)
  self.TargetFrameContent.TargetFrameContentMain.HealthBar.OverAbsorbGlow:SetAlpha(0)

  if TargetFrameBackground == nil then
    CreateFrame("StatusBar", "TargetFrameBackground",
      self.TargetFrameContent.TargetFrameContentMain)
  end

  local borderSize = 2
  -- -- Set the size and position of the frame
  TargetFrameBackground:SetPoint("TOPLEFT", self.healthbar, "TOPLEFT", -2, 2.5)
  TargetFrameBackground:SetWidth(width + borderSize * 2 + .5)
  TargetFrameBackground:SetHeight(totalFrameHeight + 5)
  TargetFrameBackground:SetStatusBarTexture(BUI.statusbarTexture)
  TargetFrameBackground:SetStatusBarColor(0, 0, 0, 1)
  TargetFrameBackground:SetFrameLevel(0)

  self.healthbar.RightText:SetPoint("LEFT", self.healthbar, "LEFT", 8, 0);
  self.healthbar.RightText:SetJustifyH("LEFT")
  self.healthbar.RightText:SetFont(BUI.font, 10, "OUTLINE")

  if self.healthbar.DeadText ~= nil then
    self.healthbar.DeadText:SetPoint("LEFT", self.healthbar, "LEFT", 8, 0);
  end

  -- manabar styling
  self.manabar:SetSize(width, manabarHeight)
  self.manabar.ManaBarMask:Hide()
  self.manabar:ClearAllPoints()
  self.manabar:SetPoint("TOPLEFT", self.healthbar, "BOTTOMLEFT", 0, 0)
  self.manabar:SetStatusBarTexture(BUI.statusbarTexture)
  self.manabar.LeftText:SetFont(BUI.font, 8, "OUTLINE")
  self.manabar.LeftText:SetJustifyH("LEFT")
  self.manabar.LeftText:SetPoint("LEFT", self.manabar, "LEFT", 1, -0.49);
  self.manabar.LeftText:SetShadowOffset(0, 0)
  self.manabar.RightText:SetFont(BUI.font, 8, "OUTLINE")
  self.manabar.RightText:SetJustifyH("RIGHT")
  self.manabar.RightText:SetPoint("RIGHT", self.manabar, "RIGHT", 0, -0.49);
  self.manabar.RightText:SetShadowOffset(0, 0)
  -- local power = self.manabar.powerToken

  --   -- the mana bar texture resets sometimes, so this is needed to make sure the texture stays the same
  --   hooksecurefunc("UnitFrameManaBar_UpdateType", function(manabar)
  --     if manabar.unit ~= "player" then return end
  --     manabar:SetStatusBarTexture(BUI.statusbarTexture)
  --     local color = PowerBarColor[self.manabar.powerToken]
  --     self.manabar:SetStatusBarColor(color.r, color.g, color.b)
  --   end)

  --   -- disable the mana bar animations
  -- self.TargetFrameContent.TargetFrameContentMain.ManaBar:Hide()
  -- self.TargetFrameContent.TargetFrameContentMain.ManaBar.FeedbackFrame:Hide()
  -- self.TargetFrameContent.TargetFrameContentMain.ManaBar.FullPowerFrame:Hide()

  self.manabar:Show()
  self.manabar:SetStatusBarTexture(BUI.statusbarTexture)
  self.TargetFrameContent.TargetFrameContentMain.ManaBar.texture:SetTexture(BUI.statusbarTexture)
  local powerColor = GetPowerBarColor(self.manabar.powerType)
  if self.manabar.powerType == 0 then
    self.manabar:SetStatusBarColor(0, 0.5, 1)
  else
    self.manabar:SetStatusBarColor(powerColor.r, powerColor.g, powerColor.b)
  end
end

hooksecurefunc(TargetFrame, "Update", function(self)
  handleTargetFrame(self)
end)

local AURA_START_X = -5;
local AURA_START_Y = 0;
local AURAR_MIRRORED_START_Y = -6
local AURA_OFFSET_Y = 3;

hooksecurefunc("TargetFrame_UpdateBuffAnchor",
  function(self, buff, index, numDebuffs, anchorBuff, anchorIndex, size, offsetX, offsetY, mirrorVertically)
    --For mirroring vertically
    local point, relativePoint;
    local startY, auraOffsetY;
    if (mirrorVertically) then
      point = "BOTTOM";
      relativePoint = "TOP";
      startY = AURAR_MIRRORED_START_Y;
      if (self.threatNumericIndicator:IsShown()) then
        startY = startY + self.threatNumericIndicator:GetHeight();
      end
      offsetY = -offsetY;
      auraOffsetY = -AURA_OFFSET_Y;
    else
      point = "TOP";
      relativePoint = "BOTTOM";
      startY = AURA_START_Y;
      auraOffsetY = AURA_OFFSET_Y;
    end

    buff:ClearAllPoints();
    local targetFrameContentContextual = self.TargetFrameContent.TargetFrameContentContextual;
    if (index == 1) then
      if (UnitIsFriend("player", self.unit) or numDebuffs == 0) then
        -- unit is friendly or there are no debuffs...buffs start on top
        buff:SetPoint(point .. "LEFT", self.TargetFrameContainer.FrameTexture, relativePoint .. "LEFT", AURA_START_X,
          startY);
      else
        -- unit is not friendly and we have debuffs...buffs start on bottom
        buff:SetPoint(point .. "LEFT", targetFrameContentContextual.debuffs, relativePoint .. "LEFT", 0, -offsetY);
      end
      targetFrameContentContextual.buffs:SetPoint(point .. "LEFT", buff, point .. "LEFT", 0, 0);
      targetFrameContentContextual.buffs:SetPoint(relativePoint .. "LEFT", buff, relativePoint .. "LEFT", 0, -
        auraOffsetY);
      self.spellbarAnchor = buff;
    elseif (anchorIndex ~= (index - 1)) then
      -- anchor index is not the previous index...must be a new row
      buff:SetPoint(point .. "LEFT", anchorBuff, relativePoint .. "LEFT", 0, -offsetY);
      targetFrameContentContextual.buffs:SetPoint(relativePoint .. "LEFT", buff, relativePoint .. "LEFT", 0, -
        auraOffsetY);
      self.spellbarAnchor = buff;
    else
      -- anchor index is the previous index
      buff:SetPoint(point .. "LEFT", anchorBuff, point .. "RIGHT", offsetX, 0);
    end

    -- Resize
    buff:SetWidth(size);
    buff:SetHeight(size);

    -- custom
    -- local offsetX = 22
    -- local offsetXCurrent = offsetX * (index - 1) + 1
    -- buff:SetSize(18, 18)
    -- buff:ClearAllPoints()

    -- buff:SetPoint("BOTTOMLEFT", TargetFrameBackground, "BOTTOMLEFT", offsetXCurrent, -30 + offsetY)

    buff.Icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
    buff.Icon:SetDrawLayer("BACKGROUND", -6)

    local border = buff.border or
        buff:CreateTexture(buff.border, "BACKGROUND", nil, -7)

    border:SetColorTexture(0, 0, 0, 1)
    border:SetDrawLayer("BACKGROUND", -7)
    border:ClearAllPoints()
    border:SetPoint("TOPLEFT", buff, "TOPLEFT", -1, 1)
    border:SetPoint("BOTTOMRIGHT", buff, "BOTTOMRIGHT", 1, -1)
    buff.border = border

    if buff.Count then
      -- local fontSize = db.unitframes.buffs.size / 2.75
      buff.Count:SetFont(BUI.font, 10, "OUTLINE")
      buff.Count:SetPoint("BOTTOMRIGHT", buff, "BOTTOMRIGHT", 0, 1)
    end
  end)


hooksecurefunc("TargetFrame_UpdateDebuffAnchor",
  function(self, buff, index, numBuffs, anchorBuff, anchorIndex, size, offsetX, offsetY, mirrorVertically)
    local isFriend = UnitIsFriend("player", self.unit);

    --For mirroring vertically
    local point, relativePoint;
    local startY, auraOffsetY;
    if (mirrorVertically) then
      point = "BOTTOM";
      relativePoint = "TOP";
      startY = AURAR_MIRRORED_START_Y;
      if (self.threatNumericIndicator:IsShown()) then
        startY = startY + self.threatNumericIndicator:GetHeight();
      end
      offsetY = -offsetY;
      auraOffsetY = -AURA_OFFSET_Y;
    else
      point = "TOP";
      relativePoint = "BOTTOM";
      startY = AURA_START_Y;
      auraOffsetY = AURA_OFFSET_Y;
    end

    buff:ClearAllPoints();
    local targetFrameContentContextual = self.TargetFrameContent.TargetFrameContentContextual;
    if (index == 1) then
      if (isFriend and numBuffs > 0) then
        -- unit is friendly and there are buffs...debuffs start on bottom
        buff:SetPoint(point .. "LEFT", targetFrameContentContextual.buffs, relativePoint .. "LEFT", 0, -offsetY);
      else
        -- unit is not friendly or there are no buffs...debuffs start on top
        buff:SetPoint(point .. "LEFT", self.TargetFrameContainer.FrameTexture, relativePoint .. "LEFT", AURA_START_X,
          startY);
      end
      targetFrameContentContextual.debuffs:SetPoint(point .. "LEFT", buff, point .. "LEFT", 0, 0);
      targetFrameContentContextual.debuffs:SetPoint(relativePoint .. "LEFT", buff, relativePoint .. "LEFT", 0,
        -auraOffsetY);
      if ((isFriend) or (not isFriend and numBuffs == 0)) then
        self.spellbarAnchor = buff;
      end
    elseif (anchorIndex ~= (index - 1)) then
      -- anchor index is not the previous index...must be a new row
      buff:SetPoint(point .. "LEFT", anchorBuff, relativePoint .. "LEFT", 0, -offsetY);
      targetFrameContentContextual.debuffs:SetPoint(relativePoint .. "LEFT", buff, relativePoint .. "LEFT", 0,
        -auraOffsetY);
      if ((isFriend) or (not isFriend and numBuffs == 0)) then
        self.spellbarAnchor = buff;
      end
    else
      -- anchor index is the previous index
      buff:SetPoint(point .. "LEFT", anchorBuff, point .. "RIGHT", offsetX, 0);
    end

    -- Resize
    buff:SetWidth(size);
    buff:SetHeight(size);
    -- local buffBorder = buff.Border;
    -- buffBorder:SetWidth(size + 2);
    -- buffBorder:SetHeight(size + 2);

    -- custom
    buff.Icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
    buff.Icon:SetDrawLayer("BACKGROUND", -6)

    if buff.Border then
      buff.Border:SetTexture(nil)
    end

    if buff.Count then
      buff.Count:SetFont(BUI.font, 10, "OUTLINE")
      buff.Count:SetPoint("BOTTOMRIGHT", buff, "BOTTOMRIGHT", 0, 1)
    end

    local border = buff.border or
        buff:CreateTexture(buff.border, "BACKGROUND", nil, -7)

    border:SetColorTexture(0.47, 0.12, 0.23, 1)
    border:SetDrawLayer("BACKGROUND", -7)
    border:ClearAllPoints()
    border:SetPoint("TOPLEFT", buff, "TOPLEFT", -1, 1)
    border:SetPoint("BOTTOMRIGHT", buff, "BOTTOMRIGHT", 1, -1)
    buff.border = border
  end)


-- TargetFrameToT


-- hooksecurefunc(FocusFrame, "Update", function(self)
--   healthTexture(self)
-- end)

-- hooksecurefunc(FocusFrameToT, "Update", function(self)
--   healthTexture(self)
-- end)
