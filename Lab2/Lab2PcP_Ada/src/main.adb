with Ada.Text_IO;         use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Ada.Float_Text_IO;   use Ada.Float_Text_IO;
with Ada.Numerics.Discrete_Random;

procedure Main is

   task type MinElementSearchTask is
      pragma Storage_Size (10_000_000);
   end MinElementSearchTask;

   task body MinElementSearchTask is

      NumOfThreads  : constant Integer := 4;
      NumOfElements : constant Integer := 1_000_000;

      ArrayOfElements : array (1 .. NumOfElements) of Integer;
      type IndexRange is range 1 .. NumOfElements;

      protected UpdateHandler is
         procedure SetMinimumIndex (FoundMinIndex : in Integer);
         entry GetMinimumIndex (Index : out Integer);
      private
         MinIndex     : Integer := ArrayOfElements'First;
         NumOfTasks   : Integer := 0;
      end UpdateHandler;

      task type ElementSearcher is
         entry Start (StartIndex, EndIndex : in Integer);
      end ElementSearcher;

      function FindMinimumIndex (StartIndex, EndIndex : in Integer) return Integer
      is
         CurrentMinIndex : Integer := StartIndex;
      begin
         for Index in StartIndex .. EndIndex loop
            if ArrayOfElements(Index) < ArrayOfElements(CurrentMinIndex) then
               CurrentMinIndex := Index;
            end if;
         end loop;
         return CurrentMinIndex;
      end FindMinimumIndex;

      task body ElementSearcher is
         StartIndex, EndIndex : Integer;
         FoundMinIndex : Integer := 0;
      begin
         accept Start (StartIndex, EndIndex : in Integer) do
            ElementSearcher.StartIndex := StartIndex;
            ElementSearcher.EndIndex := EndIndex;
         end Start;
         FoundMinIndex :=
           FindMinimumIndex (StartIndex => StartIndex, EndIndex => EndIndex);
         UpdateHandler.SetMinimumIndex (FoundMinIndex);
      end ElementSearcher;

      type ElementSearcherArray is array (Integer range <>) of ElementSearcher;

      procedure InitializeArray is
      begin
         for Index in 1 .. NumOfElements loop
            ArrayOfElements (Index) := Index;
         end loop;
      end InitializeArray;

      procedure SetRandomMinimum is
         package RandomIntegers is new Ada.Numerics.Discrete_Random (IndexRange);
         use RandomIntegers;
         RandomIndex : Integer;
         RandomGen   : Generator;
      begin
         Reset (RandomGen);
         RandomIndex := Integer (Random (RandomGen));
         ArrayOfElements (RandomIndex) := -111;
         Put_Line("New minimum set - index:" & RandomIndex'Img & " number:" &
            ArrayOfElements (RandomIndex)'Img);
      end SetRandomMinimum;

      protected body UpdateHandler is
         procedure SetMinimumIndex (FoundMinIndex : in Integer) is
         begin
            if ArrayOfElements (FoundMinIndex) < ArrayOfElements (MinIndex) then
               MinIndex := FoundMinIndex;
            end if;
            NumOfTasks := NumOfTasks + 1;
         end SetMinimumIndex;

         entry GetMinimumIndex (Index : out Integer) when NumOfTasks = NumOfThreads is
         begin
            Index := MinIndex;
         end GetMinimumIndex;

      end UpdateHandler;

      procedure ParallelSearch is
         Step         : Integer := ArrayOfElements'Length / NumOfThreads;
         Threads      : ElementSearcherArray (1 .. NumOfThreads);
         Boundary     : Integer := ArrayOfElements'First;
         ResultMinIndex : Integer := 0;
      begin
         for I in 1 .. (NumOfThreads - 1) loop
            Put_Line(I'Img & " part have bounds: Left:" & Integer'Image (Boundary) & " Right:" &
                 Integer'Image (Boundary + Step));

            Threads (I).Start (Boundary, Boundary + Step);
            Boundary := Boundary + Step;
         end loop;
         Put_Line("The last part have bounds: Left:" & Integer'Image (Boundary) & " Right:" &
              Integer'Image (NumOfElements));

         Threads (Threads'Last).Start (Boundary, NumOfElements);

         UpdateHandler.GetMinimumIndex (ResultMinIndex);

         Put_Line ("Minimal element in array: " & ArrayOfElements (ResultMinIndex)'Img);
         Put_Line ("Index of minimal element in array: " & ResultMinIndex'Img);
      end ParallelSearch;

   begin
      InitializeArray;
      SetRandomMinimum;
      ParallelSearch;

   end MinElementSearchTask;

   FindMinimum : MinElementSearchTask;

begin
   null;
end Main;
