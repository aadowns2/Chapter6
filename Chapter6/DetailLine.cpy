      * DetailLine
       01  Detail_Line.
           05  D_Customer_Number                       PIC X(13).
           05  D_Customer_Name                         PIC X(25).
           05  D_Amount_of_Purchase                    PIC $Z,Z(3).9(2).
           05                                          PIC X(13)    value spaces.
           05  D_Purchase_Date.
               10  D_Purchase_Month                    PIC 9(2).
               10                                      PIC X(1)    value '/'.
               10  D_Purchase_Day                      PIC 9(2).
               10                                      PIC X(1)    value '/'.
               10  D_Purchase_Year                     PIC 9(4).
