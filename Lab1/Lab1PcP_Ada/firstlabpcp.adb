with Ada.Text_IO;

procedure Firstlabpcp is
   Can_Stop : Boolean := False;
   pragma Atomic(Can_Stop);
   numOfThreads : Integer := 2;

   task type Break_Thread;
   task type Main_Thread(Id: Integer; Step: Long_Long_Integer);

   task body Break_Thread is
   begin
      delay 2.0;
      Can_Stop := True;
   end Break_Thread;

   task body Main_Thread is
      Sum : Long_Long_Integer := 0;
      Elements : Long_Long_Integer := 0;
      sequenceNumber : Long_Long_Integer := 0;
   begin
      loop
         Sum := Sum + sequenceNumber;
         Elements := Elements + 1;
         sequenceNumber := sequenceNumber + Step;

         delay 0.1;

         exit when Can_Stop;
      end loop;

      Ada.Text_IO.Put_Line("Thread: " & Id'Img & " Sum: " & Sum'Img & " Count: " & Elements'Img);
   end Main_Thread;

   bt1: Break_Thread;
   Threads : array(1..numOfThreads) of access Main_Thread;
begin
   for I in 1..numOfThreads loop
      Threads(I) := new Main_Thread(Id => I, Step => 1);
   end loop;
   --Threads(1) := new Main_Thread(Id => 111, Step => 1);
   --Threads(2) := new Main_Thread(Id => 222, Step => 3);
end Firstlabpcp;
