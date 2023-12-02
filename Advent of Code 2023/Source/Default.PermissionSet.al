permissionset 50100 "Default AVDV"
{
    Access = Internal;
    Assignable = true;
    Caption = 'Defaults', Locked = true;

    Permissions =
         codeunit "Callibration Meth AVDV" = X,
         page "Day 1: Trebuchet?! AVDV" = X;
}