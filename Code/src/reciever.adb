with MicroBit.Radio; use MicroBit.Radio;
with MicroBit.Console; use MicroBit.Console;
with MicroBit.DisplayRT; use MicroBit.DisplayRT;
with MicroBit.DisplayRT.Symbols;
use MicroBit;
with LSM303AGR; use LSM303AGR;
with ada.Real_Time; use ada.Real_Time;

procedure Main is
   RXdata : RadioData;
   X, Y : Axis_Data;
   Threshold : constant := 200;
   myClock : Time;
   Packet_Received : Boolean := False;
begin
   Put_Line("Receiver starting...");

   -- Setup radio with same parameters as transmitter
   Radio.Setup(RadioFrequency => 2407,
               Length => 6,
               Version => 1,
               Group => 1,
               Protocol => 1);

   Radio.StartReceiving;
   Symbols.Sad; -- Show sad face until we get data

   loop
      myClock := Clock;
      Packet_Received := False;

      while Radio.DataReady loop
         RXdata := Radio.Receive;
         Packet_Received := True;

         X := LSM303AGR.Convert(RXdata.Payload(1), RXdata.Payload(2));
         Y := LSM303AGR.Convert(RXdata.Payload(3), RXdata.Payload(4));

         if Y > Threshold then
            Symbols.Down_Arrow;
         elsif Y < -Threshold then
            Symbols.Up_Arrow;
         elsif X > Threshold then
            Symbols.Right_Arrow;
         elsif X < -Threshold then
            Symbols.Left_Arrow;
         else
            Symbols.Heart;
         end if;
      end loop;

      -- If we haven't received data for a while, show sad face
      if not Packet_Received then
         Symbols.Sad;
      end if;

      delay until myClock + Milliseconds(50);
   end loop;
end Main;
