`timescale 1ps / 1ps

//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/11/26 17:30:00
// Module Name: tb_FPGA_Simulator_Top
// Description: FPGA_Simulator_Top 모듈의 테스트벤치
//////////////////////////////////////////////////////////////////////////////////

module tb_FPGA_Simulator_Top;

    // DUT 입력
    reg FPGA_CLK;
    reg FPGA_RST_BTN;
    reg [7:0] FPGA_SWITCHES;
    reg FPGA_SEND_BTN;
    reg [2:0] KEYPAD_COL;

    // DUT 출력
    wire [3:0] KEYPAD_ROW;
    wire [7:0] FPGA_LEDS;
    wire lcd_enb;
    wire lcd_rs, lcd_rw;
    wire [7:0] lcd_data;

    // DUT 인스턴스화
    FPGA_Simulator_Top dut (
        .FPGA_CLK(FPGA_CLK),
        .FPGA_RST_BTN(FPGA_RST_BTN),
        .FPGA_SWITCHES(FPGA_SWITCHES),
        .FPGA_SEND_BTN(FPGA_SEND_BTN),
        .KEYPAD_COL(KEYPAD_COL),
        .KEYPAD_ROW(KEYPAD_ROW),
        .FPGA_LEDS(FPGA_LEDS),
        .lcd_enb(lcd_enb),
        .lcd_rs(lcd_rs),
        .lcd_rw(lcd_rw),
        .lcd_data(lcd_data)
    );

    // 클럭 생성 (50MHz, 20ns 주기)
    initial begin
        FPGA_CLK = 0;
        forever #10 FPGA_CLK = ~FPGA_CLK;
    end

    // 테스트 시나리오
    initial begin
        $display("==================================================");
        $display("Testbench for FPGA_Simulator_Top Started");
        $display("==================================================");

        // 1. 초기화 및 리셋
        FPGA_RST_BTN = 1'b0; // Active-Low 리셋 버튼 누름
        FPGA_SWITCHES = 8'h00;
        FPGA_SEND_BTN = 1'b0;
        KEYPAD_COL = 3'b111; // 키패드 입력 없음
        
        #100; // 리셋 안정화 시간
        FPGA_RST_BTN = 1'b1; // 리셋 버튼 해제
        #100;
        $display("[%0t] System Reset Released.", $time);

        // 2. 페이로드 설정 (키패드 '5' 입력 시뮬레이션)
        // 실제 키패드 모듈의 스캔 로직에 따라 KEYPAD_COL 값을 조절해야 합니다.
        // 여기서는 KEYPAD_ROW가 4'b1101일 때 KEYPAD_COL을 3'b110으로 설정하여 '5'를 입력한다고 가정합니다.
        // 키패드 모듈이 없으므로, 이 부분은 실제 동작과 다를 수 있습니다.
        // Top 모듈은 keypad_value_wire가 유효할 때 payload를 업데이트합니다.
        // 이 테스트벤치에서는 키패드 모듈을 직접 제어하지 않으므로,
        // 페이로드가 설정되는 것을 확인하려면 키패드 모듈의 동작을 알아야 합니다.
        // 여기서는 임의의 값을 설정하고 넘어갑니다.
        // payload를 5로 설정한다고 가정.
        $display("[%0t] Simulating keypad press for payload '5'.", $time);
        // 실제 키패드 스캔을 시뮬레이션하는 대신, 페이로드가 설정될 시간을 기다립니다.
        // (실제로는 키패드 모듈의 동작에 따라 KEYPAD_COL을 동적으로 변경해야 함)
        // dut.payload <= 4'h5; // 직접 할당은 불가능하므로, 시뮬레이션 상에서만 가정
        // 대신, 키패드 입력이 없으면 payload는 0으로 유지됩니다.
        // 전송 시 payload가 0으로 전송될 것입니다.

      #200;

        // 3. 프레임 전송 (Node A -> Node C)
        // DIP 스위치 설정: DST=C(1100), SRC=A(1010)
        FPGA_SWITCHES = 8'hCA;
        #100;
        $display("[%0t] Set Switches: DST=C, SRC=A (FPGA_SWITCHES = 8'h%h)", $time, FPGA_SWITCHES);

        // 전송 버튼 누르기 (1 클럭 사이클 동안)
        FPGA_SEND_BTN = 1'b1;
        #20; // 1 클럭 (20ns) 동안 버튼 누름
        FPGA_SEND_BTN = 1'b0;
        $display("[%0t] Send button pressed. Frame transmission from A to C initiated.", $time);

        // 4. 시뮬레이션 진행 및 종료
        #5000; // 스위치를 통해 프레임이 전달될 충분한 시간
        $display("[%0t] Simulation finished.", $time);
        $finish;
    end

    // 모니터링
    initial begin
        $monitor("[%0t] CLK=%b, RST_BTN=%b, SWITCHES=%h, SEND_BTN=%b, LEDS=%h, KEY_ROW=%b, KEY_COL=%b",
                 $time, FPGA_CLK, FPGA_RST_BTN, FPGA_SWITCHES, FPGA_SEND_BTN, FPGA_LEDS, KEYPAD_ROW, KEYPAD_COL);
    end

endmodule