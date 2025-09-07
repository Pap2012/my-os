/* kernel_entry.S */
/* هذا هو المدخل الأساسي للنواة */

.global _start
_start:
    cli                 /* تعطيل المقاطعات */
    mov $0x10, %ax      /* تحميل مقطع البيانات */
    mov %ax, %ds
    mov %ax, %es
    mov %ax, %fs
    mov %ax, %gs
    mov %ax, %ss
    mov $stack_top, %esp /* إعداد مؤشر المكدس */

    call kmain          /* استدعاء الدالة الرئيسية من kernel.c */

hang:
    hlt                 /* توقف المعالج */
    jmp hang

.section .bss
    .lcomm stack, 4096
    .equ stack_top, stack+4096
