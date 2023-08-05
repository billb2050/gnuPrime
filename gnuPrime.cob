       IDENTIFICATION DIVISION.
       PROGRAM-ID. Primes.
      * Program: Sieve of Eratosthenes
      *
      * On: 08/02/2023
      * Ported: Bill Blasingim
      *
      * A port of the COBOL program PRIMCOB01 by Peter M. Maurer with 
      * with changes by Juergen Winkelmann that is found on MVS 3.8j 
      * included in the TK4- package, to GnuCOBOL
      * 
      * PRIMCOB01 had a limit of 32767 primes. gnuCobol doesn't have
      * that limit however I've limited this port to 1,000,000 primes.
      *
       Environment Division.
       Input-Output Section.
       File-Control.
       Data Division.
       File Section.

       Working-Storage Section.
       77  ws-input   pic x(08) JUSTIFIED RIGHT.
       77  I PIC 9(8) COMP VALUE 1.
       77  J PIC 9(8) COMP.
       77  K PIC 9(8) COMP VALUE 1.
       77  N PIC 9(8) COMP value 0.
       77  N-2 PIC 9(8) COMP.
       77  SQRTN PIC 9(8) COMP.
       77  PRODUCT PIC 9(8) COMP.
       01  BLANK-LINE PIC X(160).
       01  OUT-INTEGER.
        02 SHOWIT PIC Z(8) OCCURS 20.
       01  OUT REDEFINES OUT-INTEGER.
        02 OUT-LINE PIC X(160).
       01  PRIME-FLAGS.
         02 ISPRIME PIC 9 OCCURS 1000000.
       01  OutRec.
         05 out-data          PIC X(120).

       PROCEDURE DIVISION.

       MAIN-PART.
       Ask.
           DISPLAY "How many primes? " WITH NO ADVANCING.
           Accept ws-input from console.
           INSPECT WS-INPUT   
             REPLACING ALL SPACES BY ZEROS.
           if ws-input not NUMERIC THEN
             GO TO Ask.    
           Move ws-input to N.
           IF N>1000000 THEN
              DISPLAY "No greater than 1,000,000 please"
              GO TO ASK.
           SUBTRACT 2 FROM N GIVING N-2.

           PERFORM NEXT-SQUARE UNTIL SQRTN GREATER N.
           MOVE I TO SQRTN.

           MOVE 3 TO I.
           PERFORM INIT-1 UNTIL I GREATER N.

           MOVE 3 TO I.
           PERFORM CHECK-NUMBER UNTIL I GREATER SQRTN OR EQUAL SQRTN.

           MOVE 3 TO I.
           MOVE 2 TO J.
           MOVE J TO SHOWIT (K).
           PERFORM PRINT UNTIL I GREATER N.

           MOVE K TO SHOWIT (1).
           MOVE N TO SHOWIT (2).
           DISPLAY ' '.
           DISPLAY SHOWIT (1), ' primes up to ', SHOWIT (2), ' found.'.
           STOP RUN.

       INIT-1.
           MOVE 1 TO ISPRIME (I).
           ADD 2 TO I.

       CHECK-NUMBER.
           PERFORM ADVANCE UNTIL I GREATER THAN SQRTN OR EQUAL TO SQRT
      -      N OR ISPRIME (I) EQUAL TO 1.
           IF ISPRIME (I) EQUAL TO 1
              ADD I I GIVING J
           MULTIPLY I BY I GIVING PRODUCT
           PERFORM CROSS-OUT UNTIL PRODUCT GREATER THAN N.
           ADD 2 TO I.

       ADVANCE.
           ADD 2 TO I.


       CROSS-OUT.
           MOVE 0 TO ISPRIME (PRODUCT).
           ADD J TO PRODUCT.

       NEXT-SQUARE.
           ADD 1 TO I.
           MULTIPLY I BY I GIVING SQRTN.

       PRINT.
           IF ISPRIME (I) EQUAL TO 1
              MOVE I TO SHOWIT (J)
              ADD 1 TO K
              ADD 1 TO J
              IF J GREATER 20
                 DISPLAY OUT-LINE
                 MOVE BLANK-LINE TO OUT-LINE
                 MOVE 1 TO J.
           IF I GREATER N-2 AND J NOT EQUAL 1 DISPLAY OUT-LINE.
           ADD 2 TO I.
