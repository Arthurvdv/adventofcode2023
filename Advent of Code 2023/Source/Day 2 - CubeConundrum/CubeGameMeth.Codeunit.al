codeunit 50104 "Cube Game Meth AVDV"
{
    var
        TempCubeGameBagContent: Record "Cube Game Configuration AVDV" temporary;
        TempCubeGame: Record "Cube Game AVDV" temporary;

    internal procedure SetInitialBagContent(Color: Enum "Color AVDV"; Quantity: Integer)
    begin
        TempCubeGameBagContent.Init();
        TempCubeGameBagContent.Validate("Cube Color.", Color);
        TempCubeGameBagContent.Validate(Quantity, Quantity);
        TempCubeGameBagContent.Insert(true);
    end;

    internal procedure Calculate(String: Text; var Result: Integer; var Power: Integer)
    var
        GameNumbers: List of [Integer];
        GameNumber: Integer;
    begin
        PopulateCubeTables(String);

        // Mark record that exceed the Bag Content amount
        if TempCubeGame.FindSet() then
            repeat
                TempCubeGameBagContent.Get(TempCubeGame."Cube Color.");
                if TempCubeGame.Quantity > TempCubeGameBagContent.Quantity then begin
                    TempCubeGame.Validate("Exceed Bag Content", true);
                    TempCubeGame.Modify(true);
                end;

                if not GameNumbers.Contains(TempCubeGame."Game No.") then
                    GameNumbers.Add(TempCubeGame."Game No.");
            until TempCubeGame.Next() = 0;

        foreach GameNumber in GameNumbers do
            Power += CalculatePower(GameNumber);

        // Create a disctinct list of the Game Numbers where no Round has exceeded the Bag Content amount
        Clear(GameNumbers);
        TempCubeGame.SetFilter("Game No.", PopulateFilterOfGameNumbers(true));
        if TempCubeGame.FindSet() then
            repeat
                if not GameNumbers.Contains(TempCubeGame."Game No.") then
                    GameNumbers.Add(TempCubeGame."Game No.");
            until TempCubeGame.Next() = 0;
        TempCubeGame.SetRange("Game No.");

        foreach GameNumber in GameNumbers do
            Result += GameNumber;
    end;

    local procedure PopulateCubeTables(String: Text)
    var
        TypeHelper: Codeunit "Type Helper";
        Line: Text;
    begin
        foreach Line in String.Split(TypeHelper.LFSeparator()) do
            if StrLen(Line) > 0 then
                AddCubeTable(Line);
    end;

    local procedure AddCubeTable(String: Text)
    var
        TypeHelper: Codeunit "Type Helper AVDV";
        ColonTok: Label ':', Locked = true;
        SemicolonTok: Label ';', Locked = true;
        CommaTok: Label ',', Locked = true;
        GameNumber, RoundNumber : Integer;
        Round, Result : Text;
    begin
        GameNumber := TypeHelper.ExtractIntegerFromText(String.Substring(1, String.IndexOf(ColonTok)));

        foreach Round in String.Substring(String.IndexOf(ColonTok) + 1).Split(SemicolonTok) do
            foreach Result in Round.Trim().Split(CommaTok) do begin
                RoundNumber += 1;

                Clear(TempCubeGame);
                TempCubeGame.Init();
                TempCubeGame.Validate("Game No.", GameNumber);
                TempCubeGame.Validate("Round No.", RoundNumber);
                TempCubeGame.Validate("Cube Color.", Enum::"Color AVDV".FromInteger("Color AVDV".Ordinals().Get("Color AVDV".Names().IndexOf(GetColor(Result)))));
                TempCubeGame.Validate(Quantity, TypeHelper.ExtractIntegerFromText(Result));
                TempCubeGame.Insert(true);
            end;
    end;

    local procedure GetColor(String: Text): Text
    var
        Color: Text;
    begin
        foreach Color in Enum::"Color AVDV".Names() do
            if String.ToLower().Contains(Color.ToLower()) then
                exit(Color);
    end;


    internal procedure PopulateFilterOfGameNumbers(Exceeded: Boolean): Text
    var
        GameNumber: Integer;
        TextBuilder: TextBuilder;
        SeparatorTok: Label '&', Locked = true;
        NotEqualLbl: Label '<>%1', Locked = true;
    begin
        foreach GameNumber in GetListOfGameNumbers(Exceeded) do begin
            TextBuilder.Append(StrSubstNo(NotEqualLbl, GameNumber));
            TextBuilder.Append(SeparatorTok);
        end;

        exit(TextBuilder.ToText().TrimEnd(SeparatorTok));
    end;

    local procedure GetListOfGameNumbers(Exceeded: Boolean) GameNumbers: List of [Integer]
    begin
        TempCubeGame.SetRange("Exceed Bag Content", Exceeded);
        if TempCubeGame.FindSet() then
            repeat
                if not GameNumbers.Contains(TempCubeGame."Game No.") then
                    GameNumbers.Add(TempCubeGame."Game No.");
            until TempCubeGame.Next() = 0;
        TempCubeGame.SetRange("Exceed Bag Content");
    end;

    local procedure ProcessColorQuantity(var SelectedTempCubeGame: Record "Cube Game AVDV" temporary; var TempCubeGamePower: Record "Cube Game Configuration AVDV" temporary)
    begin
        if not TempCubeGamePower.Get(SelectedTempCubeGame."Cube Color.") then begin
            TempCubeGamePower.Init();
            TempCubeGamePower.Validate("Cube Color.", SelectedTempCubeGame."Cube Color.");
            TempCubeGamePower.Validate(Quantity, SelectedTempCubeGame.Quantity);
            TempCubeGamePower.Insert(true);
        end else begin
            if TempCubeGamePower.Quantity <= SelectedTempCubeGame.Quantity then
                exit;

            TempCubeGamePower.Validate(Quantity, SelectedTempCubeGame.Quantity);
            TempCubeGamePower.Modify(true);
        end;
    end;

    local procedure CalculatePower(GameNumber: Integer) Result: Integer
    var
        Color: Text;
    begin
        TempCubeGame.SetRange("Game No.", GameNumber);
        foreach Color in Enum::"Color AVDV".Names() do begin
            TempCubeGame.SetRange("Cube Color.", Enum::"Color AVDV".FromInteger("Color AVDV".Ordinals().Get("Color AVDV".Names().IndexOf(GetColor(Color)))));
            TempCubeGame.SetCurrentKey(Quantity);
            TempCubeGame.Find('+');
            if Result = 0 then
                Result := TempCubeGame.Quantity
            else
                Result := Result * TempCubeGame.Quantity;
        end;
        TempCubeGame.SetRange("Game No.");
        TempCubeGame.SetRange("Cube Color.");
    end;
}