# Washing Machine Circuit


# Specifications  {#specifications}

Design a simple washing machine control machine with one mode and several automatic modes.  
The machine is initially idle, with the washing machine door open. The user can set the operating parameters manually (manual mode) or select one of the pre-programmed modes. In manual mode, you can set: temperature (30°C, 40°C, 60°C or 90°C); speed (800, 1000, 1200 rpm); pre-wash selection/cancellation, additional rinsing. The running time of the program depends on the selected temperature (water comes with a temperature of 15°C and heats up 1°C in 2 seconds) and the selected function (prewash \- the same method as the main wash, additional rinsing \- rinsing twice; functions are described in detail below). The selectable automatic modes are as follows:

* Quick wash \- 30°C, 1200 speed, no prewash, no extra rinsing,  
* Shirts \- 60°C, speed 800, no prewash, no extra rinsing,  
* Dark colors \- 40°C, speed 1000, no prewash, extra rinsing,  
* Dirty laundry \-40°C, 1000 speed, with prewash, no extra rinsing,  
* Antiallergic \- 90°C, speed 1200, without prewash, extra rinsing.

Each program contains the following steps: main wash (feed the machine with water, heat the water, rotate at a speed of 60 rpm for 20 minutes, drain the water), rinse (feed with water, rotate with a speed of 120 rpm for 10 minutes, drain water) and spin (rotate at the selected speed for 10 minutes). If pre-wash is selected, it has the same method as the main wash, except that it rotates for 10 minutes.  
The door locks after the program starts and opens one minute after the program ends. The car does not start with the door open.   
While the desired mode is selected (manual or one of the automatic modes), the program duration is displayed, and the remaining time is displayed after starting (the time is displayed on 7-segment displays).  
The project will be carried out by 2 students.

# Design {#design}

## Black Box {#black-box}


**INPUTS**

* Mods – six switches representing the six modes that can be chosen (Manual, Quick wash, Shirts, Dark colors, Dirty laundry, Anti allergenic),  
* Buttons – 5 of them, used to select the temperature and rotation speed in manual mode, and starting the machine.  
* PH – switch used to activate prewash in manual mode,  
* ER – switch used to select extra rinsing in manual mode,  
* Reset – switch that resets the hole circuit (asynchronous),  
* CLOCK – clock from the FPGA board (100Mhz).


**OUTPUTS**

* Segments \+ Anodes – four 7 segment displays that show the duration of a program or the remaining time if the program already started,  
                      – two 7 segment display that shows which temperature is being selected in manual mode,  
                       – two 7 segment display that shows which rotation speed is being selected in manual mode,  
                        – five 7 segment displays with the message: Error (appears if two modes are activated at the same time),  
                      – four 7 segment displays with the message: done (appears while we wait for the user to set the switch for the activated mode back to 0\)  
* Fill – a led that indicates if the machine is filling water,  
* Drain – a led that indicates if is draining the water,  
* Heat – a led that indicates if is heating the water,  
* DoorLock– a led that indicates if the door is open or not.  
* Rot – 3 LEDs that indicate what is the machine doing (washing, rinsing, drying)

### Mapping the inputs and outputs of the black box on the two components {#mapping-the-inputs-and-outputs-of-the-black-box-on-the-two-components}
 
*Figure 2 Mapping the inputs and outputs of the black box on the inputs and outputs of the units*

We can divide both inputs and outputs into 2 categories: **data** and **control**. This separation is essential at the beginning.  
**Data inputs:**   
**Control inputs:**

- Door,  
- Mod,  
- \+,  
- \-,  
- Start,  
- T\_select,  
- RPM\_select,  
- PH,  
- ER,  
- CLOCK,  
- CANCEL.

**Data outputs:** 

- The time, temperature and rotation speed displayed on the 7-segments,  
- Rot  
- FILL  
- HEAT  
- DRAIN

## Resources (breakdown of the Execution Unit) {#resources-(breakdown-of-the-execution-unit)}

**RESOURCES**

### Temperature state counter   
   

This resource will store which temperature we want to use, encoded on 2-bits. It has 4 inputs:

* CLK from the FPGA’s clock,  
* Down & Up for decrementing or incrementing the temperature from CU,  
* Reset from CU, this brings the counter back in state “00” (30 degrees).

              The output is the current temperature state.

![A yellow rectangular object with black textDescription automatically generated with low confidence][image4]

### RPM state counter 

This resource will store which rotation speed we want to use, encoded on 2-bits. It has 4 inputs:

* CLK from the FPGA’s clock,  
* Down & Up for decrementing or incrementing the temperature from CU,  
* Reset from CU, this brings the counter back in state “00” (30 degrees).

              The output is the current RPM state.

![A yellow rectangular object with black textDescription automatically generated with low confidence][image5]

###  MUX\_timer

This resource “decides” how many minutes and hours will be loaded on the timer based on the mode, extra rinsing, prewash and the temperature counter. The inputs come from the “ER and PW register”, “mode register” and “temperature counter” resources.  
The outputs are the hours and minutes in binary, on 6 bits.  
![A picture containing text, line, screenshot, diagramDescription automatically generated][image6]

### ONEsec frequency divider

This resource receives the clock from the FPGA (100mHZ) as input and generates a new clock with the frequency of 1HZ and 50% duty cycle.

![][image7]

### Minute timer

This resource stores the remaining minutes. It has the following inputs:

* a, on 6 bits representing the number of minutes that will be loaded, from “mux timer”,  
* CLK a signal with frequency 1Hz, from “ONEsec frequency divider”,  
* Enable and Load controlling then the timer is decrementing and when it parallel loads input “a”, from CU.

                   The outputs are the minutes remaining on 6 bits, and “t” – enable for the hours timer,  every time the timer completes a cycle.   
![A picture containing text, screenshot, diagram, lineDescription automatically generated][image8]

### Hours Timer

    	This resource stores the remaining hours, it has the following inputs:

* a, on 6 bits representing the number of minutes that will be loaded, from “mux timer”,  
* CLK a signal with frequency 1Hz, from “ONEsec frequency divider”,  
* Enable and Load controlling then the timer is decrementing and when it parallel loads input “a”, from CU.

The resource will be enabled every time the minutes timer completes a cycle, and the timer is enabled.  
The output is on 6 bits, and it represents the remaining number of hours.

![A picture containing text, screenshot, diagram, lineDescription automatically generated][image9]

### MUX Temperature mode

This resource decides what temperature is used by the washing machine. If the manual mode is selected, the mux will give the temperature from the state counter. If an automatic mode is selected, the mux will give the preset temperature for the respective mode (encoded on 2-bits).  
The inputs are received from the “temperature counter” and “mode register” resources in EU.

![A yellow rectangular object with black textDescription automatically generated with low confidence][image10]

### MUX RPM mode

This resource decides what rotation speed is used by the washing machine. If the manual mode is selected, the mux will give the speed from the state counter. If an automatic mode is selected, the mux will give the preset speed for the respective mode (encoded on 2-bits).  
The inputs are received from the “temperature counter” and “mode register” resources in EU.

![A yellow rectangular object with black textDescription automatically generated with low confidence][image11]

### Temperature output

This resource decodes the temperature mode into two digits numbers on the 7-segment display. It receives a 2-bit input from the “MUX temperature mode” and gives 2 outputs on 7-bits to “output control” resource.

![A picture containing text, screenshot, font, lineDescription automatically generated][image12]

### RPM output

This resource decodes the rotation speed mode into two digits numbers on the 7-segment display. It receives a 2-bit input from the “MUX RPM mode” and gives 2 outputs on 7-bits to “output control” resource.

![A picture containing text, screenshot, font, lineDescription automatically generated][image13]

### FrequencyDIVIDER

This resource receives the clock from the FPGA as input and converts it into signals for moving the anodes for the display and for text moving animation.

![A picture containing text, screenshot, font, lineDescription automatically generated][image14]

### Number to 7seg

This resource converts a number with two digits on 6 bits directly into two 7-segment digits on 7-bits. The output will go into “output control” component.  
![A picture containing text, screenshot, font, rectangleDescription automatically generated][image15]

### Blink

This resource receives a signal CLK with frequency 1Hz from “ONEsec” component, enable from CU and two digits in 7-segment encoding. If enable is activated, the output will be the given digits blinking and if en is ‘0’, the digits will be unchanged. Two of these components are used in the EU.

![A picture containing text, screenshot, font, lineDescription automatically generated][image16]

### Move

This resource receives “newClock2” output from “frequencyDivider” as “clk” input as well as done, error and start from CU. It generates a moving massage on the 7-segments based on the input. The outputs are 8 segments on 7-bits representing the display.  
![A screenshot of a computer programDescription automatically generated with low confidence][image17]

### Outputs control

This component receives as inputs:

* Done, Error, Start from CU,  
* 8 segments for displaying an animation when one of the above inputs is active  
* 8 segments for displaying the time remaining, temperature and RPM used otherwise.The 8 outputs on 7-bits are what will be displayed on the 7-segments.

### Anodes

This resource implements the display on the FPGA. It receives “newClock” output from “frequencyDivider” as “clk” input and 8 arrays on 7-bits each.  
The outputs are an 8-bits array representing the anodes of the FPGA and a 7-bits array representing the cathodes.  On every clock cycle, the anodes will shift right circularly starting from “10000000” and for every activated bit an\[i\] in the array, segment no. ‘i’ will be displayed creating the illusion of 8 different segments simultaneously.

![A picture containing text, screenshot, businesscard, fontDescription automatically generated][image18]

### Register for modes

 	This resource receives as inputs:

* clk: the clock from the FPGA,  
* en: from CU,  
* ld: on 5 bits, from switches.

When en is active, the register will parallel load the input “ld”. The output on 5-bits is the register’s value.

![A picture containing text, font, screenshot, numberDescription automatically generated][image19]

### Debouncer 

This component receives as inputs the clock from the FGPA it’s 5 buttons. As outputs it generates the debounced signal from the buttons.

![A yellow rectangle with black textDescription automatically generated with medium confidence][image20]

### Timer10

This is a 4-bit modulo-10 counter. This circuit will have a *T10* output that will be true when 10 minutes have passed. In addition, we want to start or stop the counter at the right time, so it needs Enable input *EN10*.

![A picture containing text, screenshot, font, diagramDescription automatically generated][image21]

So, we have an output *T10* signal generated by E.U. for C.U. and an *EN10* signal generated by C.U. to E.U. We also have a *synchronous Reset10* signal generated by C.U.

### 20 minutes TIMER20 counter

This is a 5-bit modulo 20 counter. This circuit will have a *T20* output that will be true when 20 minutes have passed. In addition, we want to start or stop the counter at the right time, so it needs Enable input *EN20*.  
![A picture containing screenshot, text, line, diagramDescription automatically generated][image22]

So, we have an output *T20* signal generated by E.U. for C.U. and an *EN20* signal generated by C.U. to E.U. We also have a *synchronous Reset20* signal generated by C.U.

### 3 seconds TIMER3 counter

This is a 2-bit modulo 3 counter. This circuit will have a *T3* output that will be true when 3 seconds have passed. In addition, we want to start or stop the counter at the right time so it needs Enable input *EN3*.  
![A picture containing text, screenshot, font, lineDescription automatically generated][image23]

So, we have an output *T3* signal generated by E.U. for C.U. and an *EN3* signal generated by C.U. to E.U. We also have a *synchronous Reset3* signal generated by C.U.

## Block Diagram for first breakdown	 {#block-diagram-for-first-breakdown}

![A picture containing screenshot, line, text, diagramDescription automatically generated][image24]

## State diagram of the Control Unit {#state-diagram-of-the-control-unit}



# User manual {#user-manual}

When you power on the machine, you will be greeted with the massage HELLO on the display.  
Select the mode you want to use from the following switches.  
![A picture containing electronics, electronic engineering, electronic component, circuit componentDescription automatically generated][image25]  
                                                                            Inputs Map

The available modes are:

*        Manual – you may choose the temperature, rotation speed and options for prewash and          extra rinsing,  
  * Quick wash \- 30°C, 1200 speed, no prewash, no extra rinsing,  
  * Shirts \- 60°C, speed 800, no prewash, no extra rinsing,  
  * Dark colors \- 40°C, speed 1000, no prewash, extra rinsing,  
  * Dirty laundry \-40°C, 1000 speed, with prewash, no extra rinsing,  
  * Antiallergic \- 90°C, speed 1200, without prewash, extra rinsing.

If two modes are chosen at the same time, the massage Error will be displayed. Make sure only one mode switch is selected.

If one of the automatic modes is selected, the time required, temperature and rotation speed are displayed on the screen. After inserting your clothes, close the door using the “door” switch and feel free to press the “Start” button to begin.

If the manual mode is selected, the default settings are displayed. To select the temperature, press the “temperature selection" button. The temperature displayed will start blinking and using the “up” and “down” button you are able to go through the available temperature. To confirm your selection, press the start button. To select the rotation speed, press the “RPM selection" button and proceed like before. For extra rinsing and prewash use the respective switches. After choosing the settings suitable for you, press the “Start” button to begin.

Outputs map:  
![A picture containing electronics, electronic engineering, electronic component, circuit componentDescription automatically generated][image26]

The mode and ER\&PH LEDs show you the selected options throughout the program.  Modifying the switches after the program started will not have any effects. To cancel use the “cancel” switch. If the program has started the water will be drained and after 1 minute you will be able to open the door, otherwise the machine will go into the Idle state (HELLO on display). The door LED shows you if the door is opened or not, if you try to open the door using the switch when the door is locked, the “door” LED will not turn on.  
The rot LEDs will show how in what state is the machine:

- LED1: Rotating with 60PRM (washing),  
- LED2: Rotating with 120RPM (rinsing),  
- LED3: Rotating with the chosen speed (drying).

The water LEDs will show how in what state is the machine regarding the usage of water:

- LED1: Water is inserted into the machine,  
- LED2: Water is heated,  
- LED3: Water is drained from the machine.


The remaining time will be displayed throughout the process.

# Technical justifications for the design {#technical-justifications-for-the-design}

Starting with the control unit, it described behavioral as it is the most time efficient architecture for such components.  
We choose to put effort into making the interface friendly and intuitive. The blinking in Manual mode makes browsing through the available options, using all the buttons available on NexysA7, appealing and effortless.   
The moving “HELLO” message brings a personal touch into the using experience and, “Done” and “Error” make it easy to understand what needs to be done.  
 For storing the preset information about the automatic modes, we decided to use MUXs instead of memory to make the design faster and cheaper.   
Overall, we wanted to show the power and beauty of the FPGA board thought a charming and informative design that attracts numerous potential clients. 

# Future developments {#future-developments}

## Pause switch  
     
To implement this, we need to use another register for storying the last state and add another one which suspends all processes until the input is switched back off.  
     
     
## Other automatic modes  
     
The MUXs need to be updated, eighter by adding one more bit for each new mode or, a more efficient method is using a priority encoder and using this method, the 6-bits MUXs will be enough for 57 new mods.  
   

## No draining  
     
We have another place available on the rotation speed counter, being a 2-bit state counter with only 3 being used. Small changes also need to be made on the MUXs used for displaying the RPM on the 7-segments.  
     
        
## Color LEDs  
     
The FPGA has 2 RGB LEDs, these LEDs could be perfectly used for substituting the water LEDs. This component was created, and it was functional but due to technical difficulties we were not able to use Vivado for implementing the project and Logisim does not allow the usage of the RGB LEDs.

# References {#references}

* Limbajul VHDL Indrumator de proiectare (U.T.PRESS) – Octavian Cret, Lucia Vacariu  
* Proiectarea Sistemelor Numerice Folosind Tehnologia FPGA (MEDIAMIRA)- Octavian Cret, Zoltan Baruch  
* https://sites.google.com/site/learnvhdl  
* https://vhdlwhiz.com/basic-vhdl-tutorials/      
* https://learn.digilentinc.com/Documents/427              