codeunit 80002 "Day 2: Cube Conundrum TST"
{
    Subtype = Test;

    trigger OnRun()
    begin
        IsInitialized := false;
    end;

    var
        Any: Codeunit Any;
        LibraryAssert: Codeunit "Library Assert";
        LibraryDialogHandler: Codeunit "Library - Dialog Handler";
        LibraryLowerPermissions: Codeunit "Library - Lower Permissions";
        LibraryVariableStorage: Codeunit "Library - Variable Storage";
        TranslationHelper: Codeunit "Translation Helper";
        IsInitialized: Boolean;

    local procedure Initialize()
    begin
        Clear(LibraryVariableStorage);
        TranslationHelper.SetGlobalLanguageToDefault();

        if IsInitialized then
            exit;

        IsInitialized := true;
        Commit();
    end;


    [Test]
    procedure Day2CubeConundrumTest()
    var
        SampleData: Text;
        CubeGameMeth: Codeunit "Cube Game Meth AVDV";
        Result, Power : Integer;
    begin
        //[SCENARIO #0001] The Elf would first like to know which games would have been possible if the bag contained only 12 red cubes, 13 green cubes, and 14 blue cubes?
        Initialize();
        CubeGameMeth.SetInitialBagContent(Enum::"Color AVDV"::Red, 12);
        CubeGameMeth.SetInitialBagContent(Enum::"Color AVDV"::Green, 13);
        CubeGameMeth.SetInitialBagContent(Enum::"Color AVDV"::Blue, 14);

        //[GIVEN] In the example above, games 1, 2, and 5 would have been possible if the bag had been loaded with that configuration.
        SampleData := GetSampleData();

        //[WHEN] Executing the Callibration
        CubeGameMeth.Calculate(SampleData, Result, Power);

        //[THEN] However, game 3 would have been impossible because at one point the Elf showed you 20 red cubes at once; similarly, game 4 would also have been impossible because the Elf showed you 15 blue cubes at once. 
        // If you add up the IDs of the games that would have been possible, you get 8.
        LibraryAssert.AreEqual(8, Result, 'The expected result should be of the value 8');
        //The power of a set of cubes is equal to the numbers of red, green, and blue cubes multiplied together.
        LibraryAssert.AreEqual(2286, Power, 'The expected power should be of the value 2286');

    end;

    local procedure GetSampleData(): Text
    var
        SampleText: TextBuilder;
    begin
        SampleText.AppendLine('Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green');
        SampleText.AppendLine('Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue');
        SampleText.AppendLine('Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red');
        SampleText.AppendLine('Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red');
        SampleText.AppendLine('Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green');
        exit(SampleText.ToText());
    end;
}
