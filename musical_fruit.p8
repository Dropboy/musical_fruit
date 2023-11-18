pico-8 cartridge // http://www.pico-8.com
version 41
__lua__

timer = 21
actual_time = 1200

buttpress = false

level = "bxbxbxbxbxbx"

function _init()
 music(0)
 beat={}
 beat.h = 8
 beat.w = 8
 beat.r = 4
 beat.x = -12
 beat.y = 80
 beat.dx = 1
 beat.dy = 15
 beat.alive = true
 beat.gap = 0

 score = 0

 build_beat(level)

 mode = "start"
end

function build_beat(lvl)

local i,j,o,chr,last
 beat_x={}
 beat_y={}
 beat_v={}
 beat_c={}

 j = 0

  for i = 1,8 do

   j+=1

   chr=sub(lvl,i,i)
   
   if chr == "b" then
    last = "b"
    add(beat_x, 4 + ( (j-1) % 11 ) * (beat.w + 2 ) )
    add(beat_y, 80 + flr ( (j-1) / 11 ) * ( beat.h + 2 ) )
    add(beat_v, true)
    add(beat_c, 7)
   end
  end
end

function _update60()
 timerandcountdown()
	if mode == "start" then
  draw_start()
  if btnp(❎) then
   mode = "game"
  end
 elseif mode == "game" then
  draw_game()
  update_game()
  btnprs()
 elseif mode == "gameover" then
  if btnp(❎) then
   _init()
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

 -- draw beats
 for i=1,#beat_x do
  if beat_v[i] == true then
   circfill(beat_x[i],beat_y[i],beat.r,beat_c[1])
   if beat_x[i] > 128 then
    beat_x[i] = -4
   end
   if beat_x[i] >= 60 and beat_x[i] <= 70 and btn(❎) then
    beat_v[i] = false
    beat_c[i] = 8
    score += 1
   end 
  end
  beat_x[i] += beat.dx
 end
 circ(63,102,5,7)
 circ(63,80,5,7)
 print(flr(timer),5,5,7)
 print(score,25,5,7)
 print(buttpress,60,5,7)
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

