#!/usr/bin/ruby
require 'ruby2d'
set title: "Dunker"
set height: 800
fundo = Image.new(
  './img/fundo.png',
  x: 0,
  y: 0,
  z: 0
)
 
$alvo = Circle.new(
   x: 450, y: 250, z: 10,
   radius: 15,
   #sectors: 32,
   color: 'fuchsia'
   )
   
def mexe_alvo
  $alvo.x = 450
  $alvo.y = 250
  x_vel = 0
  y_vel = 0
  update do
   if (x_vel < 10 && y_vel == 0) then
    x_vel += 1 
    $alvo.x += x_vel
    $alvo.y += y_vel
   elsif (y_vel < 10 && x_vel == 10) then
    y_vel += 1
    $alvo.y += y_vel
   elsif (y_vel == 10 && x_vel > 0) then
    x_vel -= 1
    $alvo.x -= (10 - x_vel)
   else
    y_vel -= 1
    $alvo.y -= (10 - y_vel)
   end 
  end
end
a = Sprite.new(
  './img/sprite_2.png',
  x: 130,
  y: 150,
  z: 10,
  clip_width: 200,
  time: 300,
  loop: true
)
a.play
plataforma = Rectangle.new(
  x: 160,
  y: 370,
  z: 10,
  width: 150,
  height: 20,
  color: 'gray'
)
balde = Sprite.new(
  './img/sprite_1.png',
  x: 100,
  y: 400,
  z: 10,
  clip_width: 277,
  time: 200,
  loop: true
)
balde.play
on :mouse_down do |event|
  if $alvo.contains?(event.x, event.y) then
    a.remove
    balde.remove
    plataforma.remove
    $alvo.remove
    a_agua = Sprite.new(
     './img/sprite_3.png',
      x: 100, 
      y: 400,
      z: 10,
      clip_width: 277,
      time: 200,
      loop: false,
      speed: 2
    )
   $boiando = false
   a_agua.play
   t = Time.now
   tempo1 = t.strftime("%S").to_i
   update do 
      t2 = Time.now
      tempo2 = t2.strftime("%S").to_i
      if ((((tempo2 >= tempo1 + 2) && (tempo1 < 58)) || ((tempo2 == 0) && (tempo1 == 58)) || (tempo2 == 1 && tempo1 == 59 )) && ($boiando == false)) then
          a_agua.remove
           a_boiando = Sprite.new(
          './img/sprite_4.png',
          x: 100,
          y: 327,
          z: 10,
          clip_width: 277,
          time: 300,
          loop: true
          )
          a_boiando.play
          $boiando = true 
          btn_jogar = Rectangle.new(
          x: 428,
          y: 100,
          z: 5,
          width: 200,
          height: 50,
          color: 'green'
          )
          txt_jogar = Text.new(
          'Jogar Novamente',
          x: 433,
          y: 113,
          z: 6,
          size: 20,
          style: 'bold',
          color: 'white'         
          )
          on :mouse_down do |event1|
              if btn_jogar.contains?(event1.x, event1.y) then
                a_boiando.remove
                balde.add
                a.add
                plataforma.add
                btn_jogar.remove
                txt_jogar.remove
                $alvo.add
                mexe_alvo
              end
           end 
      end
   end
  end
end
mexe_alvo
show
