/* kernel.c */
/* النواة الأساسية */

void kmain(void) {
    const char *msg = "Welcome to MyOS!\n";
    char *video = (char*)0xb8000;   /* عنوان ذاكرة الشاشة */
    int i = 0;

    while (msg[i]) {
        video[i * 2] = msg[i];      /* الحرف */
        video[i * 2 + 1] = 0x07;    /* لون النص (رمادي على أسود) */
        i++;
    }

    while (1) {
        /* حلقة لا نهائية حتى لا ينتهي البرنامج */
    }
}
