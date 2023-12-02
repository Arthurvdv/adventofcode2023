codeunit 50100 "Callibration Meth AVDV"
{
    internal procedure Calculate(Input: Text) Result: Integer
    var
        Lines: List of [Text];
        Line: Text;
    begin
        Lines := GetLines(Input);

        foreach Line in Lines do
            if StrLen(Line) > 0 then
                Result += GetFirstAndLastNumber(Line);
    end;

    local procedure GetFirstAndLastNumber(Text: Text) Result: Integer
    var
        CharsToKeep: Text;
        NumbersOnlyText: Text;
        FirstNumber, LastNumber : Integer;
    begin
        CharsToKeep := '0123456789';
        NumbersOnlyText := DelChr(Text, '=', DelChr(Text, '=', CharsToKeep));

        if not Evaluate(FirstNumber, NumbersOnlyText[1]) then
            Error('Could not find the first number');

        if not Evaluate(LastNumber, NumbersOnlyText[StrLen(NumbersOnlyText)]) then
            Error('Could not find the last number');

        if not Evaluate(Result, StrSubstNo(Format(FirstNumber) + Format(LastNumber))) then
            Error('There was a problem combining %1 and %2 into a Integer', FirstNumber, LastNumber);
    end;

    local procedure GetLines(Text: Text) Lines: List of [Text]
    var
        LineFeed: Char;
    begin
        LineFeed := 10;
        Lines := Text.Split(LineFeed);
    end;
}