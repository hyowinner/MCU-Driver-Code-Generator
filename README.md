# MCU-Driver-Code-Generator
This project is a software package plugin MATLAB/Simulink that can work as a toolbox to generate driver code for a series of MCU. It seperate each driver modules into different blocks such as watch dog, IO, register read, register write, clock etc.

![Driver Code Generator](https://github.com/hyowinner/MCU-Driver-Code-Generator/raw/master/Img/courcetitle.png)

￼￼￼￼Above this driver block, MCU Driver Code Generator also provide functions such as
  - MCU Pin Looker
  - Memory Map Viewer
  - Static Function Generator block
  
![Driver Block in Simulink Library](https://github.com/hyowinner/MCU-Driver-Code-Generator/raw/master/Img/01.png)


![Simulink Model that use the driver block](https://github.com/hyowinner/MCU-Driver-Code-Generator/raw/master/Img/02.png)

![Generate a MCU chip view in Simulink](https://github.com/hyowinner/MCU-Driver-Code-Generator/raw/master/Img/04.png)

![Memory Section Viewer](https://github.com/hyowinner/MCU-Driver-Code-Generator/raw/master/Img/05.png)

Befor you use it, just including all folders and their subfolders into MATLAB searching path.

What' more, you need to mex all c mex S function from .c into .mex on your OS by run "mexAll"

Note: before you mex, make sure you have installed C/C++ compiler such as Visual Studio 2013.


If you want to learn more detailed about how to develop the toolbox, please visit https://ke.qq.com/course/270302?tuin=19e6c1ad
