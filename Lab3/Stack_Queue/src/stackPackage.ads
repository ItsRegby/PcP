with Ada.Text_IO; use Ada.Text_IO;

package stackPackage is 
    stackSize: constant integer := 10;                  -- stack size
    
    type stack is array(integer range<>) of Integer;    -- stack array
   
    type stackStruct(stackSize: Integer) is record      -- stack structure
        st: stack(1..stackSize);
        ptr: Integer := 0;   
    end record;

    protected stackBuffer is
        Entry Write(Item: in Integer; Id:Integer);
        Entry Read(Item: Out Integer; Id:Integer);
               
    private
        bufferSize: Integer := stackSize;
        s: stackStruct(stackSize);

        procedure push(Item: in Integer);
        procedure pop(Item: out Integer);
    end stackBuffer;

end stackPackage;
