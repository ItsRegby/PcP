package body stackPackage is 
    protected body stackBuffer is
        Entry Write(Item: in Integer; Id: Integer) when s.ptr < bufferSize is begin
            Put_Line("Producer "&Integer'image(Id)&" is accessing shared resource");
            push(Item);
            Put_Line("Producer" &Integer'Image(Id)&" wrote "&Integer'Image(Item));
            Put_Line("Producer "&Integer'image(Id)&" is releasing shared resource");
        end Write;
        
        Entry Read(Item: out Integer; Id:Integer) when s.ptr > 0 is begin
            Put_Line("Consumer "&Integer'image(Id)&" is accessing shared resource");
            pop(Item);
            Put_Line("Consumer" &Integer'Image(Id)&" read"&Integer'Image(Item));
            Put_Line("Consumer "&Integer'image(Id)&" is releasing shared resource");
        end Read;

        procedure push(Item: in Integer) is begin
            s.ptr := s.ptr + 1;   
            s.st(s.ptr) := Item;
        end push;
    
        procedure pop(Item: out Integer) is begin
            Item := s.st(s.ptr);
            s.ptr := s.ptr - 1;
        end pop;
    end stackBuffer;

end stackPackage;
