codeunit 50100 "Callibration Meth AVDV"
{
    internal procedure Calculate(String: Text) Result: Integer
    var
        TypeHelper: Codeunit "Type Helper";
        Line: Text;
    begin
        foreach Line in String.Split(TypeHelper.LFSeparator()) do
            if StrLen(Line) > 0 then
                Result += GetFirstAndLastNumber(Line);
    end;

    local procedure GetFirstAndLastNumber(String: Text) Result: Integer
    var
        INumberSearch: Interface "INumberSearch AVDV";
        FirstNumber, LastNumber : Integer;
        ConvertToIntegerErr: Label 'There was a problem combining %1 and %2 into a Integer', Comment = '%1 = Integer, %2 = Integer';
    begin
        INumberSearch := Enum::"Number Search AVDV"::First;
        FirstNumber := INumberSearch.GetNumber(String);

        INumberSearch := Enum::"Number Search AVDV"::Last;
        LastNumber := INumberSearch.GetNumber(String);

        if not Evaluate(Result, StrSubstNo(Format(FirstNumber) + Format(LastNumber))) then
            Error(ConvertToIntegerErr, FirstNumber, LastNumber);
    end;
}