## ===============================
## EGO-XZ7 乒乓遊戲 XDC 約束檔
## FPGA: XC7Z020-CLG484
## ===============================

## -------- Clock (100MHz from PL) --------
set_property PACKAGE_PIN Y9 [get_ports clk]
set_property IOSTANDARD LVCMOS33 [get_ports clk]
create_clock -period 10.000 -name clk -waveform {0 5} [get_ports clk]

## -------- Reset (低有效, S2鍵) --------
set_property PACKAGE_PIN F22 [get_ports rst]
set_property IOSTANDARD LVCMOS33 [get_ports rst]

## -------- Player Buttons --------
# 左玩家 (BTNL)
set_property PACKAGE_PIN R16 [get_ports p1]
set_property IOSTANDARD LVCMOS33 [get_ports p1]

# 右玩家 (BTNR)
set_property PACKAGE_PIN T18 [get_ports p2]
set_property IOSTANDARD LVCMOS33 [get_ports p2]

## -------- LEDs (8顆) --------
set_property PACKAGE_PIN T22 [get_ports {leds[7]}]
set_property PACKAGE_PIN T21 [get_ports {leds[6]}]
set_property PACKAGE_PIN U22 [get_ports {leds[5]}]
set_property PACKAGE_PIN U21 [get_ports {leds[4]}]
set_property PACKAGE_PIN V22 [get_ports {leds[3]}]
set_property PACKAGE_PIN W22 [get_ports {leds[2]}]
set_property PACKAGE_PIN U19 [get_ports {leds[1]}]
set_property PACKAGE_PIN U14 [get_ports {leds[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {leds[*]}]
set_property DRIVE 8 [get_ports {leds[*]}]
set_property SLEW SLOW [get_ports {leds[*]}]

## -------- VGA 訊號輸出 (使用 PMOD JE, Bank 35, 3.3V) --------
## R[2:0]
set_property PACKAGE_PIN U4 [get_ports {vga_r[2]}]
set_property PACKAGE_PIN T6 [get_ports {vga_r[1]}]
set_property PACKAGE_PIN R6 [get_ports {vga_r[0]}]

## G[2:0]
set_property PACKAGE_PIN AB1 [get_ports {vga_g[2]}]
set_property PACKAGE_PIN AB2 [get_ports {vga_g[1]}]
set_property PACKAGE_PIN AA7 [get_ports {vga_g[0]}]

## B[2:0]
set_property PACKAGE_PIN T4 [get_ports {vga_b[2]}]
set_property PACKAGE_PIN AB7 [get_ports {vga_b[1]}]
set_property PACKAGE_PIN AB4 [get_ports {vga_b[0]}]

## 同步訊號
set_property PACKAGE_PIN V4 [get_ports vga_hs]
set_property PACKAGE_PIN U6 [get_ports vga_vs]

## -------- I/O 標準設定 --------
set_property IOSTANDARD LVCMOS33 [get_ports {vga_r[*]}]
set_property IOSTANDARD LVCMOS33 [get_ports {vga_g[*]}]
set_property IOSTANDARD LVCMOS33 [get_ports {vga_b[*]}]
set_property IOSTANDARD LVCMOS33 [get_ports vga_hs]
set_property IOSTANDARD LVCMOS33 [get_ports vga_vs]