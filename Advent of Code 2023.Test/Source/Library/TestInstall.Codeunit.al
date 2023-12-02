codeunit 80000 "Test Install TST"
{
    Subtype = Install;

    trigger OnInstallAppPerCompany()
    begin
        SetupTestSuite();
    end;

    local procedure SetupTestSuite()
    var
        ALTestSuite: Record "AL Test Suite";
        TestSuiteMgt: Codeunit "Test Suite Mgt.";
        SuiteName: Code[10];
    begin
        SuiteName := 'DEFAULT';

        if ALTestSuite.Get(SuiteName) then
            exit;

        TestSuiteMgt.CreateTestSuite(SuiteName);
        ALTestSuite.Get(SuiteName);

        TestSuiteMgt.SelectTestMethodsByRange(ALTestSuite, '80000..89999');
    end;
}