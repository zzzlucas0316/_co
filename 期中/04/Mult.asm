// 計算 RAM[0] * RAM[1] 並將結果儲存於 RAM[2]
// 假設 R0 >= 0, R1 >= 0，且 R0*R1 < 32768

    @R2
    M=0         // R2 = 0 (先清空結果暫存器)

(LOOP)
    @R1
    D=M         // D = R1
    @END
    D;JLE       // 如果 R1 <= 0，跳轉到 END (結束計算)

    @R0
    D=M         // D = R0
    @R2
    M=D+M       // R2 = R2 + R0

    @R1
    M=M-1       // R1 = R1 - 1 (次數減一)

    @LOOP
    0;JMP       // 無條件跳轉回 LOOP

(END)
    @END
    0;JMP       // 無限循環程式結束
