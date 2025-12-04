with MicroBit.MotorDriver; use MicroBit.MotorDriver;

package MyMotorDriver is
   procedure DriveForward;
   procedure DriveBackward;
   procedure TurnLeft;
   procedure TurnRight;
   procedure Stop;
---The protected object, to hold the current direction
   protected MotorDriver is
      function GetDirection return MicroBit.MotorDriver.Directions;
      procedure SetDirection (V : MicroBit.MotorDriver.Directions);
   private
      DriveDirection : MicroBit.MotorDriver.Directions := Stop;
   end MotorDriver;
end MyMotorDriver;
