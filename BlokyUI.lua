local LSM = LibStub("LibSharedMedia-3.0")

LSM:Register("font", "BlokyUIBold", [[Interface\AddOns\BlokyUI\Media\Fonts\Inter-Bold.ttf]])
LSM:Register("statusbar", "Blank", [[Interface\AddOns\BlokyUI\Media\Textures\Blank.tga]])

BUI = {
  font = LSM:Fetch("font", "BlokyUIBold"),
  statusbarTexture = LSM:Fetch("statusbar", "Blank"),
  colors = {
    friendly = {
      r = 0.05,
      g = 0.7,
      b = 0.05
    },
    enemy = {
      r = 0.9,
      g = 0.2,
      b = 0.2
    }
  },
  getUnitColor = function(unit)
    if UnitPlayerControlled(unit) then
      local _, classFileName = UnitClass(unit)
      local r, g, b = GetClassColor(classFileName)
      return r, g, b
    elseif UnitIsFriend("player", unit) then
      return BUI.colors.friendly.r, BUI.colors.friendly.g, BUI.colors.friendly.b
    else
      return BUI.colors.enemy.r, BUI.colors.enemy.g, BUI.colors.enemy.b
    end
  end,
}

BlokyUI = CreateFrame("Frame", "BlokyUI");
BlokyUI:RegisterEvent("ADDON_LOADED");
