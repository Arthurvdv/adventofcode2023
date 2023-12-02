page 50100 "Day 1: Trebuchet?! AVDV"
{
    ApplicationArea = All;
    Caption = 'Day 1: Trebuchet?!';
    PageType = Card;
    UsageCategory = Tasks;

    layout
    {
        area(Content)
        {
            group(PuzzleInput)
            {
                Caption = 'Puzzle input';
                field(Input; InputText)
                {
                    Caption = 'Input';
                    MultiLine = true;

                    trigger OnValidate()
                    var
                        CallibrationMeth: Codeunit "Callibration Meth AVDV";
                    begin
                        ResultInt := CallibrationMeth.Calculate(InputText);
                    end;
                }
            }
            group(Result)
            {
                Caption = 'Result';
                field(ResultFld; ResultInt)
                {
                    Caption = 'Result';
                    Editable = false;
                }
            }
        }
    }

    var
        InputText: Text;
        ResultInt: Integer;
}