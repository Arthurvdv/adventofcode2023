permissionset 50100 "Default AVDV"
{
    Access = Internal;
    Assignable = true;
    Caption = 'Defaults', Locked = true;
    Permissions = codeunit "Callibration Meth AVDV" = X,
        codeunit "Number Search First AVDV" = X,
        codeunit "Number Search Helper AVDV" = X,
        codeunit "Number Search Last AVDV" = X,
        page "Day 1: Trebuchet?! AVDV" = X,
        tabledata "Cube Game AVDV" = RIMD,
        tabledata "Cube Game Configuration AVDV" = RIMD,
        table "Cube Game AVDV" = X,
        table "Cube Game Configuration AVDV" = X,
        codeunit "Cube Game Meth AVDV" = X,
        codeunit "Type Helper AVDV" = X,
        page "Day 2: Cube Conundrum AVDV" = X;
}