# Washing Machine Circuit

## Table of Contents
- [Specifications](#specifications)
- [Design](#design)
  - [State Diagram](#state-diagram-of-the-control-unit)
  - [Black Box](#black-box)
  - [Resources](#resources-breakdown-of-the-execution-unit)
  - [Block Diagram](#block-diagram-for-first-breakdown)
- [🔥 **USER MANUAL** 🔥](#user-manual)
  > ### ⚡ IMPORTANT: PLEASE READ BEFORE USE! ⚡
- [Technical Justifications](#technical-justifications-for-the-design)
- [Future Developments](#future-developments)
- [References](#references)

---

## Specifications  {#specifications}

Design a simple washing machine control machine with one mode and several automatic modes.  

The machine is initially idle, with the washing machine door open. The user can set the operating parameters manually (manual mode) or select one of the pre-programmed modes. 

### Manual Mode Settings:
- Temperature: 30°C, 40°C, 60°C or 90°C
- Speed: 800, 1000, 1200 rpm
- Options: Pre-wash selection/cancellation, additional rinsing

> **Note:** The running time depends on the selected temperature (water comes with a temperature of 15°C and heats up 1°C in 2 seconds) and selected functions.

### Automatic Modes:
| Mode | Temperature | Speed | Pre-wash | Extra Rinsing |
|------|------------|-------|-----------|---------------|
| Quick wash | 30°C | 1200 | No | No |
| Shirts | 60°C | 800 | No | No |
| Dark colors | 40°C | 1000 | No | Yes |
| Dirty laundry | 40°C | 1000 | Yes | No |
| Antiallergic | 90°C | 1200 | No | Yes |

### Program Steps:
1. **Main Wash**
   - Feed machine with water
   - Heat water
   - Rotate at 60 rpm for 20 minutes
   - Drain water

2. **Rinse**
   - Feed with water
   - Rotate at 120 rpm for 10 minutes
   - Drain water

3. **Spin**
   - Rotate at selected speed for 10 minutes

> **Important Safety Features:**
> - Door locks after program starts
> - Opens one minute after program ends
> - Machine won't start with door open
> - Program duration displayed during selection
> - Remaining time shown after start (7-segment displays)

---

## Design {#design}

### State diagram of the Control Unit {#state-diagram-of-the-control-unit}

> **📋 Note:** The complete state diagram is available in the project files at:
> [`state_diagram.pdf`](state_diagram.pdf)
>
> Due to its complexity and size, the full state diagram is better viewed in the PDF format where you can:
> - Zoom in to see all details
> - Navigate through all states and transitions
> - Print in high resolution if needed

### Black Box {#black-box}

<div align="center">
  <img src="https://github.com/user-attachments/assets/ca2cf6b6-253b-4d1e-8597-59d7dc42e5b6" alt="Black Box">
</div>

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
 
<div align="center">
  <img src="https://github.com/user-attachments/assets/87e0169f-6341-4a2f-b047-dd0e52f14cdc" alt="Mapping Components">
</div>

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

### Resources (breakdown of the Execution Unit) {#resources-(breakdown-of-the-execution-unit)}

#### Temperature state counter   
   

This resource will store which temperature we want to use, encoded on 2-bits. It has 4 inputs:

* CLK from the FPGA's clock,  
* Down & Up for decrementing or incrementing the temperature from CU,  
* Reset from CU, this brings the counter back in state "00" (30 degrees).

<div align="center">
  <img src="https://github.com/user-attachments/assets/185517dd-fba9-4684-a69e-fa2dc2510291" alt="Temperature State Counter">
</div>


![A yellow rectangular object with black textDescription automatically generated with low confidence][image4]

#### RPM state counter 

This resource will store which rotation speed we want to use, encoded on 2-bits. It has 4 inputs:

* CLK from the FPGA's clock,  
* Down & Up for decrementing or incrementing the temperature from CU,  
* Reset from CU, this brings the counter back in state "00" (30 degrees).

<div align="center">
  <img src="https://github.com/user-attachments/assets/26c11e3d-dc3a-4cc7-9bf5-594416ef839f" alt="RPM State Counter">
</div>


![A yellow rectangular object with black textDescription automatically generated with low confidence][image5]

####  MUX\_timer

This resource "decides" how many minutes and hours will be loaded on the timer based on the mode, extra rinsing, prewash and the temperature counter. The inputs come from the "ER and PW register", "mode register" and "temperature counter" resources.  
The outputs are the hours and minutes in binary, on 6 bits.  

<div align="center">
  <img src="https://github.com/user-attachments/assets/acb15393-4e80-42bf-835f-ea68845ff35a" alt="MUX Timer">
</div>

#### ONEsec frequency divider

This resource receives the clock from the FPGA (100mHZ) as input and generates a new clock with the frequency of 1HZ and 50% duty cycle.



#### Minute timer

This resource stores the remaining minutes. It has the following inputs:

* a, on 6 bits representing the number of minutes that will be loaded, from "mux timer",  
* CLK a signal with frequency 1Hz, from "ONEsec frequency divider",  
* Enable and Load controlling then the timer is decrementing and when it parallel loads input "a", from CU.

 The outputs are the minutes remaining on 6 bits, and "t" – enable for the hours timer,  every time the timer completes a cycle.   

<div align="center">
  <img src="https://github.com/user-attachments/assets/948310a6-3e5b-4c1d-aaf1-551d72d1644a" alt="Minute Timer">
</div>

#### Hours Timer

This resource stores the remaining hours, it has the following inputs:

* a, on 6 bits representing the number of minutes that will be loaded, from "mux timer",  
* CLK a signal with frequency 1Hz, from "ONEsec frequency divider",  
* Enable and Load controlling then the timer is decrementing and when it parallel loads input "a", from CU.

The resource will be enabled every time the minutes timer completes a cycle, and the timer is enabled.  
The output is on 6 bits, and it represents the remaining number of hours.

![A picture containing text, screenshot, diagram, lineDescription automatically generated][image9]

#### MUX Temperature mode

This resource decides what temperature is used by the washing machine. If the manual mode is selected, the mux will give the temperature from the state counter. If an automatic mode is selected, the mux will give the preset temperature for the respective mode (encoded on 2-bits).  
The inputs are received from the "temperature counter" and "mode register" resources in EU.

<div align="center">
  <img src="https://github.com/user-attachments/assets/02035a38-47e0-4cd4-81d3-44d25c09c0c7" alt="MUX Temperature Mode">
</div>


#### MUX RPM mode

This resource decides what rotation speed is used by the washing machine. If the manual mode is selected, the mux will give the speed from the state counter. If an automatic mode is selected, the mux will give the preset speed for the respective mode (encoded on 2-bits).  
The inputs are received from the "temperature counter" and "mode register" resources in EU.


#### Temperature output

This resource decodes the temperature mode into two digits numbers on the 7-segment display. It receives a 2-bit input from the "MUX temperature mode" and gives 2 outputs on 7-bits to "output control" resource.

<div align="center">
  <img src="https://github.com/user-attachments/assets/4b787499-4d18-41cd-9af3-360f6cee613c" alt="Temperature Output">
</div>

#### RPM output

This resource decodes the rotation speed mode into two digits numbers on the 7-segment display. It receives a 2-bit input from the "MUX RPM mode" and gives 2 outputs on 7-bits to "output control" resource.

<div align="center">
  <img src="https://github.com/user-attachments/assets/0e318d83-0dc1-45bf-aa22-258269179460" alt="RPM Output">
</div>

#### FrequencyDIVIDER

This resource receives the clock from the FPGA as input and converts it into signals for moving the anodes for the display and for text moving animation.


#### Number to 7seg

This resource converts a number with two digits on 6 bits directly into two 7-segment digits on 7-bits. The output will go into "output control" component.  

<div align="center">
  <img src="https://github.com/user-attachments/assets/830e81ef-eb1b-49fc-b96e-9191480a9965" alt="Number to 7seg">
</div>

#### Blink

This resource receives a signal CLK with frequency 1Hz from "ONEsec" component, enable from CU and two digits in 7-segment encoding. If enable is activated, the output will be the given digits blinking and if en '0', the digits will be unchanged. Two of these components are used in the EU.


#### Move

This resource receives "newClock2" output from "frequencyDivider" as "clk" input as well as done, error and start from CU. It generates a moving massage on the 7-segments based on the input. The outputs are 8 segments on 7-bits representing the display.  

<div align="center">
  <img src="https://github.com/user-attachments/assets/f83025cc-3ad4-4ba8-a493-d4f6f92af746" alt="Move">
</div>

#### Outputs control

This component receives as inputs:

* Done, Error, Start from CU,  
* 8 segments for displaying an animation when one of the above inputs is active  
* 8 segments for displaying the time remaining, temperature and RPM used otherwise.The 8 outputs on 7-bits are what will be displayed on the 7-segments.

#### Anodes

This resource implements the display on the FPGA. It receives "newClock" output from "frequencyDivider" as "clk" input and 8 arrays on 7-bits each.  
The outputs are an 8-bits array representing the anodes of the FPGA and a 7-bits array representing the cathodes.  On every clock cycle, the anodes will shift right circularly starting from "10000000" and for every activated bit an\[i\] in the array, segment no. 'i' will be displayed creating the illusion of 8 different segments simultaneously.

<div align="center">
  <img src="https://github.com/user-attachments/assets/1ef9c0ba-c62e-419d-8b08-59ce2c090556" alt="Anodes">
</div>

#### Register for modes

This resource receives as inputs:

* clk: the clock from the FPGA,  
* en: from CU,  
* ld: on 5 bits, from switches.

When en is active, the register will parallel load the input "ld". The output on 5-bits is the register's value.


#### Debouncer 

This component receives as inputs the clock from the FGPA it's 5 buttons. As outputs it generates the debounced signal from the buttons.


#### Timer10

This is a 4-bit modulo-10 counter. This circuit will have a *T10* output that will be true when 10 minutes have passed. In addition, we want to start or stop the counter at the right time, so it needs Enable input *EN10*.

<div align="center">
  <img src="https://github.com/user-attachments/assets/ce561c62-6ebd-4e47-98bd-da4ae6d830c3" alt="Timer10">
</div>

So, we have an output *T10* signal generated by E.U. for C.U. and an *EN10* signal generated by C.U. to E.U. We also have a *synchronous Reset10* signal generated by C.U.

#### 20 minutes TIMER20 counter

This is a 5-bit modulo 20 counter. This circuit will have a *T20* output that will be true when 20 minutes have passed. In addition, we want to start or stop the counter at the right time, so it needs Enable input *EN20*.  

So, we have an output *T20* signal generated by E.U. for C.U. and an *EN20* signal generated by C.U. to E.U. We also have a *synchronous Reset20* signal generated by C.U.

#### 3 seconds TIMER3 counter

This is a 2-bit modulo 3 counter. This circuit will have a *T3* output that will be true when 3 seconds have passed. In addition, we want to start or stop the counter at the right time so it needs Enable input *EN3*.  

So, we have an output *T3* signal generated by E.U. for C.U. and an *EN3* signal generated by C.U. to E.U. We also have a *synchronous Reset3* signal generated by C.U.

### Block Diagram for first breakdown

<div align="center">
  <table>
    <tr>
      <td style="background-color: white;">
        <img src="https://github.com/user-attachments/assets/fd49f2fd-2303-4d4e-b17a-a835a0e6e348" alt="Block Diagram">
      </td>
    </tr>
  </table>
</div>

## User manual {#user-manual}

When you power on the machine, you will be greeted with the massage HELLO on the display.  
Select the mode you want to use from the following switches.  

<div align="center">
  <img src="https://github.com/user-attachments/assets/31966a92-8189-4194-b67a-8355d5e23029" alt="Inputs Map">
</div>

Inputs Map

The available modes are:

* Manual – you may choose the temperature, rotation speed and options for prewash and extra rinsing,  
  * Quick wash \- 30°C, 1200 speed, no prewash, no extra rinsing,  
  * Shirts \- 60°C, speed 800, no prewash, no extra rinsing,  
  * Dark colors \- 40°C, speed 1000, no prewash, extra rinsing,  
  * Dirty laundry \-40°C, 1000 speed, with prewash, no extra rinsing,  
  * Antiallergic \- 90°C, speed 1200, without prewash, extra rinsing.

If two modes are chosen at the same time, the massage Error will be displayed. Make sure only one mode switch is selected.

If one of the automatic modes is selected, the time required, temperature and rotation speed are displayed on the screen. After inserting your clothes, close the door using the "door" switch and feel free to press the "Start" button to begin.

If the manual mode is selected, the default settings are displayed. To select the temperature, press the "temperature selection" button. The temperature displayed will start blinking and using the "up" and "down" button you are able to go through the available temperature. To confirm your selection, press the start button. To select the rotation speed, press the "RPM selection" button and proceed like before. For extra rinsing and prewash use the respective switches. After choosing the settings suitable for you, press the "Start" button to begin.

Outputs map:  

<div align="center">
  <img src="https://github.com/user-attachments/assets/270c1a58-d1cf-4068-832b-0ce6db097434" alt="Outputs Map">
</div>

The mode and ER\&PH LEDs show you the selected options throughout the program.  Modifying the switches after the program started will not have any effects. To cancel use the "cancel" switch. If the program has started the water will be drained and after 1 minute you will be able to open the door, otherwise the machine will go into the Idle state (HELLO on display). The door LED shows you if the door is opened or not, if you try to open the door using the switch when the door is locked, the "door" LED will not turn on.  
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
The moving "HELLO" message brings a personal touch into the using experience and, "Done" and "Error" make it easy to understand what needs to be done.  
 For storing the preset information about the automatic modes, we decided to use MUXs instead of memory to make the design faster and cheaper.   
Overall, we wanted to show the power and beauty of the FPGA board thought a charming and informative design that attracts numerous potential clients. 

## Future developments {#future-developments}

### 🔄 Pause Switch
- Requires additional register for state storage
- Implements suspension of all processes
- Resumes from last state

### ⚙️ Other Automatic Modes
- MUX updates needed
- Options:
  - Add extra bit per mode
  - Use priority encoder (supports up to 57 new modes)

### 💧 No Draining Option
- Available space in rotation speed counter
- Minimal MUX display modifications needed

### Color LEDs
- FPGA includes 2 RGB LEDs
- Perfect for water status indication
- Currently limited by Logisim implementation

## References {#references}

1. Cret, O., & Vacariu, L. (2023). *Limbajul VHDL Indrumator de proiectare*. U.T.PRESS.

2. Cret, O., & Baruch, Z. (2023). *Proiectarea Sistemelor Numerice Folosind Tehnologia FPGA*. MEDIAMIRA.

3. Learn VHDL. (n.d.). Retrieved from https://sites.google.com/site/learnvhdl

4. VHDLwhiz. (n.d.). Basic VHDL Tutorials. Retrieved from https://vhdlwhiz.com/basic-vhdl-tutorials/

5. Digilent Documentation. (n.d.). Nexys A7 Reference Manual. Retrieved from https://learn.digilentinc.com/Documents/427
