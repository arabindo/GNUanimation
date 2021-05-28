# setting up the enviorment
reset 
set term gif animate delay 4 size 854, 480  # You remember, the animation was too fast! ~ _ ~
# So that, we added a delay here. It means a (4*0.01)s gap between every frame(i.e. 1/0.04=25frames/sec)
# Size and delay are optional

set output 'cycloid.gif'

set size ratio -1
set nokey

set title 'Tracing a Cycloid'

set xrange[-pi:9*pi] 
# set maximum range greater than 2*pi*r*number_of_rotation
  
set yrange[0:5] 
# must be grater than radius of circle
# If you do not want to uplift the cirY by the radius, As I've discussed in previous section
# then you must extend the yrange to the negative axis. like from -5 to +5 maybe!

set parametric
  
# setting up the set of functions
cirX(r, i, t) = r*i + r*cos(2*pi-t)
cirY(r, i, t)= r + r*sin(2*pi-t)
px(r, i) = r*i + r*cos(2*pi-i-pi/2)
py(r, i) = r + r*sin(2*pi-i-pi/2)

# Defining the radius and coversion factor
s = 2
conv = pi/180

do for[deg=0:360*2]{

    rad = deg*conv
    
    set title sprintf("Angle: %4.2f (in Rad-Clockwise)", rad)
    # sprintf function is simillar to that of a printf in the C language. 
    # plotting the circle for each instances
    # If you haven't pass three argument, you must pass only s and t through cirY, otherwise there will be an runtime error!
    plot cirX(s, rad, t), cirY(s, rad, t)

    # plot an arrow with nohead(actually the radius). You may ommit the 'nohead' statement
    # Notice that, we plot the arrow from s*rad (linear distance traversed by the circle.)
    set arrow 1 nohead from s*rad, s to px(s, rad), py(s,rad) lc rgb 'red' lw 0.2
      
    # The circle object is a point on a circle. You may like to change the colour!
    set object 2 circle at px(s, rad), py(s, rad) fc rgb 'blue' size 0.3 fs solid front
    
    # plot the trajectory
    set object deg+1 circle at px(s, rad), py(s, rad) fc rgb 'red' size 0.09 fs solid front
    
    # 'deg+1' keep track of the object and once plotted it will not erased in contrast with object 2.
    # This is the general trick to plot the trajectory of a dynamical system.
  }
  
set out

