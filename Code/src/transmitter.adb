with MicroBit.Music; use MicroBit.Music;
with MicroBit.Radio; use MicroBit.Radio;
with MicroBit.Accelerometer; use MicroBit.Accelerometer;
with MicroBit.Console; use MicroBit.Console;
with MicroBit.DisplayRT; use MicroBit.DisplayRT; -- Add display
with MicroBit.DisplayRT.Symbols; -- Add symbols
use MicroBit;
with ada.Real_Time; use ada.Real_Time;

procedure Main is
   TXData : RadioData;
   X, Y, Z : Acceleration_Type;
   myClock : Time;
begin
   Put_Line("Transmitter starting...");

   -- Setup radio
   Radio.Setup(RadioFrequency => 2407,
               Length => 6,
               Version => 1,
               Group => 1,
               Protocol => 1);

   Symbols.Happy; -- Show a happy face to confirm program started

   loop
      myClock := Clock;

      -- Read accelerometer
      Read(X, Y, Z);

      -- Pack data into payload
      TXData.Length := 6;
      TXData.Version := 1;
      TXData.Group := 1;
      TXData.Protocol := 1;

      TXData.Payload(1) := UInt8(X and 16#FF#);
      TXData.Payload(2) := UInt8(Shift_Right(X, 8));
      TXData.Payload(3) := UInt8(Y and 16#FF#);
      TXData.Payload(4) := UInt8(Shift_Right(Y, 8));
      TXData.Payload(5) := UInt8(Z and 16#FF#);
      TXData.Payload(6) := UInt8(Shift_Right(Z, 8));

      Radio.Transmit(TXData);
      Symbols.Square; -- Brief flash when transmitting
      delay until myClock + Milliseconds(50);
      Clear_Display; -- Clear the flash

      delay until myClock + Milliseconds(50);
   end loop;
end Main;
