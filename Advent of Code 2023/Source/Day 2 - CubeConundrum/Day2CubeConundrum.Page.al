page 50101 "Day 2: Cube Conundrum AVDV"
{
    ApplicationArea = All;
    Caption = 'Day 2: Cube Conundrum';
    PageType = Card;
    UsageCategory = Tasks;

    layout
    {
        area(Content)
        {
            group(BagContent)
            {
                Caption = 'Bag Content';
                field(QuantityRedCubes; QtyRedCubes)
                {
                    Caption = 'Red Cubes';
                }
                field(QuantityGreenCubes; QtyGreenCubes)
                {
                    Caption = 'Green Cubes';
                }
                field(QuantityBlueCubes; QtyBlueCubes)
                {
                    Caption = 'Blue Cubes';
                }
            }
            group(PuzzleInput)
            {
                Caption = 'Puzzle input';
                field(Input; InputText)
                {
                    Caption = 'Input';
                    MultiLine = true;
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
                field(PowerFld; PowerInt)
                {
                    Caption = 'Power';
                    Editable = false;
                }

            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(Calculate)
            {
                Caption = 'Calculate';
                Image = Calculate;

                trigger OnAction()
                var
                    CubeGameResultMeth: Codeunit "Cube Game Meth AVDV";
                begin
                    CubeGameResultMeth.SetInitialBagContent(Enum::"Color AVDV"::Red, QtyRedCubes);
                    CubeGameResultMeth.SetInitialBagContent(Enum::"Color AVDV"::Green, QtyGreenCubes);
                    CubeGameResultMeth.SetInitialBagContent(Enum::"Color AVDV"::Blue, QtyBlueCubes);
                    CubeGameResultMeth.Calculate(InputText, ResultInt, PowerInt);
                end;
            }
        }
        area(Promoted)
        {
            actionref(Calculate_Promoted; Calculate) { }
        }
    }

    var
        InputText: Text;
        ResultInt, PowerInt : Integer;
        QtyRedCubes, QtyGreenCubes, QtyBlueCubes : Integer;


    trigger OnOpenPage()
    begin
        QtyRedCubes := 12;
        QtyGreenCubes := 13;
        QtyBlueCubes := 14;
    end;
}