		CSEG AT 0x0000	
	
BEGIN:	
		MOV A, #0 ;row
		MOV R3, #0 ; i
		MOV R2, #0
		
SCAN:	
		MOV DPTR, #ScanCode
		MOV A, R3
		MOVC A, @A+DPTR
		MOV P0, A
		MOV A,P0 ;when press A has a different resalt
		ANL A,#0xf0
		
		CJNE A, #0xe0, T
		MOV R0, #0
		SJMP COUNT
		
T:      CJNE A, #0xd0, T2
		MOV R0, #1
		SJMP COUNT
		
T2:     CJNE A, #0xb0, T3
		MOV R0, #2
		SJMP COUNT
		
T3:     CJNE A, #0x70, Default
		MOV R0, #3
		SJMP COUNT


COUNT:		
		MOV A, R0 ; put key=1,2,3,4 to A
		RL A      ; key*2
		RL A      ; key*4
		ADD A, R3 ; key*4 + i ;A can select which number 
		;MOV R2, A ; R2 = A	
		ACALL ShowNum
		
Default: 
		INC R3
		CJNE R3,#4,SCAN
		SJMP BEGIN
		

/**************************************/

ShowNum:
        MOV DPTR,#TABLE
		MOV P1,#0 ; which led will be light
		;MOV A, R2 ; select number 
		MOVC A,@A+DPTR
		
L0:		
		MOV P2,A
		ACALL DELAY
		RET
		
DELAY:
		MOV R5, #2
		D2:
		MOV R6, #2
		D1:
		MOV R4, #2
		DJNZ R4, $
		DJNZ R6, D1
		DJNZ R5, D2
		RET
		
TABLE:  
		DB 3fh ;0
	    DB 06h ;1
	    DB 5bh ;2
	    DB 4fh ;3
	    DB 66h ;4
	    DB 6dh ;5
        DB 7dh ;6
  	    DB 07h ;7
		DB 7fh ;8
		DB 6fh ;9
			
ScanCode:
		DB 11111110B ;0xfe
		DB 11111101B ;0xfd
		DB 11111011B ;0xfb
		DB 11110111B ;0xf7
		END		
			
