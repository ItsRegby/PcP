with Ada.Text_IO, GNAT.Semaphores;
use Ada.Text_IO, GNAT.Semaphores;
with Ada.Containers.Indefinite_Doubly_Linked_Lists;
use Ada.Containers;
with Ada.Numerics.Discrete_Random;

procedure Main is
   package String_Lists is new Indefinite_Doubly_Linked_Lists (String);
   use String_Lists;

   type RandRange is range 1 .. 100;

   protected ItemControl is
      procedure Set_Production_Count (Total : in Integer);
      procedure Decrement_Produced_Count;
      procedure Decrement_Consumed_Count;
      function Is_Production_Complete return Boolean;
      function Is_Consumption_Complete return Boolean;
   private
      Left_Produced : Integer := 0;
      Left_Consumed : Integer := 0;
   end ItemControl;

   protected body ItemControl is
      procedure Set_Production_Count (Total : in Integer) is
      begin
         Left_Produced := Total;
         Left_Consumed := Total;
      end Set_Production_Count;

      procedure Decrement_Produced_Count is
      begin
         if Left_Produced > 0 then
            Left_Produced := Left_Produced - 1;
         end if;
      end Decrement_Produced_Count;

      procedure Decrement_Consumed_Count is
      begin
         if Left_Consumed > 0 then
            Left_Consumed := Left_Consumed - 1;
         end if;
      end Decrement_Consumed_Count;

      function Is_Production_Complete return Boolean is
      begin
         return Left_Produced = 0;
      end Is_Production_Complete;

      function Is_Consumption_Complete return Boolean is
      begin
         return Left_Consumed = 0;
      end Is_Consumption_Complete;

   end ItemControl;

   Storage_Size  : Integer := 3;
   Num_Suppliers : Integer := 1;
   Num_Receivers : Integer := 4;
   Total_Items   : Integer := 10;

   Storage        : List;
   Access_Control : Counting_Semaphore (1, Default_Ceiling);
   Full_Storage   : Counting_Semaphore (Storage_Size, Default_Ceiling);
   Empty_Storage  : Counting_Semaphore (0, Default_Ceiling);

   task type Supplier_Task is
      entry Initialize (Num : Integer);
   end Supplier_Task;

   task body Supplier_Task is
      package Random_Int is new Ada.Numerics.Discrete_Random (RandRange);
      use Random_Int;
      Supplier_Id   : Integer;
      Random_Gen : Generator;
      Item_Value : Integer;
   begin
      accept Initialize (Num : Integer) do
         Supplier_Id := Num;
      end Initialize;
      Reset (Random_Gen);
      while not ItemControl.Is_Production_Complete loop
         ItemControl.Decrement_Produced_Count;
         Full_Storage.Seize;
         Access_Control.Seize;

         Item_Value := Integer (Random (Random_Gen));
         Storage.Append ("item" & Item_Value'Img);
         Put_Line ("Supplier #" & Supplier_Id'Img & " adds item" & Item_Value'Img);

         Access_Control.Release;
         Empty_Storage.Release;
      end loop;
      Put_Line
        ("Supplier #" & Supplier_Id'Img &
         " finished working");
   end Supplier_Task;

   task type Receiver_Task is
      entry Initialize (Num : Integer);
   end Receiver_Task;

   task body Receiver_Task is
      Receiver_Id : Integer;
   begin
      accept Initialize (Num : Integer) do
         Receiver_Id := Num;
      end Initialize;
      while not ItemControl.Is_Consumption_Complete loop
         ItemControl.Decrement_Consumed_Count;
         Empty_Storage.Seize;
         Access_Control.Seize;

         declare
            Item_Value : String := First_Element (Storage);
         begin
            Put_Line
              ("Receiver #" & Receiver_Id'Img & " took " & Item_Value);
            Storage.Delete_First;

            Access_Control.Release;
            Full_Storage.Release;
         end;
      end loop;
      Put_Line("Receiver #" & Receiver_Id'Img & " finished working");
   end Receiver_Task;

   type Supplier_Array is array (Integer range <>) of Supplier_Task;
   type Receiver_Array is array (Integer range <>) of Receiver_Task;

begin
   declare
      Suppliers : Supplier_Array (1 .. Num_Suppliers);
      Receivers : Receiver_Array (1 .. Num_Receivers);
   begin
      ItemControl.Set_Production_Count (Total => Total_Items);

      for I in 1 .. Num_Suppliers loop
         Suppliers (I).Initialize (I);
      end loop;

      for I in 1 .. Num_Receivers loop
         Receivers (I).Initialize (I);
      end loop;

   end;
end Main;
