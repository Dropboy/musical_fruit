pico-8 cartridge // http://www.pico-8.com
version 41
__lua__
-- constants
local beat_width = 12
local beat_height = 12
local beat_speed = 2
local beat_gap = 20
local beat_margin = 10
local beat_target = 60
local beat_tolerance = 1
local score_per_hit = 10
local combo_per_hit = 1
local combo_per_miss = -2
local health_per_hit = 0
local health_per_miss = 0
local max_health = 10
local min_health = 0
local game_over_delay = 60

-- variables
local timer = 21
local actual_time = 1200
local buttpress = false
local mode = "start"
local score = 0
local combo = 0
local health = max_health
local game_over_timer = 0
local beats = {}
local music_track = 0
local sfx_hit = 0
local sfx_miss = 1

function _init()
 -- initialize beats
 beats[1] = {}
 beats[1].x = -beat_width
 beats[1].y = 80
 beats[1].color = 7
 beats[2] = {}
 beats[2].x = - beat_width - beat_gap
 beats[2].y = 80
 beats[2].color = 8
 beats[3] = {}
 beats[3].x = -beat_width - beat_gap * 2
 beats[3].y = 80
 beats[3].color = 9
end

function _update60()
 timerandcountdown()
 if mode == "start" then
  draw_start()
  if btnp(❎) then
   mode = "game"
   music(music_track)
  end
 elseif mode == "game" then
  update_game()
  draw_game()
  btnprs()
 elseif mode == "gameover" then
  update_gameover()
  draw_gameover()
  if btnp(❎) then
   mode = "start"
   timer = 21
   actual_time = 1200
   score = 0
   combo = 0
   health = max_health
   game_over_timer = 0
   reset_beats()
  end
 end
end

--checking if button ❎ has been pressed
function btnprs()
 if btn(❎) then
  buttpress = true
  print("❎",60,100,7)
  check_hit()
 else
  buttpress = false
 end
end

--timer and countdown leading to gameover
function timerandcountdown()
 if actual_time <= 0 then
  timer = 0
  actual_time = 0
  mode = "gameover"
 end
end

function update_game()
 -- update beats
 for i=1,#beats do
  beats[i].x += beat_speed
  if beats[i].x > 128 then
   beats[i].x = -beat_width
   score += health_per_miss
   health += health_per_miss
   combo += combo_per_miss
   sfx(sfx_miss)
  end
 end
 -- update timer
 if timer > 0 then
  timer -= 1/60
 end
 actual_time -= 1
 -- update health
 if health > max_health then
  health = max_health
 end
 if health < min_health then
  health = min_health
  mode = "gameover"
 end
end

function update_gameover()
 -- update game over timer
 if game_over_timer < game_over_delay then
  game_over_timer += 1
 else
  music(-1)
 end
end

function draw_start()
 cls(2)
 print("press x to start game",23,60,7)
end

function draw_game()
 cls(2)
 print(flr(timer),5,5,7)
 print(score,25,5,7)
 print(combo,45,5,7)
 print(health,65,5,7)
 for i=1,#beats do
  draw_beat(i)
 end
end

function draw_beat(i)
 rect(beats[i].x,beats[i].y,(beats[i].x+beat_width),beats[i].y+beat_height,beats[i].color)
end

function draw_gameover()
 cls(2)
 print("game over",45,60,7)
end

function check_hit()
 -- check if any beat is within the target range
 local hit = false
 for i=1,#beats do
  if abs(beats[i].x - beat_target) < beat_tolerance then
   hit = true
   score += score_per_hit
   combo += combo_per_hit
   health += health_per_hit
   sfx(sfx_hit)
   beats[i].x = -beat_width
  end
 end
 if not hit then
  score += health_per_miss
  health += health_per_miss
  combo += combo_per_miss
  sfx(sfx_miss)
 end
end

function reset_beats()
 -- reset the beats to their initial positions
 beats[1].x = -beat_width
 beats[2].x = -beat_width - beat_gap
 beats[3].x = -beat_width - beat_gap * 2
end

__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
