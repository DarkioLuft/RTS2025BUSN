with Ada.Real_Time; use Ada.Real_Time;
with MicroBit;              use MicroBit;
with MicroBit.Ultrasonic;
with MyBrain;
with MicroBit.Console; use MicroBit.Console;
--just a comment to change the caseSensitivity of git
package body TaskSense is

   task body Sense is
      myClock : Time;

      --instantiate ultrasonic sensors for both sensors
      package Sensor_Left  is new MicroBit.Ultrasonic (MB_P13, MB_P1);  --trig P13, echo P1, translated to actual MicroBit Pins
      package Sensor_Right is new MicroBit.Ultrasonic (MB_P12, MB_P0);  --trig P12, echo P0

      Dist_Left, Dist_Right : MyBrain.Distance_CM;
   begin
      loop
         myClock := Clock;

         --where the sensors are read
         Dist_Left  := MyBrain.Distance_CM (Sensor_Left.Read);
         Dist_Right := MyBrain.Distance_CM (Sensor_Right.Read);
         --tried to debug it, to print out to see what the error is
         Put_Line ("Raw Left=" & Distance_CM'Image(Dist_Left) &
          " Raw Right=" & Distance_CM'Image(Dist_Right));

         --storing the values in a protected object instance so that other tasks can also read them
         MyBrain.SensorData_Instance.SetMeasurements (Dist_Left, Dist_Right);
         --MyBrain.SensorData.SetMeasurements (Dist_Left, Dist_Right);

         --I changed this from 20 to 200, to enforce periodicity
         delay until myClock + Milliseconds (200); --(200 ms period)
      end loop;
   end Sense;

end TaskSense;
