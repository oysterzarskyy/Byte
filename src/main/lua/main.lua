local blocks = {}
local selected = 1

local function loadBlocks()
  local files = {
    "dirt.png",
    "grass.png",
    "sand.png",
    "stone.png",
    "top-grass.png",
    "top-wood.png",
    "water.png",
    "water2.png",
    "wood-planks.png",
    "wood-side.png",
  }

  for index, fileName in ipairs(files) do
    local path = "assets/blocks/" .. fileName
    local image = love.graphics.newImage(path)
    blocks[index] = {
      name = fileName:gsub("%.png$", ""),
      image = image,
    }
  end
end

function love.load()
  love.window.setTitle("Byte MCPE Blocks")
  love.window.setMode(960, 640)
  love.graphics.setBackgroundColor(0.10, 0.13, 0.18)
  love.graphics.setLineWidth(2)
  loadBlocks()
end

function love.draw()
  love.graphics.setColor(1, 1, 1, 1)
  love.graphics.print("Byte MCPE prototype", 24, 24)
  love.graphics.print("Click a block to inspect it in the panel.", 24, 48)

  local panelX, panelY, panelW, panelH = 24, 92, 360, 500
  love.graphics.setColor(0.16, 0.20, 0.28)
  love.graphics.rectangle("fill", panelX, panelY, panelW, panelH, 18, 18)
  love.graphics.setColor(1, 1, 1, 1)
  love.graphics.print("Selected block", panelX + 18, panelY + 18)

  local selectedBlock = blocks[selected]
  if selectedBlock then
    local imageW, imageH = selectedBlock.image:getDimensions()
    local scale = math.min(200 / imageW, 200 / imageH)
    love.graphics.draw(selectedBlock.image, panelX + 110, panelY + 120, 0, scale, scale)
    love.graphics.printf(selectedBlock.name, panelX + 18, panelY + 340, panelW - 36, "center")
    love.graphics.printf("Using assets/blocks for MCPE-style textures.", panelX + 18, panelY + 380, panelW - 36, "center")
  end

  love.graphics.setColor(0.85, 0.9, 1, 1)
  local startX, startY = 420, 96
  local cellW, cellH = 140, 150
  for index, block in ipairs(blocks) do
    local col = (index - 1) % 4
    local row = math.floor((index - 1) / 4)
    local x = startX + col * cellW
    local y = startY + row * cellH

    local isSelected = (index == selected)
    love.graphics.setColor(isSelected and 0.24 or 0.17, isSelected and 0.38 or 0.22, isSelected and 0.57 or 0.30)
    love.graphics.rectangle("fill", x, y, 120, 120, 12, 12)
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.draw(block.image, x + 18, y + 18, 0, 0.8, 0.8)
    love.graphics.print(block.name, x + 8, y + 100)
  end
end

function love.mousepressed(mx, my, button)
  if button ~= 1 then
    return
  end

  local startX, startY = 420, 96
  local cellW, cellH = 140, 150
  for index, _ in ipairs(blocks) do
    local col = (index - 1) % 4
    local row = math.floor((index - 1) / 4)
    local boxX = startX + col * cellW
    local boxY = startY + row * cellH
    if mx >= boxX and mx <= boxX + 120 and my >= boxY and my <= boxY + 120 then
      selected = index
      break
    end
  end
end
