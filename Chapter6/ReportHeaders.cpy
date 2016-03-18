      * ReportHeaders
       01  Report_Header.
           05                                          PIC X(10)   value spaces.
           05                                          PIC X(18)   value 'Purchase Report'.
           05  Report_Date.
               10  Report_Month                        PIC 9(2).
               10                                      PIC X(1)    value '/'.
               10  Report_Day                          PIC 9(2).
               10                                      PIC X(1)    value '/'.
               10  Report_Year                         PIC 9(4).
           05                                          PIC X(30)   value spaces.
           05                                          PIC X(6)    value 'Page'.
           05  Report_Page_Count                       PIC 9(2)    value zero.
       01  Report_Header_2.
           05                                          PIC X(13)   value 'Customer No'.
           05                                          PIC X(25)   value 'Customer Name'.
           05                                          PIC X(22)   value 'Amount of Purchase'.
           05                                          PIC X(16)   value 'Date of Purchase'.