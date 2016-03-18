       Identification Division.
           Program-ID. Chapter6.
               Author. Anthony Downs.
               Installation.
               Date-Written. 03/17/16
               Date-Compiled.
               Security.
               
       Environment Division.
           Configuration Section.
               Special-Names.
               
           Input-Output Section.
               File-Control.
                   Select PurchasesFile
                       assign to PurchasesData
                       file status is File-Status
                       organization is line sequential.
                       
                   Select PurchasesReportFile
                       assign to PurchasesReport
                       file status is File-Status
                       organization is line sequential.
               
               I-O-Control.
               
       Data Division.
           File Section.
           FD  PurchasesFile.
               01  Purchases-Record.
                   05  Customer-Number                     PIC X(5).
                   05  Customer-Name                       PIC X(20).
                   05  Amount-of-Purchase                  PIC 9(5)V99.
                   05  Purchase-Date.
                       10  Purchase_Month                  PIC 9(2).
                       10  Purchase_Day                    PIC 9(2).
                       10  Purchase_Year                   PIC 9(4).
                   
           FD  PurchasesReportFile.
               01  Purchase-Report-Record.
                   05  Print-Buffer                        PIC X(250).
                   
           Working-Storage Section.
           COPY WS_Date.cpy REPLACING LEADING ==Prefix== BY ==WS==.
           
           01  Status-Indicators.
               05  File-Status                             PIC 9(2).
           01  Switches                                    PIC X(1).
               88  No-More-Records                                     value 'N'.
           01  Misc_Variables.
               05  Page_Count                              PIC 9(2).
           01  Report_Header.
               05                                          PIC X(40)   value spaces.
               05                                          PIC X(18)   value 'Purchase Report'.
               05  Report_Date.
                   10  Report_Month                        PIC 9(2).
                   10                                      PIC X(1)    value '/'.
                   10  Report_Day                          PIC 9(2).
                   10                                      PIC X(1)    value '/'.
                   10  Report_Year                         PIC 9(4).
               05                                          PIC X(2)    value spaces.
               05                                          PIC X(6)    value 'Page'.
               05  Report_Page_Count                       PIC Z(2)    value zero.
           
           Local-Storage Section.
           
           Linkage Section.
           
           Report Section.
           
       Procedure Division.
           
           100-Initialization.
               OPEN INPUT PurchasesFile
                   PERFORM 600-Validation
               OPEN OUTPUT PurchasesReportFile
                   PERFORM 600-Validation
               
               PERFORM 900-Date-Format.
               WRITE Purchase-Report-Record FROM Report_Header
               PERFORM 200-Read-Records until No-More-Records
               PERFORM 500-Close-Module
               STOP "Press <CR> to continue"
               STOP RUN.
           
           200-Read-Records.
           
               READ PurchasesFile
                   AT END SET No-More-Records TO TRUE
                       NOT at END
                           PERFORM 400-Print-Records.
           
           300-Calculations.
           
           400-Print-Records.
               ADD 1 TO Page_Count
               WRITE Purchase-Report-Record FROM Purchases-Record AFTER ADVANCING 1 LINE.
           
           500-Close-Module.
               CLOSE PurchasesFile, PurchasesReportFile.
               
           600-Validation.
               EVALUATE File-Status
                   WHEN NOT EQUAL TO 00
                       INVOKE TYPE Debug::WriteLine("File Not Found")
                       STOP RUN
               END-EVALUATE.
           
           900-Date-Format.
               MOVE FUNCTION CURRENT-DATE TO WS_Current_Date_Data
               MOVE WS_Current_Month to Report_Month
               MOVE WS_Current_Day TO Report_Day
               MOVE WS_Current_Year TO Report_Year
           
      *    Stop "Press <CR> to End Program"
       End Program.