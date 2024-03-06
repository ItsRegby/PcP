with Ada.Text_IO;

procedure Firstlabpcp is
   Can_Stop : Boolean := False;
   pragma Atomic(Can_Stop);
   numOfThreads : Integer := 5;

   task type Break_Thread;
   task type Main_Thread is
      entry Start(Thread_Id: Integer; Step: Long_Long_Integer);
   end Main_Thread;

   task body Break_Thread is
   begin
      delay 2.0;
      Can_Stop := True;
   end Break_Thread;

   task body Main_Thread is
      Sum : Long_Long_Integer := 0;
      Elements : Long_Long_Integer := 0;
      sequenceNumber : Long_Long_Integer := 0;
      My_Id: Integer;
      My_Step: Long_Long_Integer;
   begin
      accept Start(Thread_Id: Integer; Step: Long_Long_Integer) do
         My_Id := Thread_Id;
         My_Step := Step;
      end Start;

      loop
         Sum := Sum + sequenceNumber;
         Elements := Elements + 1;
         sequenceNumber := sequenceNumber + My_Step;

         delay 0.1;

         exit when Can_Stop;
      end loop;

      Ada.Text_IO.Put_Line("Thread: " & My_Id'Img & " Sum: " & Sum'Img & " Count: " & Elements'Img);
   end Main_Thread;

   bt1: Break_Thread;
   Threads : array(1..numOfThreads) of Main_Thread;
begin
   for I in 1..numOfThreads loop
      Threads(I).Start(Thread_ID => I,Step => 1);
   end loop;
   --Threads(1).Start(Thread_ID => 111,Step => 1);
   --Threads(I).Start(Thread_ID => 222,Step => 2);
end Firstlabpcp;
