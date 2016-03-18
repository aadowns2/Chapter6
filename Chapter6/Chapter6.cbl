       Identification Division.
           Program-ID. Chapter6.
               Author. Anthony Downs.
               Installation.
               Date-Written. 03/17/16
               Date-Compiled.
               Security.
               
       Environment Division.
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
                   05  Print_Buffer                        PIC X(150).
                   
           Working-Storage Section.
           COPY WS_Date REPLACING LEADING ==Prefix== BY ==WS==.
           COPY ReportHeaders.
           COPY DetailLine.
           
           01  Status-Indicators.
               05  File-Status                             PIC 9(2).
           01  Switches                                    PIC X(1).
               88  No-More-Records                                     value 'N'.
           01  Misc_Variables.
               05  Page_Count                              PIC 9(2).
               
       Procedure Division.
           
           Initialization.
               OPEN INPUT PurchasesFile
                   PERFORM 600-Validation
               OPEN OUTPUT PurchasesReportFile
                   PERFORM 600-Validation
               
               PERFORM 100-Print_Header
               PERFORM 200-Read-Records until No-More-Records
               PERFORM 500-Close-Module
               STOP "Press <CR> to continue"
               STOP RUN.
           
           100-Print_Header.
               COMPUTE Report_Page_Count = Page_Count + 1
               PERFORM 300-Date-Format
               WRITE Purchase-Report-Record FROM Report_Header AFTER ADVANCING 1 LINES.
               WRITE Purchase-Report-Record FROM Report_Header_2 after ADVANCING 2 LINES.
           
           200-Read-Records.
               READ PurchasesFile
                   AT END SET No-More-Records TO TRUE
                       NOT at END
                          PERFORM 400-Print-Records.
                          
           300-Date-Format.
               MOVE FUNCTION CURRENT-DATE TO WS_Current_Date_Data
               MOVE WS_Current_Month to Report_Month
               MOVE WS_Current_Day TO Report_Day
               MOVE WS_Current_Year TO Report_Year.
           
           400-Print-Records.
               MOVE Purchase_Month TO D_Purchase_Month.
               MOVE Purchase_Day to D_Purchase_Day.
               MOVE Purchase_Year TO D_Purchase_Year.
               MOVE Customer-Number TO D_Customer_Number.
               MOVE Customer-Name TO D_Customer_Name.
               MOVE Amount-of-Purchase TO D_Amount_of_Purchase.
               WRITE Purchase-Report-Record FROM Detail_Line AFTER ADVANCING 1 LINE.
               ADD 1 TO Page_Count.
           
           500-Close-Module.
               CLOSE PurchasesFile
               CLOSE PurchasesReportFile.
               
           600-Validation.
               EVALUATE File-Status
                   WHEN NOT EQUAL TO 00
                       INVOKE TYPE Debug::WriteLine("File Not Found")
                       STOP RUN
               END-EVALUATE.
       End Program Chapter6.