codeunit 50100 Prove
{
    trigger OnRun()
    begin

    end;

    var
        myInt: Integer;

    local procedure Test()
    var
        IntVal: Integer;
        DecVal: Decimal;
        Msg: Text;
        DatVal: Date;

    begin
        //Codice
        IntVal := 2;
        DecVal := 20.10;

        Msg := 'Ciaoo' + 'mondoo';

        /*  
        Msg := 'Ciaoo';
        Msg += 'mondoo';    stessa concatenazione, ma su righe diverse
        */

        DatVal := 0D;  // Data vuota
        DatVal := 20230926D; // 26/09/2023

        if Msg <> '' then
            Message(Msg);

        if IntVal > 9 then begin
            DecVal := IntVal;
            DatVal := 0D;

        end else begin
            Msg := 'OK';
            //Altre istruzioni

        end;

        if not ((IntVal <= 0) and (DecVal > 1))
        or (DatVal <> 0D) then begin

        end;

        if IntVal = 0 then
            if DecVal > 2 then begin

            end;

        case intVal of
            1: // CASO 1
                begin
                    Message(Msg);
                    //...
                end;

            2, 3, 4, 5:  // TUTTI GLI ALTRI CASI
                begin

                end;

            10 .. 20:  // DAL CASO 10 AL CASO 20 
                begin

                end;

            else begin

            end;

        end;

    end;

    local procedure AltroTest()
    var

    begin
        //Codice

    end;

    local procedure DoWhileLoop()
    var
        A: Integer;
    begin
        myInt := 10;
        while myInt > 0 do begin
            //...
            myInt := myInt - 1;
            //myInt -= 1; forma contratta

            if A = 0 then
                break;
        end;
    end;

    local procedure RepetUntilLoop()
    var
        Cust: Record Customer; //dicharato variabile di tipo complesso
        TextVal: Text;
    begin

        myInt := 10;

        repeat
            Message((Format(myInt)));
            myInt := myInt - 1;

        until myInt > 0;

        Cust.SetRange("Country/Region Code", 'IT'); //filtra con IT
        if Cust.FindSet() then
            repeat
                Message(cust.Name);
                TextVal := 'Cliente: ' + cust.Name;
            until Cust.Next() = 0;

    end;

    local procedure ForLoop()
    var
        I: Integer;
    begin
        myInt := 3;
        for I := 1 to myInt do begin
            Message(Format(i));
            // ...
        end;

    end;

    local procedure ForEachLoop()
    var
        Names: List of [Text];
        I: Integer;
        Txt: Text;
    begin
        Names.Add('Gianni');
        Names.Add('Paolo');
        Names.Add('Marcella');

        for I := 1 to Names.Count() do begin
            Txt := Names.Get(I);
            Message(Txt);
        end;

        foreach Txt in Names do begin
            Message(Txt);
        end;


    end;


}