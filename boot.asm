; Copyright (C) 2024  Adam Perkowski

call cls

[org 0x7c00]
mov ah, 0x0e
mov bx, text
call printString

text:
  db 13, 10, "HighlightOS", 13, 10, 10, " Copyright (C) 2024", 13, 10, " Adam Perkowski", 0

mov al, 0
call nl

shell:
  ;  > success  ! error  ? warning

  mov al, '>'
  call nl

  input:
    mov ah, 0
    int 0x16

    cmp al, 0x0D
    jne ps
  
  jmp shell


jmp $


cls:
  pusha
  mov ah, 0x00
  mov al, 0x03
  int 0x10
  popa
  ret

printString:
  pusha
  mov al, [bx]
  cmp al, 0
  je end
  int 0x10
  inc bx
  jmp printString
  popa
  ret
end:
  inc al
  popa
  ret

nl:
  mov ah, 0x0e
  int 0x10

  mov ah, 0x0e
  mov al, 10
  int 0x10
  mov ah, 0x0e
  mov al, 13
  int 0x10
  mov ah, 0x0e
  mov al, 10
  int 0x10
  mov ah, 0x0e
  mov al, 13
  int 0x10
  mov ah, 0x0e
  mov al, '<'
  int 0x10

  ret

ps:
    mov ah, 0x0e
    int 0x10
    jmp input
    ret

times 510-($-$$) db 0
dw 0xaa55
