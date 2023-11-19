pico-8 cartridge // http://www.pico-8.com
version 41
__lua__

timer = 21
actual_time = 1200

buttpress = false

level = "bbbbbbbb"

function _init()
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
 beat_s={}

 j = 0

  for i = 1,8 do
   j+=1
   chr=sub(lvl,i,i)
   if chr == "b" then
    last = "b"
    add(beat_x, ( (j-1) + -10 ) * ( beat.w + 2 ) )
    add(beat_y, 76 + flr ( (j-1) / 11 ) * ( beat.h + 2 ) )
    add(beat_v, true)
    add(beat_s, 1)
   else if chr == "a" then
    last = "a"
    add(beat_x, ( (j-1) + -10 ) * ( beat.w + 2 ) )
    add(beat_y, 76 + flr ( (j-1) / 11 ) * ( beat.h + 2 ) )
    add(beat_v, true)
    add(beat_s, 2)
   end
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
  spr(beat_s[i],beat_x[i],beat_y[i],beat_x[i]+beat.h,beat_x[i]+beat.w)
   -- beat looping if not hit
   if beat_x[i] > 128 then
    beat_x[i] = -4
   end
   -- beat hit range
   if beat_x[i] >= 59 and beat_x[i] <= 65 and btn(❎) then
    sfx(5)
    beat_v[i] = false
    score += 1
   -- incorrect beat hit
   else if beat_x[i] >= 65 and btn(❎) then
    sfx(4)
    score -= 1
    beat_v[i] = false
   end
   end
  end
  beat_x[i] += beat.dx
 end
 --player ❎ circle
 circ(63,102,5,7)
 --beat circle
 circ(63,80,4,7)
 print("timer: "..flr(timer),5,5,7)
 print("score: "..score,50,5,7)
end

function draw_gameover()
 mode = "gameover"
 cls(2)
 print("game over",45,60,7)
end
__gfx__
00000000042000000303000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000009a000000040000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700a9aa00000888000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000aa9aa0008788800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000770009aa9aa008888200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0070070009aa9a008888200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000009aa0000882000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__sfx__
1c1000200f4240f4240f4240f4240f4250f4250f42516425164251642516425164251d4251d4251d4251d4251d4241d4241d42413424134251342513425134251342513425134251842518424184241842418424
1e1000202742127421274212742127421274212742116421164221642216422164221d4221d4221d4221d4221d4261d4261d42605426054260542605426054260542605426054261842618426184261842618424
021000001d2751d2751d2751d2031d2031d2030f2730f2730f2731d2031d2031d2031227512275122751d2031d2031d2031827318273182731827318273182731820318203182030f2750c2750a2750727505275
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000100002705024050220501f0501d0501b0501805016050000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0001000016050180501b0501d0501f050220502405027050000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__music__
03 00010244



