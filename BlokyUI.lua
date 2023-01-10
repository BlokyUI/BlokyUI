BlokyUI = LibStub("AceAddon-3.0"):NewAddon("BlokyUI", "AceEvent-3.0")
function BlokyUI:OnInitialize()
  local LSM = LibStub("LibSharedMedia-3.0")
  LSM:Register("font", "BlokyUIBold", [[Interface\AddOns\BlokyUI\Media\Fonts\Inter-Bold.ttf]])
  LSM:Register("statusbar", "Blank", [[Interface\AddOns\BlokyUI\Media\Textures\Blank.tga]])

  self.font = LSM:Fetch("font", "BlokyUIBold")
  self.statusbarTexture = LSM:Fetch("statusbar", "Blank")
  self.colors = {
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
  }
  self.getUnitColor = function(unit)
    if UnitPlayerControlled(unit) then
      local _, classFileName = UnitClass(unit)
      local r, g, b = GetClassColor(classFileName)
      return r, g, b
    elseif UnitIsFriend("player", unit) then
      return BlokyUI.colors.friendly.r, BlokyUI.colors.friendly.g, BlokyUI.colors.friendly.b
    else
      return BlokyUI.colors.enemy.r, BlokyUI.colors.enemy.g, BlokyUI.colors.enemy.b
    end
  end
end
