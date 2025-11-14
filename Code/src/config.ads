package Config is
   --Periods (milliseconds)
   Sense_Period_ms : constant := 200; --20 ms is too fast for ultrasonic sensors, so I just made it a little longer for testing
   Think_Period_ms : constant := 100; --changed it from 50 to 100 ms to give more time for processing
   Act_Period_ms   : constant := 40;  --this is stable actuation, but we can possibly reduce it to 20–30 ms after testing

   --Task priorities (the higher number => the higher priority)
   Priority_Think : constant := 3;  --priority
   Priority_Sense : constant := 2;  --
   Priority_Act   : constant := 1;  --

   --Decision thresholds (in meters, of course)
   Obstacle_Threshold_m : constant := 0.25;
   Caution_Threshold_m  : constant := 0.40;

   --The motor speed, from the analog_value: value from 0-1023)
   Speed_Fast   : constant := 512;
   Speed_Medium : constant := 400;
   Speed_Slow   : constant := 300;
end Config;
