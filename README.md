# SSR8-CAP1188
Controlling Solid Stay Relays with Capacitive Sensor (CAP1188) Board

BoM:

(1) AITRIP 2PCS 8 Channel 5V Solid State Relay Module Board High Level Trigger (or similar)
(1) Adafruit CAP1188 breakout board (or similar)
(1) USB To DIP Adapter 5pin Female Connector B Type PCB Converter (or similar -- or USB C, if you prefer)
(1) USB Type A Female Socket Breakout Board 2.54mm Pitch Adapter Connector DIP (optional -- for pass-thru power)
(1) Arduino Pro Mico or similar. Nano will work. Should also work with QT PY or similar.
(1) G/KF128 8 Pin 2.54mm Pitch PCB Screw Terminal Block Connector 150V 6A PCB Mount Screw Terminal Block Connector
(x) Assorted wire and connectors, solder, tools.

---

Power (VCC and GND) bussed through USB connectors, CAP, Arduino, and SSR -- common 5V power from USB in.
Power the device through the external supply connection, not the program port. (Prevents overload of Arduino.)

CAP1188 board LED outs go to SSR inputs.
CAP1188 board I2C to MCU.
CAP1188 board RST to MCU digital pin (any--define in code).

---

The two front-facing USB female connectors are for power in (from a wall wart) and power out (so you can daisy-chain).

I used a tiny (2.54mm pitch) screw terminal block for connecting the CAP inputs. You may choose a different connector.

Outbound connectors are already on the relay board.

---

Caution: The relay board isn't always the greatest. I've found some of the screw terminal blocks to be broken, or messed up. You may need to re-solder them. Also, I found the Input Terminal blocks to be too big/sloppy for my wiring from the CAP1188. So, I used Molex connectors and the pin header found on the SSR board for the inputs. The extra benefit of this is that those blocks are free for other prototyping uses.

---

Some devices act a little weird on the output side. The little "singing baby shark" toy works perfectly. A cheap LED "snowglobe" can be intermittant. This may be a wiring problem in the device -- I'm still debugging.

---

You can use the default test code provided by Adafruit. You MUST add this line to setup: 
  //reverse led polarity
  //on-board led will go off, SSR will be triggered on
  cap.writeRegister(0x73, 0xFF);

---

WARNING: On startup, all outputs will go ACTIVE for a second, as the board boots. Do not use this in situations where this would cause a problem! I'm working on a better version which will "fail/start" off in all conditions. This will likely involve connecting the SSR directly to the Arduino Digital Outs, instead of piggy-backing on the CAP1188.

