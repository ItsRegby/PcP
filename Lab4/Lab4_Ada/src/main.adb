with Ada.Text_IO;     use Ada.Text_IO;
with GNAT.Semaphores; use GNAT.Semaphores;

procedure Main is
   task type PhilosopherRoom is
      entry Start (Philosopher_ID : Integer);
   end PhilosopherRoom;

   Forks : array (1 .. 5) of Counting_Semaphore (1, Default_Ceiling);

   -- room

   Dining_Room : Counting_Semaphore (4, Default_Ceiling);

   task body PhilosopherRoom is
      Philosopher_ID : Integer;
      Left_Fork_ID, Right_Fork_ID : Integer;
   begin
      accept Start (Philosopher_ID : in Integer) do
         PhilosopherRoom.Philosopher_ID := Philosopher_ID;
      end Start;
      Left_Fork_ID  := Philosopher_ID;
      Right_Fork_ID := Philosopher_ID rem 5 + 1;

      for I in 1 .. 10 loop
         Put_Line ("Philosopher " & Philosopher_ID'Img & " is hungry " & I'Img & " time");

         Dining_Room.Seize;
         Forks(Left_Fork_ID).Seize;
         Forks(Right_Fork_ID).Seize;

         Put_Line ("Philosopher " & Philosopher_ID'Img & " is eating " & I'Img & " time");

         Forks(Right_Fork_ID).Release;
         Forks(Left_Fork_ID).Release;
         Dining_Room.Release;

         Put_Line ("Philosopher " & Philosopher_ID'Img & " finished eating");
      end loop;
   end PhilosopherRoom;

   -- arbitrator --

   protected type MySemaphore (Start_Count : Integer := 1) is
      entry Lock;
      procedure Unlock;
      function Get_Count return Integer;
   private
      Counter : Integer := Start_Count;
   end MySemaphore;

   protected body MySemaphore is

      entry Lock when Counter > 0 is
      begin
         Counter := Counter - 1;
      end Lock;

      procedure Unlock is
      begin
         Counter := Counter + 1;
      end Unlock;

      function Get_Count return Integer is
      begin
         return Counter;
      end Get_Count;

   end MySemaphore;

   Fork_Semaphores : array (1 .. 5) of MySemaphore (1);
   Room_Semaphore : Counting_Semaphore (2, Default_Ceiling);

   task type PhilosopherArbitrator is
      entry Start (Philosopher_ID : Integer);
   end PhilosopherArbitrator;

   task body PhilosopherArbitrator is
      Philosopher_ID : Integer;
      Left_Fork_ID, Right_Fork_ID : Integer;
   begin
      accept Start (Philosopher_ID : in Integer) do
         PhilosopherArbitrator.Philosopher_ID := Philosopher_ID;
      end Start;
      Left_Fork_ID  := Philosopher_ID;
      Right_Fork_ID := Philosopher_ID rem 5 + 1;

      for I in 1 .. 10 loop
         Put_Line ("Philosopher " & Philosopher_ID'Img & " is hungry " & I'Img & " time");
         while True loop
            Room_Semaphore.Seize;
            if Fork_Semaphores(Left_Fork_ID).Get_Count > 0 and
               Fork_Semaphores(Right_Fork_ID).Get_Count > 0
            then
               Fork_Semaphores(Left_Fork_ID).Lock;
               Fork_Semaphores(Right_Fork_ID).Lock;
               exit;
            else
               Room_Semaphore.Release;
            end if;
         end loop;
         Room_Semaphore.Release;
         Put_Line ("Philosopher " & Philosopher_ID'Img & " is eating " & I'Img & " time");

         Fork_Semaphores(Left_Fork_ID).Unlock;
         Fork_Semaphores(Right_Fork_ID).Unlock;

         Put_Line ("Philosopher " & Philosopher_ID'Img & " finished eating");
      end loop;
   end PhilosopherArbitrator;

   Philosophers : array (1 .. 5) of PhilosopherArbitrator;
begin
   for I in Philosophers'Range loop
      Philosophers(I).Start(I);
   end loop;

end Main;
