local Actionbars = BlokyUI:NewModule("Actionbars")

function Actionbars:OnEnable()
  local EventFrame = CreateFrame("Frame")

  local Bars = {
    _G["MultiBarBottomLeft"],
    _G["MultiBarBottomRight"],
    _G["MultiBarRight"],
    _G["MultiBarLeft"],
    _G["MultiBarRight"],
    _G["MultiBar5"],
    _G["MultiBar6"],
    _G["MultiBar7"],
  }

  EventFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
  EventFrame:RegisterEvent("UPDATE_BINDINGS")

  function Init()
    for j = 1, #Bars do
      local Bar = Bars[j]
      if Bar then
        -- for k, v in pairs(Bar) do
        --   print(k, v)
        -- end


        local Num = Bar.numButtonsShowable
        StyleAction(Bar, Num)
      end
    end

    local DefaultActionBarShowable = _G["MainMenuBar"].numButtonsShowable

    for i = 1, DefaultActionBarShowable do
      local Button = _G["ActionButton" .. i]

      UpdateHotkeys(Button)

      StyleButton(Button, "Actionbar")
    end

    for i = 1, 10 do
      local StanceButton = _G["StanceButton" .. i]
      local PetButton = _G["PetActionButton" .. i]

      UpdateHotkeys(StanceButton)
      UpdateHotkeys(PetButton)
      StyleButton(StanceButton, "StanceOrPet")
      StyleButton(PetButton, "StanceOrPet")
    end
  end

  function StyleAction(Bar, Num)
    for i = 1, Num do
      local Name = Bar:GetName()
      local Button = _G[Name .. "Button" .. i]

      StyleButton(Button, "Actionbar")
      UpdateHotkeys(Button)
    end
  end

  function StyleButton(Button, Type)
    if Button:IsProtected() and InCombatLockdown() then
      return
    end
    local Name = Button:GetName()
    local NormalTexture = _G[Name .. "NormalTexture"]
    local Icon = _G[Name .. "Icon"]
    local Cooldown = _G[Name .. "Cooldown"]

    NormalTexture:SetTexture(nil)
    NormalTexture:Hide()
    Icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)

    if Button.SlotBackground then
      Button.SlotBackground:Hide()
    end

    if Button.Border then
      Button.Border:Hide()
    end

    if Button.CheckedTexture then
      Button.CheckedTexture:SetColorTexture(1, 1, 0, 0.3)
      Button.CheckedTexture:SetSize(Button:GetWidth() + 1, Button:GetHeight() + 1)
    end

    -- on hover
    Button.HighlightTexture:ClearAllPoints()
    Button.HighlightTexture:SetPoint("TOPLEFT", Button, "TOPLEFT", 0, 0)
    Button.HighlightTexture:SetColorTexture(0, 0, 0, 0.25)
    Button.HighlightTexture:SetSize(Button:GetWidth() + 1, Button:GetHeight() + 1)

    -- on click
    Button.PushedTexture:ClearAllPoints()
    Button.PushedTexture:SetPoint("TOPLEFT", Button, "TOPLEFT", 0, 0)
    Button.PushedTexture:SetColorTexture(0, 0, 0, 0.5)
    Button.PushedTexture:SetSize(Button:GetWidth() + 1, Button:GetHeight() + 1)

    if Button.IconMask then
      Button.IconMask:ClearAllPoints()
      Button.IconMask:SetPoint("TOPLEFT", Button, "TOPLEFT", -9, 8)
      Button.IconMask:SetPoint("BOTTOMRIGHT", Button, "BOTTOMRIGHT", 11, -10)
    end

    Cooldown:ClearAllPoints()
    Cooldown:SetPoint("TOPLEFT", Button, "TOPLEFT", 0, 0)
    Cooldown:SetPoint("BOTTOMRIGHT", Button, "BOTTOMRIGHT", 0, 0)

    Button.shadow = CreateFrame("Frame", nil, Button)
    Button.shadow:SetSize(Button:GetWidth() + 1, Button:GetHeight() + 1)
    Button.shadow:SetPoint("TOPLEFT", Button, "TOPLEFT", 0, 0)
    Button.shadow:SetFrameLevel(Button:GetFrameLevel() - 1)

    local texture = Button.shadow:CreateTexture()
    texture:SetAllPoints()
    texture:SetColorTexture(0, 0, 0, 1)
  end

  function UpdateHotkeys(Button)
    if Button:IsProtected() and InCombatLockdown() then
      return
    end

    local Name = Button:GetName()
    local HotKey = _G[Name .. "HotKey"]
    local Macro = _G[Name .. "Name"]
    local Count = _G[Name .. "Count"]

    Count:SetFont(BlokyUI.font, 12, "OUTLINE")

    HotKey:SetFont(BlokyUI.font, 12, "OUTLINE")
    HotKey:ClearAllPoints()
    HotKey:SetPoint("TOPRIGHT", Button, "TOPRIGHT", -Button:GetWidth() / 20, -Button:GetHeight() / 8)
    HotKey:SetAlpha(1)

    Macro:SetFont(BlokyUI.font, 10, "OUTLINE")
    Macro:ClearAllPoints()
    Macro:SetPoint("BOTTOMLEFT", Button, "BOTTOMLEFT", 2, Button:GetHeight() / 8)
    Macro:SetPoint("BOTTOMRIGHT", Button, "BOTTOMRIGHT", 0, Button:GetHeight() / 8)
    Macro:SetWidth(Button:GetWidth() - 2)
    Macro:SetJustifyH("CENTER")
    Macro:SetAlpha(1)
  end

  EventFrame:SetScript("OnEvent", Init)
end
