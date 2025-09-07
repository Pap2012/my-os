; bootloader.asm
; Bootloader بسيط يحمل النواة من القطاع التالي

BITS 16                ; المعالج يبدأ في real mode
org 0x7c00             ; مكان تحميل البوتلودر في الذاكرة

start:
    mov si, welcomeMsg ; اطبع رسالة ترحيب
    call print_string

    ; تحميل القطاع الثاني (النواة) إلى الذاكرة 0x1000
    mov ah, 0x02       ; وظيفة BIOS: قراءة قطاع
    mov al, 1          ; عدد القطاعات
    mov ch, 0          ; رقم المسار (cylinder)
    mov cl, 2          ; القطاع رقم 2 (القطاع الأول فيه البوتلودر)
    mov dh, 0          ; رأس القرص (head)
    mov dl, 0x80       ; أول قرص صلب
    mov bx, 0x1000     ; مكان التحميل في الذاكرة
    int 0x13           ; نداء BIOS

    jmp 0x0000:0x1000  ; اذهب لتشغيل الكود الموجود في 0x1000 (النواة)

print_string:
    mov ah, 0x0E       ; وظيفة طباعة حرف
.print_char:
    lodsb              ; جلب الحرف التالي في SI
    or al, al
    jz .done
    int 0x10           ; طباعة الحرف
    jmp .print_char
.done:
    ret

welcomeMsg db "Booting MyOS...", 0

times 510-($-$$) db 0 ; املأ حتى 510 بايت
dw 0xAA55             ; توقيع البوتلودر
