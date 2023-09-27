//Lezione Denny 26/09
codeunit 50100 Prove
{
    trigger OnRun()
    begin

    end;

    var
        myInt: Integer;
    //
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
        CustomerLbl: Label 'Cliente :'; //testo fisso che poi devo tradurre
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

    local procedure GetRecord()
    var
        Cust: Record Customer;
        SalesP: Record "Salesperson/Purchaser";
        SalesHdr: Record "Sales Header";
        CustNo: Code[20];
    begin
        Message(Cust.Name); // "stringa vuota"

        Cust.Get('101016');
        Message(Cust.Name); // Cannon Group SpA

        if SalesP.Get(Cust."Salesperson Code") then
            Message('Esiste agente')
        else
            Message('Agente non settato');

        CustNo := '20000';
        Cust.Get(CustNo);

        SalesHdr.Get(SalesHdr."Document Type"::Order, '1003');



    end;

    local procedure FindSomething()
    var
        Vend: Record Vendor;
        LocCode1: Code[10];
        LocCode2: Code[10];
        Cust: Record Customer;
        SalesHdr: Record "Sales Header";

    begin
        if Vend.FindSet() = true then
            repeat
            until Vend.Next() = 0;

        //Dati ordinati in base alla chiave primaria PK

        //Vend.FindFirst();
        //Vend.FindLast();
        LocCode1 := 'BLU';
        LocCode2 := 'ROSSO';
        Vend.SetFilter("Location Code", '%1|%2', LocCode1, Cust."Location Code");
        Vend.SetFilter("Location Code", LocCode1 + '|' + LocCode2);

        Vend.SetFilter("Location Code", 'BLU|ROSSO');

        Vend.SetFilter(Name, 'A*');
        Vend.SetFilter(Balance, '>50');

        Vend.SetFilter(Balance, '=1200');
        Vend.SetFilter(Balance, '1200');

        Vend.SetFilter(Balance, '>=1000&<=2000');
        Vend.SetFilter(Balance, '1200', 2000);
        Vend.SetFilter(Balance, '7000');


        Vend.SetRange(Balance); //-> Senza paramentr = togli i filtri impostati!

        Vend.SetCurrentKey(Name, City);
        Vend.Ascending := false; //modo discendente Z-A

        if not Vend.IsEmpty() then;

        SalesHdr.SetRange("Document Type", SalesHdr."Document Type"::Invoice)


    end;

    local procedure WriteSomething() //inserimento di un record
    var
        Vend: Record Vendor;
        Cust: Record Customer;
        SalesHdr: Record "Sales Header";
    begin
        Cust."No." := 'Test.01';
        Cust.Name := 'Sono io';
        //...
        if not Cust.Insert() then;
        //...;

        Cust.Get('10000');
        Cust.Name := 'Paolo Rossi'; //Non fa partire il trigger OnValidate
        Cust.Validate(Name, 'Paolo Rossi'); // Crea sia il nome e sia fa partire il Trigger OnValidate sul Nome
        Cust.City := 'Vicenza';
        //...
        Cust.Modify(true); // true nella parentesi per attivare il RunTrigger

        Cust.SetRange("Location Code", 'BLU');
        if Cust.FindSet() then
            repeat
                Cust."Location Code" := 'ROSSO';
                Cust.Modify();
            until Cust.Next() = 0;

        //Microsoft per fare la modifica massiva veloce ha creato ModifyAll
        //con ModifyAll è più ottimizzato e fa la stessa cosa

        Cust.SetRange("Location Code", 'BLU');
        Cust.ModifyAll("Location Code", 'ROSSO', true); // true-> attiva Trigger

        Cust.Get('10000');
        Cust.Delete();

        //Microsoft per fare la cancellazione massiva veloce ha creato DeleteAll
        //con DeleteAll è più ottimizzato e fa la stessa cosa

        Cust.SetRange("Location Code", 'BLU');
        Cust.DeleteAll();

        Cust.SetRange("Location Code", 'BLU');
        if not Cust.IsEmpty then
            Cust.DeleteAll();

    end;

}