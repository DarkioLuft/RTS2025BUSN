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
use MicroBit;
with MicroBit.DisplayRT;
with MicroBit.DisplayRT.Symbols;
with MicroBit.Buttons; use MicroBit.Buttons;
use MicroBit;

procedure Main with Priority => 0 is
begin
   loop
   if MicroBit.Buttons.State (Button_A) = Pressed then
      MicroBit.DisplayRT.Display ('A');
      Put_Line ("Pressed A");
   elsif MicroBit.Buttons.State (Button_B) = Pressed then
      MicroBit.DisplayRT.Display ('B');
      Put_Line ("Pressed B");
   elsif MicroBit.Buttons.State (Logo) = Pressed then
      DisplayRT.Symbols.Heart;
      Put_Line ("Pressed L");
   else
      MicroBit.DisplayRT.Clear;
   end if;
   end loop;
end Main;
