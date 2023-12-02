codeunit 50102 "Number Search First AVDV" implements "INumberSearch AVDV"
{
    var
        NumberSearchHelper: Codeunit "Number Search Helper AVDV";

    procedure GetNumber(Value: Text): Integer
    var
        SearchValue: Text;
        i: Integer;
        Results: Dictionary of [Integer, Text];
    begin
        foreach SearchValue in NumberSearchHelper.GetSearchValues() do begin
            i := Value.IndexOf(SearchValue);
            if i <> 0 then
                Results.Add(i, SearchValue);
        end;
        i := NumberSearchHelper.BubbleSort(Results.Keys()).Get(1);
        exit(NumberSearchHelper.ConvertToInteger(Results.Get(i)));
    end;
}