permissionset 50100 "Default AVDV"
{
    Access = Internal;
    Assignable = true;
    Caption = 'Defaults', Locked = true;
    Permissions =
        codeunit "Callibration Meth AVDV" = X,
        codeunit "Number Search First AVDV" = X,
        codeunit "Number Search Helper AVDV" = X,
        codeunit "Number Search Last AVDV" = X,
            page "Day 1: Trebuchet?! AVDV" = X;
}