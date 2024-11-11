; Program written to Programmable Memory to output "Hello, World!"
DDRA = $6003
DDRB = $6002
OUTA = $6001
OUTB = $6000

E = %10000000
RW = %01000000
RS = %00100000

    .org $8000

reset:
    ldx #$ff
    txs ; Sets the stack pointer to the bottom of the stack

    lda #$ff
    sta DDRB ; Initialize all pins on PORT B to output
    lda #$E0
    sta DDRA ; Initialize PA5-PA7 on PORT A to output

    lda #%00111000 ; 8-bit mode, 2-line display, 5x8 font
    jsr lcd_enable
    lda #%00001110 ; Display on, cursor on, blink off
    jsr lcd_enable
    lda #%00000110 ; Increments PC after receiving character
    jsr lcd_enable
    lda #%00000001 ; Clear Display of LCD
    jsr lcd_enable

    lda #"H"
    jsr print_character
    lda #"e"
    jsr print_character
    lda #"l"
    jsr print_character
    lda #"l"
    jsr print_character
    lda #"o"
    jsr print_character
    lda #","
    jsr print_character
    lda #" "
    jsr print_character
    lda #"w"
    jsr print_character
    lda #"o"
    jsr print_character
    lda #"r"
    jsr print_character
    lda #"l"
    jsr print_character
    lda #"d"
    jsr print_character
    lda #"!"
    jsr print_character

loop:
    jmp loop

lcd_enable: ; Activating then deactivating chip enable
    sta OUTB
    lda #0
    sta OUTA
    lda #E
    sta OUTA
    lda #0
    sta OUTA
    rts

print_character: ; Prints character on display
    sta OUTB
    lda #RS
    sta OUTA
    lda #(RS | E)
    sta OUTA
    lda #RS
    sta OUTA
    rts

    .org $fffc
    .word reset
    .word $0000