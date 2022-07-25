PORTB = $6000
PORTA = $6001
DDRB = $6002
DDRA = $6003

E = %10000000
RW = %01000000
RS = %00100000

	.org $8000 

reset:
	lda #%11111111 ; Set all pins on port B to output
	sta DDRB

	lda #%11100000
	sta DDRA
	lda #%00111000 ; set 8 bit mode to 2 line displace 5*8 font
	sta PORTB
	lda #0	; Clear RS/RW/E bits
	sta PORTA
	lda #E	; send enable bit to actually send instruiction :)))
	sta PORTA
	lda #0 ; clear RS/RW/E bits
	sta PORTA

	lda #%00001110 ; display on, cursor off, link off
	sta PORTB
	lda #0	; Clear RS/RW/E bits
	sta PORTA
	lda #E	; send enable bit to actually send instruiction :)))
	sta PORTA
	lda #0 ; clear RS/RW/E bits
	sta PORTA

	lda #%00000110 ; increment and shift cursor; dont shift display
	sta PORTB
	lda #0	; Clear RS/RW/E bits
	sta PORTA
	lda #E	; send enable bit to actually send instruiction :)))
	sta PORTA
	lda #0 ; clear RS/RW/E bits
	sta PORTA

	lda #"H"
	sta PORTB
	lda #RS	; set register select
	sta PORTA
	lda #(RS | E)	; register and enable bit set
	sta PORTA
	lda #RS ; clear enable bit
	sta PORTA

loop:
	jmp loop
	
	.org $fffc
	.word reset
	.word $0000

	
