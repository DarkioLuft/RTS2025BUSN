
with MicroBit.IOsForTasking; use MicroBit.IOsForTasking;
with MicroBit.MotorDriver;  use MicroBit.MotorDriver;

package body MyMotorDriver is

   Speed : constant Analog_Value := 512; --between 0 and 1023 as defned before s

   procedure DriveForward is
   begin
      MicroBit.MotorDriver.Drive(Forward,(4095,4095,4095,4095)); --max speed
   end DriveForward;

   procedure DriveBackward is
   begin
      MicroBit.MotorDriver.Drive(Backward,(4095,4095,4095,4095));
   end DriveBackward;

   procedure TurnLeft is
   begin
      MicroBit.MotorDriver.Drive(Left,(4095,4095,4095,4095));
   end TurnLeft;

   procedure TurnRight is
   begin
      MicroBit.MotorDriver.Drive(Right,(4095,4095,4095,4095));
   end TurnRight;

   procedure Stop is
   begin
      MicroBit.MotorDriver.Drive(Stop,(0,0,0,0));
   end Stop;

   protected body MotorDriver is
      procedure SetDirection (V : Directions) is
      begin
         DriveDirection := V;
      end SetDirection;

      function GetDirection return Directions is
      begin
         return DriveDirection;
      end GetDirection;
   end MotorDriver;

end MyMotorDriver;
