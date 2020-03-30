# Virus Infection Simulator

There are four states: healthy (white), infected (pink), recovered (grey), and dead (red).
In the default setting, 1% of particles are initially infected by a virus. 
Healthy particles are infected by direct contact with an infected particle with an infection rate. 
After a prespecified number of time steps, infected particles will be recovered. After the same number of time steps, the recovered particles will be healthy which can be infected again.
10% of particles have serious diseases beforehand and will pass away when they are infected by the virus.

## How to run this simulator

1. Download processing from the [official site](https://processing.org).
2. Open [virus_simulator.pde](https://github.com/yusuke-nojima/virus_infection/blob/master/virus_simulator.pde) from processing. And run it. 
3. You can change the speed and infection rate using sliders.

## Simulator without sliders
The simulator with default setting can be run in the openprocessing site. Please also visit [my page](https://www.openprocessing.org/sketch/864455) in openprocessing. 

---
This simulator is inspired by the article [Why outbreaks like coronavirus spread exponentially, and how to “flatten the curve”](https://www.washingtonpost.com/graphics/2020/world/corona-simulator/?fbclid=IwAR1A9D6VUMk7qquvyxQgDlfeqo_CSzUcAMSg2m_7azOnL6Ti9RfKbSDTVPg) on Washington Post.

The code on multiple particles is taken from [the sample code](https://helloacm.com/processing-example-simple-particles/) by helloacm.com.