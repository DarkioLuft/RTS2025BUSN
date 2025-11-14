with Ada.Real_Time; use Ada.Real_Time;
with MyBrain;
with MyMotorDriver;
with MicroBit.Console; use MicroBit.Console;
with MicroBit.MotorDriver; use MicroBit.MotorDriver;
with Config;

package body TaskThink is

   task body Think is
      myClock : Time;
      Dist_Left, Dist_Right : Distance_CM;
      Dir : MicroBit.MotorDriver.Directions;
   begin
      loop
         myClock := Clock;

         -- Read sensor values from the protected object
         MyBrain.SensorData_Instance.GetMeasurements (Dist_Left, Dist_Right);

         -- Check how old the sensor data is
         declare
            Age : Duration := To_Duration (Clock - MyBrain.SensorData_Instance.Last_Update);
         begin
            if Age > Duration (2 * Config.Think_Period_ms) / 1000.0 then
               -- Data too old, default to Stop
               MyMotorDriver.MotorDriver.SetDirection (Stop);
            else
               -- Normal decision logic based on thresholds
               if Dist_Left > 20 and Dist_Right > 20 then
                  MyMotorDriver.MotorDriver.SetDirection (Forward);
               elsif Dist_Left < 10 and Dist_Right < 10 then
                  MyMotorDriver.MotorDriver.SetDirection (Backward);
               elsif Dist_Left < 10 or Dist_Right < 10 then
                  MyMotorDriver.MotorDriver.SetDirection (Stop);
               elsif Dist_Left < Dist_Right then
                  MyMotorDriver.MotorDriver.SetDirection (Left);
               else
                  MyMotorDriver.MotorDriver.SetDirection (Right);
               end if;
            end if;
         end;

         -- Debug prints
         Put_Line ("Left=" & Distance_CM'Image(Dist_Left) &
                   " Right=" & Distance_CM'Image(Dist_Right));

         Dir := MyMotorDriver.MotorDriver.GetDirection;
         Put_Line ("Decision: " & MicroBit.MotorDriver.Directions'Image (Dir));

         -- Enforce periodicity
         delay until myClock + Milliseconds (Config.Think_Period_ms);
      end loop;
   end Think;

end TaskThink;
