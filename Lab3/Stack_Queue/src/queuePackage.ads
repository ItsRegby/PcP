with Ada.Text_IO; use Ada.Text_IO;

package queuePackage is 
    queueSize : constant integer := 10;                 -- queue size
    
    type queue is array(integer range<>) of Integer;    -- queue array
   
    type queueStruct(queueSize: Integer) is record      -- queue structure
        que: queue(1..queueSize);
        ptr: Integer := 0;   
    end record;

    protected queueBuffer is
        Entry Write(Item: in Integer; Id:Integer);
        Entry Read(Item: Out Integer; Id:Integer);
               
    private
        buffersize: Integer := queueSize;
        buffersize2: Integer := 100;
        q: queueStruct(queueSize);

        procedure enqueue(Item: in Integer);
        procedure dequeue(Item: out Integer);
    end queueBuffer;

end queuePackage;
