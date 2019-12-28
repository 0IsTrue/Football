local composer = require("composer")
 
display.setStatusBar(display.HiddenStatusBar)
 
function table.count(table)
  local count = 0
    for _ in pairs(table) do
      count = count + 1
    end
  return count
end

local function dialog(params)
  local group = display.newGroup()
  
  local window = display.newRoundedRect(group, params.x, params.y, params.width, params.height, params.radius)
  window:setFillColor(unpack(params.windowcolor, 1, 3))
 
  local header = display.newText(group, params.header, window.x, window.contentBounds.yMin + params.radius, params.font, params.fontsize)
  header:setFillColor(unpack(params.textcolor, 1, 3))
 
  local body = display.newText(group, params.body, window.x, window.y, params.font, params.fontsize)
  body:setFillColor(unpack(params.textcolor, 1, 3))
 
  local drawAnswers = {}
  local x = window.x
  local answersCount = answersCount == table.count(params.answers) and table.count(params.answers) <= 2 or 2
  
  for i = 1, answersCount do
    drawAnswers[i] = display.newText(group, params.answers[i][1], x, window.contentBounds.yMax - params.radius, params.font, params.fontsize)
    if i == 1 then
      drawAnswers[i].x = x - drawAnswers[i].width
  else
      drawAnswers[i].x = x + drawAnswers[i].width
    end
   
    drawAnswers[i]:setFillColor(unpack(params.answerscolor, 1, 3))
   
    local function onClick(event)
      if params.answers[i].onClick then
        drawAnswers[i]:addEventListener("touch", params.answers[i].onClick)
      end
     
      display.getCurrentStage():setFocus(nil)
     
      if event.phase == "ended" then
        group:removeSelf()
      end
      return true
    end
   
    drawAnswers[i]:addEventListener("touch", onClick)
  end
 
  --drawAnswers[1].x = drawAnswers[2].contentBounds.xMax + drawAnswers[1].width
 
--  local preCloseButton =  graphics.newTexture({type = "image", filename = "resources.images.closeButton.png"})
 
  if params.isCloseButton then
    local closeButton = display.newImage("resources/images/closeButton.png", window.width, window.height)
  end
end

composer.gotoScene("scenes.menu")