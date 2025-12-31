// 監控鍵盤輸入。
// 當按鍵時，將螢幕塗黑（填入 -1）；當沒有按鍵時，將螢幕清除（填入 0）。

(MAINLOOP)
    @SCREEN
    D=A
    @addr
    M=D         // addr = 16384 (SCREEN 記憶體起始位置)

(KBDCHECK)
    @KBD
    D=M         // 讀取鍵盤暫存器的值
    @BLACK
    D;JGT       // 如果 D > 0 (有按鍵)，跳轉到 BLACK
    @WHITE
    0;JMP       // 否則跳轉到 WHITE

(BLACK)
    @val
    M=-1        // val = -1 (二進制 1111111111111111，全黑)
    @DRAWLOOP
    0;JMP

(WHITE)
    @val
    M=0         // val = 0 (全白)
    @DRAWLOOP
    0;JMP

(DRAWLOOP)
    @val
    D=M         // 取得要畫的顏色
    @addr
    A=M
    M=D         // 在當前記憶體位址畫色

    @addr
    M=M+1       // 移動到下一個像素組
    D=M

    @24576      // 鍵盤暫存器的位址（螢幕記憶體的結束邊界）
    D=D-A
    @DRAWLOOP
    D;JLT       // 如果尚未畫到最後一格 (addr < 24576)，繼續畫

    @MAINLOOP
    0;JMP       // 畫完一遍後，重新檢查鍵盤狀態
