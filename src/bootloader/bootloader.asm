;****************************************
; bootloader.asm
; A Simple Bootloader
;
; Based on "Operating Systems: From 0 to 1" book
;
;****************************************
org 0x7c00
bits 16
start: jmp boot

;; constant and variable definitions
msg db "Welcome to My Operating System!", 0ah, 0dh, 0h

boot:
	cli ; no interrupts
	cld ; all that we need to init
	hlt ; halt the system
	
	mov ax, 0x50

	;; set the buffer
	mov es, ax
	xor bx, bx

	mov al, 2 ; read 2 sector
	mov ch, 0 ; track 0
	mov cl, 2 ; sector to read (The second sector)
	mov dh, 0 ; head number
	mov dl, 0 ; drive number

	mov ah, 0x02 ; read the sectors from disck
	int 0x13 ; call BIOS routine
	jmp 0x50:0x0 ; jump and execute the sector!

	hlt ; halt the system

; We have to be 512 bytes. Clear the rest of the bytes with 0
times 510 - ($-$$) db 0
dw 0xAA55 ; Boot Signiture

