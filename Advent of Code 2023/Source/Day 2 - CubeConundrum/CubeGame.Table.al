table 50101 "Cube Game AVDV"
{
    Caption = 'Cube Game';
    TableType = Temporary;

    fields
    {
        field(1; "Game No."; Integer)
        {
            Caption = 'Game No.';
        }
        field(2; "Round No."; Integer)
        {
            Caption = 'Round No.';
        }
        field(3; "Cube Color."; Enum "Color AVDV")
        {
            Caption = 'Cube Color';
        }
        field(4; Quantity; Integer)
        {
            Caption = 'Quantity';
        }
        field(10; "Exceed Bag Content"; Boolean)
        {
            Caption = 'Exceed Bag Content';
        }
    }

    keys
    {
        key(PK; "Game No.", "Round No.")
        {
            Clustered = true;
        }
    }
}