		CSEG AT 0x0000	
	
BEGIN:	
		MOV DPTR, #ScanCode
		MOV A, #0
		
SCAN:	
		MOVC A, @A+DPTR
		MOV P0, A
		MOV A, P0 ;when press A has a different resalt
		ANL A,#0xf0
		
		CJNE A, #0xe0, T1
		MOV R0, #0
		SJMP CONT
		
T1:     CJNE A, #0xd0, T2
		MOV R0, #1
		SJMP CONT
		
T2:     CJNE A, #0xb0, T3
		MOV R0, #2
		SJMP CONT
		
T3:     CJNE A, #0x70, Default
		MOV R0, #3
		SJMP CONT

Default: R0, #-1

CONT:
		AJMP ShowNum
		
		INC A
		CJNE A,#4,SCAN
		AJMP BEGIN

/**************************************/

ShowNum:
		MOV DPTR,#0
        MOV DPTR,#TABLE
		MOV P1,#0 ; which led will be light
		MOV A, #4 ; select number 
		MOVC A,@A+DPTR
		
L0:		
		MOV P2,A
		AJMP L0
		
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
