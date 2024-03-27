package body queuePackage is 

    protected body queueBuffer is
        Entry Write(Item: in Integer; Id: Integer) when q.ptr < bufferSize is begin
            Put_Line("Producer "&Integer'image(Id)&" is accessing shared resource");
            enqueue(Item);
            Put_Line("Producer" &Integer'Image(Id)&" wrote"&Integer'Image(Item));
            Put_Line("Producer "&Integer'image(Id)&" is releasing shared resource");
        end Write;
        
        Entry Read(Item : out Integer; Id:Integer) when q.ptr > 0 is begin
            Put_Line("Consumer "&Integer'image(Id)&" is accessing shared resource");
            Dequeue(Item);
            Put_Line("Consumer" &Integer'Image(Id)&" read"&Integer'Image(Item));
            Put_Line("Consumer "&Integer'image(Id)&" is releasing shared resource");
        end Read;

        procedure enqueue(Item: in Integer) is begin
            q.ptr := q.ptr + 1;   
            q.que(q.ptr) := Item;
        end enqueue;
    
        procedure dequeue(Item: out Integer) is begin
            Item := q.que(1);
            
            for i in 2..q.ptr loop
                q.que(i-1) := q.que(i);			      
            end loop;
    
            q.ptr := q.ptr - 1;   
        end dequeue;
    end queueBuffer;

end queuePackage;
