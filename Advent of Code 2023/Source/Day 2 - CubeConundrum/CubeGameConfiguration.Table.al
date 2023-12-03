table 50100 "Cube Game Configuration AVDV"
{
    Caption = 'Cube Game Configuration';
    TableType = Temporary;

    fields
    {
        field(1; "Cube Color."; Enum "Color AVDV")
        {
            Caption = 'Cube Color';
        }
        field(3; Quantity; Integer)
        {
            Caption = 'Quantity';
        }
    }

    keys
    {
        key(PK; "Cube Color.")
        {
            Clustered = true;
        }
    }
}