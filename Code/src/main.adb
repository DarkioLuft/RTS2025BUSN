-- USN PROJECT TEMPLATE INTELLIGENT REAL-TIME SYSTEMS
-- Project name: [project name]
-- Project members: [name, name, .. ]


--This is a project template for a Jorvik profile (a less restrictive Ravenscar) for the MicroBit v2 such that we have a language supported real-time OS for embedded targets
--It requires the nRF52833 Jorvik runtime files. They can be found in the folder "runtime profiles" and need to be copied to your earm-eabi compiler toolchain
--In future version of GNATstudio this profile is automatically available and this step can be skipped (for status see: https://github.com/AdaCore/bb-runtimes/pull/67)

--Check out the many examples in the ADL for the MicroBit v2 to see:
--  1) How the various drivers can be used like the accelerometer,speaker  or wireless communication via radio
--  2) How ADA features like the Math library and Bounded_Vectors (Containers) can be used
--  3) How to structure your Ada tasks with a protected object to synchronize data or with entries to synchronize flow
--  4) How to perform a execution time analysis
--  5) How to integrate your Ada project with a Unity project over USB

-- Open a View > Cross Platforms > Serial Ports to see Put_Line output. Set the baud rate to 115.200
with MicroBit.Console; use MicroBit.Console;
with MicroBit.DisplayRT;
with MicroBit.DisplayRT.Symbols;
with MicroBit.Buttons; use MicroBit.Buttons;
with MicroBit.MotorDriver; use MicroBit.MotorDriver; --using the procedures defined here
with DFR0548;  -- using the types defined here
with Ada.Real_Time; use Ada.Real_Time;
with MicroBit.Ultrasonic;
with MicroBit.Types; use MicroBit.Types;
with MicroBit.Music; use MicroBit.Music;
use MicroBit; --for pin names


procedure Main is --with Priority => 0 is

   package sensor1 is new Ultrasonic(MB_P14, MB_P16);

   Distance : Distance_cm := 0;



   task type Motor_Task is
   end Motor_Task;

   task body Motor_Task is
      Delay_Time : constant Time_Span := Milliseconds (500);
   begin
      MotorDriver.Drive(Stop); --initially stop the motors
   loop
         Distance := sensor1.Read;
         Put_Line("Distance: " & Distance'Image);
         if Distance < 20 then
            MotorDriver.Drive(Backward, (4095,4095,4095,4095));
            delay until Clock + Delay_Time;
            MotorDriver.Drive(Right, (4095,4095,4095,4095));
            delay until Clock + Delay_Time;
            MotorDriver.Drive(Forward, (4095,4095,4095,4095));
         else
            MotorDriver.Drive(Forward, (4095,4095,4095,4095));
         end if;
         delay until Clock + Milliseconds(100);
   end loop;

   end Motor_Task;
begin
   loop
      delay 1.0;

   end loop;
end Main;
