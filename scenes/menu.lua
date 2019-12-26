local composer = require("composer")
local scene = composer.newScene()
local dialog = composer.getVariable("dialog")
local widget = require("widget")
local json = require("json")

function scene:show(event)
  local sceneGroup = self.view
  if event.phase == "did" then
    startButtonGroup = display.newGroup()
    
    local startButton = display.newRoundedRect(startButtonGroup, display.contentCenterX, display.contentCenterY - 100, 250, 75, 20)
  startButton:setFillColor(65 / 255, 22 / 255, 107 / 255)

  local startButtonText = display.newText(startButtonGroup, "НАЧАТЬ НОВУЮ ИГРУ", startButton.x, startButton.y, native.systemFontBold, 20)
  
  local exitButtonGroup = display.newGroup()
  
  local exitButton = display.newRoundedRect(exitButtonGroup, display.contentCenterX, display.contentCenterY + 100, 250, 75, 20)
  exitButton:setFillColor(65 / 255, 22 / 255, 107 / 255)

  local exitButtonText = display.newText(exitButtonGroup, "ВЫХОД", exitButton.x, exitButton.y, native.systemFontBold, 20)
    
  sceneGroup:insert(exitButtonGroup)
    
  exitButton:addEventListener("touch",
    function(event)
      if event.phase == "ended" then
        local params = {
          x = display.contentCenterX,
          y = display.contentCenterY,
          height = 200,
          width = 350,
          radius = 20,
          header = "ВНИМАНИЕ",
          body = "Вы действительно хотите выйти?",
          windowcolor = {0, .2, 0},
          textcolor = {1, 1, .4},
          font = native.systemFontBold,
          fontsize = 20,
          answers = {{"Нет"},
            {"Да", onClick = function(event)
              if event.phase == "ended" then
                native.requestExit()
              end
              return true
            end}},
        answerscolor = {1, 1, 1}
        }
        dialog(params)
      end
      return true
        end)
  end
end
scene:addEventListener("show", scene)
return scene