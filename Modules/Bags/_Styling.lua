local Module = BlokyUI:NewModule("Bags.Styling");
local MSQ = LibStub("Masque", true)
local MSQ_Bag = MSQ:Group("BlokyUI", "Bags")
-- all credits due to the author of SUI
function Module:OnEnable()

  for i = 1, 6 do
    local bag = _G["ContainerFrame" .. i]
    if bag then
      for j = 1, 40 do
        local slot = _G["ContainerFrame" .. i .. "Item" .. j]

        if slot then
          MSQ_Bag:AddButton(slot)
          local tooltipData = C_TooltipInfo.GetBagItem(i, j)


          if tooltipData then
            -- for k, v in pairs(tooltipData.lines[2].args[2]) do
            --   print(k, v)
            -- end
            for x = 2, 3 do
              local msg = tooltipData.lines[2].args[x].leftText

              print(msg)
            end
          end
          -- set ilvl text


        end
      end
    end
  end
end
