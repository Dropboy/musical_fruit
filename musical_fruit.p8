pico-8 cartridge // http://www.pico-8.com
version 41
__lua__
local timer = 21
local actual_time = 1200
local buttpress = false
local mode = "start"


function _init()
 music(0)
 beat={}
 beat.x = -12
 beat.y = 80
 beat.dx = 0
 beat.dy = 15
 
 score = 0
end

function _update60()
 timerandcountdown()
	if mode == "start" then
  draw_start()
  if btnp(❎) then
   mode = "game"
  end
 elseif mode == "game" then
  update_game()
  draw_game()
  btnprs()
 elseif mode == "gameover" then
  if btnp(❎) then
   mode = "start"
   timer = 21
   actual_time = 1200
  end
 end
end

--checking if button ❎ has been pressed
function btnprs()
 if btn(❎) then
  buttpress = true
  print("❎",60,100,7)
 else
  buttpress = false
 end
end

--timer and countdown leading to gameover
function timerandcountdown()
 if actual_time <= 0 then
  timer = 0
  actual_time = 0
  draw_gameover()
  mode = "gameover"
 end
end

function update_game()

 if buttpress == true and beat.dx == 60 then
  score += 1
 end
 -- beat animation looping
 if beat.dx < 140 then
  beat.dx += 1
 else
  beat.dx = 0
 end
 -- timer counts down from 20
 if timer > 0 then
  timer -= 1/60
 end
 actual_time -= 1
end

function draw_start()
 cls(2)
 print("press x to start game",23,60,7)
end

function draw_game()
 cls(2)
 print(flr(timer),5,5,7)
 print(score,25,5,7)
 print(beat.dx,60,5,7)
 draw_beat()
end

function draw_beat()
 rect(beat.x+beat.dx,beat.y,(beat.x+12)+beat.dx,beat.y+12,7)
end

function draw_gameover()
 mode = "gameover"
 cls(2)
 print("game over",45,60,7)
end
__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__sfx__
000c002024450213002d450233002d450243001e45025300174502630024400213002d400233002d4002430024450213002d450233002d450243001e450250001745025000251000000000000000000000000000
__music__
03 00424344

