codeunit 50105 "Type Helper AVDV"
{
    internal procedure ExtractIntegerFromText(String: Text) GameNumber: Integer
    var
        CharsToKeep: Text;
        NumbersOnlyText: Text;
        ConvertToIntegerErr: Label 'Error: Could not convert the value ''%1'' to a Integer', Comment = '%1 = Integer as Text (1,2,3)';
    begin
        CharsToKeep := '0123456789';
        NumbersOnlyText := DelChr(String, '=', DelChr(String, '=', CharsToKeep));
        if not Evaluate(GameNumber, NumbersOnlyText) then
            Error(ConvertToIntegerErr, NumbersOnlyText);
    end;
}