pragma Ada_2022;

with MicroBit.Console; use MicroBit.Console;
with MicroBit.Ultrasonic;
with Ada.Real_Time; use Ada.Real_Time;
with MicroBit.Types; use MicroBit.Types;
with MicroBit; use MicroBit;
with TaskAct;
with TaskThink;
with TaskSense;



procedure Main is

   --this is the instantiate of the two sensors on different pins
   --package Sensor_Left  is new MicroBit.Ultrasonic (MB_P13, MB_P1);
   --package Sensor_Right is new MicroBit.Ultrasonic (MB_P12, MB_P0);

   --Distance_Left  : Distance_cm;
   --Distance_Right : Distance_cm;
begin
   --Put_Line ("Starting...");

   --loop
      --this reads both sensors
      --Distance_Left  := Sensor_Left.Read;
      --Distance_Right := Sensor_Right.Read;

      --this prints the
      --Put_Line ("Left="  & Distance_cm'Image (Distance_Left) &
                --" Right=" & Distance_cm'Image (Distance_Right));

      --the delay for 200 ms
      --delay until Clock + Milliseconds (200);
   --end loop;


   loop
      delay 10.0;  -- Keep the main task alive
   end loop;
end Main;
