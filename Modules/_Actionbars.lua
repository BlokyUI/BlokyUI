local Actionbars = BlokyUI:NewModule("Actionbars")
local MSQ = LibStub("Masque", true)
local MSQ_Bars = MSQ:Group("BlokyUI", "Bars")

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
        local Num = Bar.numButtonsShowable
        StyleAction(Bar, Num)
      end
    end

    local DefaultActionBarShowable = _G["MainMenuBar"].numButtonsShowable

    for i = 1, DefaultActionBarShowable do
      local Button = _G["ActionButton" .. i]

      StyleButton(Button, "Actionbar")
      UpdateHotkeys(Button)
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
    MSQ_Bars:AddButton(Button)
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
    Count:ClearAllPoints()
    Count:SetPoint("BOTTOMRIGHT", Button, "BOTTOMRIGHT", -Button:GetWidth() / 20, Button:GetHeight() / 8)
    Count:SetAlpha(1)

    HotKey:SetFont(BlokyUI.font, 12, "OUTLINE")
    HotKey:SetTextColor(1, 1, 1)
    HotKey:ClearAllPoints()
    HotKey:SetPoint("TOPRIGHT", Button, "TOPRIGHT", -Button:GetWidth() / 20, -Button:GetHeight() / 8)
    HotKey:SetAlpha(1)

    Macro:SetFont(BlokyUI.font, 10, "OUTLINE")
    Macro:ClearAllPoints()
    Macro:SetPoint("BOTTOMLEFT", Button, "BOTTOMLEFT", 2, Button:GetHeight() / 10)
    Macro:SetPoint("BOTTOMRIGHT", Button, "BOTTOMRIGHT", 0, Button:GetHeight() / 10)
    Macro:SetWidth(Button:GetWidth() - 2)
    Macro:SetJustifyH("CENTER")
    Macro:SetAlpha(1)
  end

  EventFrame:SetScript("OnEvent", Init)
end
