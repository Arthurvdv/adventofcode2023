codeunit 50101 "Number Search Helper AVDV"
{
    SingleInstance = true;

    var
        SearchValues: List of [Text];
        Initialized: Boolean;

    internal procedure GetSearchValues(): List of [Text]
    var
        i: Integer;
        "Key": Text;
    begin
        if Initialized then
            exit(SearchValues);

        for i := 1 to 9 do
            SearchValues.Add(Format(i));

        foreach "Key" in GetListOfNumbersAsText().Keys() do
            SearchValues.Add("Key");

        Initialized := true;
        exit(SearchValues);
    end;

    local procedure GetListOfNumbersAsText() Numbers: Dictionary of [Text, Integer]
    begin
        Numbers.Add('one', 1);
        Numbers.Add('two', 2);
        Numbers.Add('three', 3);
        Numbers.Add('four', 4);
        Numbers.Add('five', 5);
        Numbers.Add('six', 6);
        Numbers.Add('seven', 7);
        Numbers.Add('eight', 8);
        Numbers.Add('nine', 9);
    end;

    internal procedure ConvertToInteger(Value: Text) i: Integer
    var
        ConvertToIntegerErr: Label 'Error: Could not convert the value ''%1'' to a Integer', Comment = '%1 = Integer as Text (1,2,3 or one, two, three)';
    begin
        if Evaluate(i, Value) then
            exit;

        if not GetListOfNumbersAsText().ContainsKey(Value) then
            Error(ConvertToIntegerErr, Value);
        exit(GetListOfNumbersAsText().Get(Value));
    end;

    internal procedure BubbleSort(List: List of [Integer]): List of [Integer]
    var
        i, j : Integer;
        ListItem: Integer;
    begin
        for i := 1 to List.Count do
            for j := 1 to List.Count - 1 do
                if List.Get(i) < List.Get(j) then begin
                    ListItem := List.Get(i);
                    List.Set(i, List.Get(j));
                    List.Set(j, ListItem);
                end;
        exit(List);
    end;
}