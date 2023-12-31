//file chiamato così perchè microsoft chiama cosi gli oggetti
/*----------------------------------------------------------*/

table 50100 Student //nome deve essere al singolare - l'intervallo dell'id lo possiamo vedere in app.json
{
    DataClassification = CustomerContent;
    Caption = 'Student'; //traduzione

    fields
    {
        field(1; Code; code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Nr';
        }

        field(2; "Last Name"; Text[100])
        {

            DataClassification = CustomerContent;
            Caption = 'Last Name';
        }

        field(3; "First Name"; tEXT[100])
        {

            DataClassification = CustomerContent;
            Caption = 'First Name';
        }

        field(4; "City"; Text[50])
        {
            DataClassification = CustomerContent;
        }

        field(5; Contry; Code[10]) //ctrl+click su county/region per vedere di quanto è il campo lì se diverso mettere uguale
        {
            DataClassification = CustomerContent;
            TableRelation = "Country/Region";
        }

        field(10; Gender; Option)
        {
            OptionMembers = " ",Male,Female;
            Caption = 'Gender';
            OptionCaption = ' ,Male, Female';
            DataClassification = CustomerContent;
        }

        field(11; "Date of Birth"; Date)
        {
            DataClassification = ToBeClassified;



            trigger OnValidate()
            begin
                //calcolo dell'età
                //age := ...;
            end;
        }

        field(12; Age; Integer)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            BlankZero = true;
        }

        field(20; "Average Rating"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 2; //due numeri dopo la virgola
            BlankZero = true;
            MinValue = 0;
            MaxValue = 10;
        }


        field(21; Graduated; Boolean)
        {
            DataClassification = ToBeClassified;
        }

    }

    keys
    {
        key(PK; Code)
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    var
        MissingRatingErr: Label 'Rating required';

    begin
        TestField(Code);
        CheckIfGraduated();

        //Scrivere Rec.Gratuated è ugaule a scrivere Graduated

        if Graduated then
            TestField("Average Rating");

        //if Graduated then
        //if "Average Rating" = 0 then
        //Error(MissingRatingErr);

    end;

    trigger OnModify()
    begin
        CheckIfGraduated();
    end;

    local procedure CheckIfGraduated()
    begin
        if Graduated then begin
            TestField("Average Rating");
            TestField(Age);
            TestField(City);
        end;

        OnCheckIfGraduated(Rec);

    end;

    //per permettere a qualcuno di poter scrivere nel mio codice creo un evento

    [IntegrationEvent(false, false)]

    local procedure OnCheckIfGraduated(var Student: Record Student)
    begin

    end;

}



