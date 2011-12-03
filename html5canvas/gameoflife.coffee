$ ->
  cellPixels = 8
  width = $('#canvas')[0].width / cellPixels
  height = $('#canvas')[0].height / cellPixels
  cells = []
  period = 50

  array2d = ->
    arr = [0..width-1]
    for x in [0..width-1]
      arr[x] = [0..height-1]

  init = ->
    cells = array2d()
    for x in [0..width-1]
      for y in [0..height-1]
        cells[x][y] = Math.random() >= 0.7

  draw = ->
    context = $('#canvas')[0].getContext('2d')
    context.strokeStyle = '#ddd'
    for x in [0..width-1]
      for y in [0..height-1]
        context.fillStyle = if cells[x][y] then '#444' else '#f8f8f8'
        context.fillRect(x*cellPixels, y*cellPixels, cellPixels, cellPixels)
        context.strokeRect(x*cellPixels, y*cellPixels, cellPixels, cellPixels)

  shouldLive = (x, y) ->
    neighbours = 0
    alive = cells[x][y]
    for i in [x-1..x+1]
      for j in [y-1..y+1]
        if (i != x || j != y) && cells[(i+width)%width][(j+height)%height]
          neighbours++
    if alive
      neighbours == 2 || neighbours == 3
    else
      neighbours == 3

  evolve = ->
    draw()
    next = array2d()
    for x in [0..width-1]
      for y in [0..height-1]
        next[x][y] = shouldLive(x, y)
    cells = next
    window.setTimeout evolve, period

  init()
  evolve()

