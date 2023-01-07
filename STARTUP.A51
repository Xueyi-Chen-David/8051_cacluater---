		CSEG AT 0x0000	
			
START:	MOV DPTR,#TABLE
		MOV P1,#0x1 ; which led will be light
		MOV A, #0x4 ; select number 
		MOVC A,@A+DPTR
		
L2:		MOV P2,A
		AJMP L2
		
TABLE:  DB 3fh ;0
	    DB 06h ;1
	    DB 5bh ;2
	    DB 4fh ;3
	    DB 66h ;4
	    DB 6dh ;5
        DB 7dh ;6
  	    DB 07h ;7
		DB 7fh ;8
		DB 6fh ;9
		END		
