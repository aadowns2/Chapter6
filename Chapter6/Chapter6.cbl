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
                       file status is WS-File-Status
                       organization is line sequential.
                       
                   Select PurchasesReportFile
                       assign to PurchasesReport
                       file status is WS-File-Status
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
               01  Report-Record.
                   05  Print-Buffer                        PIC X(250).
                   
           Working-Storage Section.
           COPY WS_Date.cpy REPLACING LEADING ==Prefix== BY ==WS==.
           01  WS-File-Status                              PIC 9(2).
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
               05  Page_Counter                            PIC Z(2)    value zero.
           
           Local-Storage Section.
           
           Linkage Section.
           
           Report Section.
           
       Procedure Division.
           MOVE FUNCTION CURRENT-DATE TO WS_Current_Date_Data
           MOVE WS_Current_Month to Report_Month
           MOVE WS_Current_Day TO Report_Day
           MOVE WS_Current_Year TO Report_Year
           

           INVOKE TYPE Debug::WriteLine(Report_Header).
           
      *    Stop "Press <CR> to End Program"
           Stop Run.
           
       End Program.