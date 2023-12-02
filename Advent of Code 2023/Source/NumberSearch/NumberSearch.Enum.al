enum 50100 "Number Search AVDV" implements "INumberSearch AVDV"
{
    value(0; First)
    {
        Caption = 'First';
        Implementation = "INumberSearch AVDV" = "Number Search First AVDV";
    }
    value(1; Last)
    {
        Caption = 'Last';
        Implementation = "INumberSearch AVDV" = "Number Search Last AVDV";
    }
}