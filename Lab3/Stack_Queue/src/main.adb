with Ada.Text_IO; use Ada.Text_Io;
with Ada.Numerics.Float_Random; use Ada.Numerics.Float_Random;
with queuePackage; use queuePackage;
with stackPackage; use stackPackage;

procedure Main is
   task type Producer(Id: Positive) is
      Entry Stop;
   end Producer;

   task body Producer is
      n: Integer;
      G: Generator;
   begin
        Reset(G);
      loop
         select
            accept Stop;
            exit;
         or
            delay Duration(Random(G)*1.0);
         end select;

         n := Integer(Random(G)*100.0);
         Put_Line("Producer "&Integer'Image(Id)&" is trying to lock the buffer");
         --queueBuffer.Write(n, Id);
         stackBuffer.Write(n, Id);
         Put_Line("Producer "&Integer'Image(Id)&" has released the buffer");  
      end loop;
   end Producer;

   task type Consumer(Id: Positive) is
      Entry Stop;
   end Consumer;

   task body Consumer is
      n: Integer;
      G: Generator;
   begin
      loop
         select
            accept stop;
            exit;
         or
            delay Duration(Random(G)*1.0);
         end select;

         Put_Line("Consumer "&Integer'Image(Id)&" is trying to lock the buffer");
         --queueBuffer.Read(n, Id);
         stackBuffer.Read(n, Id);
         Put_Line("Consumer "&Integer'Image(Id)&" has released the buffer");
      end loop;
   end Consumer;
   
   P1 : Producer(1);
   P2 : Producer(2);
   P3 : Producer(3);
   P4 : Producer(4);
   --  P5 : Producer(5);

   C1 : Consumer(1);
   C2 : Consumer(2);
   --  C3 : Consumer(3);
begin
   delay 5.0;       -- simulation will end after this period of time (in seconds as Float)
   P1.Stop;
   P2.Stop;
   P3.Stop;
   P4.Stop;
   --  P5.Stop;

   C1.Stop;
   C2.Stop;
   --  C3.Stop;
end Main;
