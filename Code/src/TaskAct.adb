with Ada.Real_Time; use Ada.Real_Time;
with MyMotorDriver;
with MicroBit.Console; use MicroBit.Console;
with MicroBit.MotorDriver; use MicroBit.MotorDriver;

package body TaskAct is

   task body Act is
      myClock : Time;
      Dir     : MicroBit.MotorDriver.Directions;
   begin
      loop
         myClock := Clock;

         --this is where the direction are made based on the readings from protected object
         Dir := MyMotorDriver.MotorDriver.GetDirection;

         --applying the direction to the motors
         case Dir is
            when Forward       => MyMotorDriver.DriveForward;
            when Backward      => MyMotorDriver.DriveBackward;
            when Left          => MyMotorDriver.TurnLeft;
            when Right         => MyMotorDriver.TurnRight;
            when Stop          => MyMotorDriver.Stop;
            when others        => MyMotorDriver.Stop;
         end case;
         --again, tried to always debug to see what the issue is
         Put_Line ("Acting on: " & MicroBit.MotorDriver.Directions'Image (Dir));

         delay until myClock + Milliseconds (40);
      end loop;
   end Act;

end TaskAct;
