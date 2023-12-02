codeunit 80001 "Day 1: Trebuchet?! TST"
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
    procedure Day1TrebuchetTest()
    var
        SampleText: Text;
        CallibrationMeth: Codeunit "Callibration Meth AVDV";
    begin
        //[SCENARIO #0000] On each line, the calibration value can be found by combining the first digit and the last digit (in that order) to form a single two-digit number.
        Initialize();

        //[GIVEN] In this example, the calibration values of these four lines are 12, 38, 15, and 77. Adding these together produces 142.
        SampleText := GetSampleData();

        //[WHEN] Executing the Callibration
        LibraryVariableStorage.Enqueue(CallibrationMeth.Calculate(SampleText));

        //[THEN] The result should be 142
        LibraryAssert.AreEqual(142, LibraryVariableStorage.DequeueInteger(), 'The expected result should be of the value 142');
    end;

    local procedure GetSampleData(): Text
    var
        SampleText: TextBuilder;
    begin
        SampleText.AppendLine('1abc2');
        SampleText.AppendLine('pqr3stu8vwx');
        SampleText.AppendLine('a1b2c3d4e5f');
        SampleText.AppendLine('treb7uchet');
        exit(SampleText.ToText());
    end;

    [ConfirmHandler]
    procedure ConfirmHandler(Question: Text[1024]; var Reply: Boolean);
    begin
        LibraryDialogHandler.HandleConfirm(Question, Reply);
    end;

    [MessageHandler]
    procedure MessageHandler(Message: Text[1024]);
    begin
        LibraryDialogHandler.HandleMessage(Message);
    end;

    [StrMenuHandler]
    procedure StrMenuHandler(Options: Text[1024]; var Choice: Integer; Instruction: Text[1024]);
    begin
        LibraryDialogHandler.HandleStrMenu(Options, Choice, Instruction);
    end;
}