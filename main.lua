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
  local answersCount = 0
  for i = 1, table.count(params.answers) do
    drawAnswers[i] = display.newText(group, params.answers[i][1], x, window.contentBounds.yMax - params.radius, params.font, params.fontsize)
    drawAnswers[i].x = x - drawAnswers[i].width
    drawAnswers[i]:setFillColor(unpack(params.answerscolor, 1, 3))
    
    if params.answers[i].onClick then
      drawAnswers[i]:addEventListener("touch", params.answers[i].onClick)
    else
      drawAnswers[i]:addEventListener("touch", function(event)
          if event.phase == "ended" then
            group:removeSelf()
          end
          display.getCurrentStage():setFocus(nil)
          return true
        end)
    end
    answersCount = i
  end
  
  for i = 2, answersCount do
    drawAnswers[i - 1].x = drawAnswers[i].contentBounds.xMax + drawAnswers[i].width
  end

--  local preCloseButton =  graphics.newTexture({type = "image", filename = "resources.images.closeButton.png"})

  if params.isCloseButton then
    local closeButton = display.newImage("resources/images/closeButton.png", window.width, window.height)
  end
end

composer.setVariable("dialog", dialog)
composer.gotoScene("scenes.menu")