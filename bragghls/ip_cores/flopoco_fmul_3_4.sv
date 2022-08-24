module dspblock_5x5_f300_uid9
  (input  clk,
   input  [4:0] x,
   input  [4:0] y,
   output [9:0] r);
  wire [9:0] mint;
  wire [9:0] m;
  wire [9:0] rtmp;
  wire [9:0] n158_o;
  wire [9:0] n159_o;
  wire [9:0] n160_o;
  assign r = rtmp;
  /* /home/mlevental/dev_projects/bragghls/scripts/flopoco_fmul_3_4.vhdl:34:13  */
  assign mint = n160_o; // (signal)
  /* /home/mlevental/dev_projects/bragghls/scripts/flopoco_fmul_3_4.vhdl:30:8  */
  assign m = mint; // (signal)
  /* /home/mlevental/dev_projects/bragghls/scripts/flopoco_fmul_3_4.vhdl:31:8  */
  assign rtmp = m; // (signal)
  /* /home/mlevental/dev_projects/bragghls/scripts/flopoco_fmul_3_4.vhdl:33:41  */
  assign n158_o = {5'b0, x};  //  uext
  /* /home/mlevental/dev_projects/bragghls/scripts/flopoco_fmul_3_4.vhdl:33:41  */
  assign n159_o = {5'b0, y};  //  uext
  /* /home/mlevental/dev_projects/bragghls/scripts/flopoco_fmul_3_4.vhdl:33:41  */
  assign n160_o = n158_o * n159_o; // umul
endmodule

module intadder_9_f300_uid13
  (input  clk,
   input  [8:0] x,
   input  [8:0] y,
   input  cin,
   output [8:0] r);
  wire cin_1;
  wire cin_1_d1;
  wire [9:0] x_1;
  wire [9:0] x_1_d1;
  wire [9:0] y_1;
  wire [9:0] y_1_d1;
  wire [9:0] s_1;
  wire [8:0] r_1;
  wire [9:0] n147_o;
  wire [9:0] n149_o;
  wire [9:0] n150_o;
  wire [9:0] n151_o;
  wire [9:0] n152_o;
  wire [8:0] n153_o;
  reg n154_q;
  reg [9:0] n155_q;
  reg [9:0] n156_q;
  assign r = r_1;
  /* /home/mlevental/dev_projects/bragghls/scripts/flopoco_fmul_3_4.vhdl:153:8  */
  assign cin_1 = cin; // (signal)
  /* /home/mlevental/dev_projects/bragghls/scripts/flopoco_fmul_3_4.vhdl:153:15  */
  assign cin_1_d1 = n154_q; // (signal)
  /* /home/mlevental/dev_projects/bragghls/scripts/flopoco_fmul_3_4.vhdl:154:8  */
  assign x_1 = n147_o; // (signal)
  /* /home/mlevental/dev_projects/bragghls/scripts/flopoco_fmul_3_4.vhdl:154:13  */
  assign x_1_d1 = n155_q; // (signal)
  /* /home/mlevental/dev_projects/bragghls/scripts/flopoco_fmul_3_4.vhdl:155:8  */
  assign y_1 = n149_o; // (signal)
  /* /home/mlevental/dev_projects/bragghls/scripts/flopoco_fmul_3_4.vhdl:155:13  */
  assign y_1_d1 = n156_q; // (signal)
  /* /home/mlevental/dev_projects/bragghls/scripts/flopoco_fmul_3_4.vhdl:156:8  */
  assign s_1 = n152_o; // (signal)
  /* /home/mlevental/dev_projects/bragghls/scripts/flopoco_fmul_3_4.vhdl:157:8  */
  assign r_1 = n153_o; // (signal)
  /* /home/mlevental/dev_projects/bragghls/scripts/flopoco_fmul_3_4.vhdl:168:15  */
  assign n147_o = {1'b0, x};
  /* /home/mlevental/dev_projects/bragghls/scripts/flopoco_fmul_3_4.vhdl:169:15  */
  assign n149_o = {1'b0, y};
  /* /home/mlevental/dev_projects/bragghls/scripts/flopoco_fmul_3_4.vhdl:170:18  */
  assign n150_o = x_1_d1 + y_1_d1;
  /* /home/mlevental/dev_projects/bragghls/scripts/flopoco_fmul_3_4.vhdl:170:27  */
  assign n151_o = {9'b0, cin_1_d1};  //  uext
  /* /home/mlevental/dev_projects/bragghls/scripts/flopoco_fmul_3_4.vhdl:170:27  */
  assign n152_o = n150_o + n151_o;
  /* /home/mlevental/dev_projects/bragghls/scripts/flopoco_fmul_3_4.vhdl:171:14  */
  assign n153_o = s_1[8:0];
  /* /home/mlevental/dev_projects/bragghls/scripts/flopoco_fmul_3_4.vhdl:161:10  */
  always @(posedge clk)
    n154_q <= cin_1;
  /* /home/mlevental/dev_projects/bragghls/scripts/flopoco_fmul_3_4.vhdl:161:10  */
  always @(posedge clk)
    n155_q <= x_1;
  /* /home/mlevental/dev_projects/bragghls/scripts/flopoco_fmul_3_4.vhdl:161:10  */
  always @(posedge clk)
    n156_q <= y_1;
endmodule

module intmultiplier_f300_uid5
  (input  clk,
   input  [4:0] x,
   input  [4:0] y,
   output [9:0] r);
  wire [4:0] tile_0_x;
  wire [4:0] tile_0_y;
  wire [9:0] tile_0_output;
  wire [9:0] tile_0_filtered_output;
  wire bh7_w0_0;
  wire bh7_w1_0;
  wire bh7_w2_0;
  wire bh7_w3_0;
  wire bh7_w4_0;
  wire bh7_w5_0;
  wire bh7_w6_0;
  wire bh7_w7_0;
  wire bh7_w8_0;
  wire bh7_w9_0;
  wire [9:0] tmp_bitheapresult_bh7_9;
  wire [9:0] bitheapresult_bh7;
  wire [9:0] tile_0_mult_n116;
  wire [9:0] tile_0_mult_r;
  wire n119_o;
  wire n120_o;
  wire n121_o;
  wire n122_o;
  wire n123_o;
  wire n124_o;
  wire n125_o;
  wire n126_o;
  wire n127_o;
  wire n128_o;
  wire [1:0] n129_o;
  wire [2:0] n130_o;
  wire [3:0] n131_o;
  wire [4:0] n132_o;
  wire [5:0] n133_o;
  wire [6:0] n134_o;
  wire [7:0] n135_o;
  wire [8:0] n136_o;
  wire [9:0] n137_o;
  assign r = bitheapresult_bh7;
  /* /home/mlevental/dev_projects/bragghls/scripts/flopoco_fmul_3_4.vhdl:76:8  */
  assign tile_0_x = x; // (signal)
  /* /home/mlevental/dev_projects/bragghls/scripts/flopoco_fmul_3_4.vhdl:77:8  */
  assign tile_0_y = y; // (signal)
  /* /home/mlevental/dev_projects/bragghls/scripts/flopoco_fmul_3_4.vhdl:103:52  */
  assign tile_0_output = tile_0_mult_n116; // (signal)
  /* /home/mlevental/dev_projects/bragghls/scripts/flopoco_fmul_3_4.vhdl:79:8  */
  assign tile_0_filtered_output = tile_0_output; // (signal)
  /* /home/mlevental/dev_projects/bragghls/scripts/flopoco_fmul_3_4.vhdl:80:8  */
  assign bh7_w0_0 = n119_o; // (signal)
  /* /home/mlevental/dev_projects/bragghls/scripts/flopoco_fmul_3_4.vhdl:81:8  */
  assign bh7_w1_0 = n120_o; // (signal)
  /* /home/mlevental/dev_projects/bragghls/scripts/flopoco_fmul_3_4.vhdl:82:8  */
  assign bh7_w2_0 = n121_o; // (signal)
  /* /home/mlevental/dev_projects/bragghls/scripts/flopoco_fmul_3_4.vhdl:83:8  */
  assign bh7_w3_0 = n122_o; // (signal)
  /* /home/mlevental/dev_projects/bragghls/scripts/flopoco_fmul_3_4.vhdl:84:8  */
  assign bh7_w4_0 = n123_o; // (signal)
  /* /home/mlevental/dev_projects/bragghls/scripts/flopoco_fmul_3_4.vhdl:85:8  */
  assign bh7_w5_0 = n124_o; // (signal)
  /* /home/mlevental/dev_projects/bragghls/scripts/flopoco_fmul_3_4.vhdl:86:8  */
  assign bh7_w6_0 = n125_o; // (signal)
  /* /home/mlevental/dev_projects/bragghls/scripts/flopoco_fmul_3_4.vhdl:87:8  */
  assign bh7_w7_0 = n126_o; // (signal)
  /* /home/mlevental/dev_projects/bragghls/scripts/flopoco_fmul_3_4.vhdl:88:8  */
  assign bh7_w8_0 = n127_o; // (signal)
  /* /home/mlevental/dev_projects/bragghls/scripts/flopoco_fmul_3_4.vhdl:89:8  */
  assign bh7_w9_0 = n128_o; // (signal)
  /* /home/mlevental/dev_projects/bragghls/scripts/flopoco_fmul_3_4.vhdl:90:8  */
  assign tmp_bitheapresult_bh7_9 = n137_o; // (signal)
  /* /home/mlevental/dev_projects/bragghls/scripts/flopoco_fmul_3_4.vhdl:120:26  */
  assign bitheapresult_bh7 = tmp_bitheapresult_bh7_9; // (signal)
  /* /home/mlevental/dev_projects/bragghls/scripts/flopoco_fmul_3_4.vhdl:101:23  */
  assign tile_0_mult_n116 = tile_0_mult_r; // (signal)
  /* /home/mlevental/dev_projects/bragghls/scripts/flopoco_fmul_3_4.vhdl:97:4  */
  dspblock_5x5_f300_uid9 tile_0_mult (
    .clk(clk),
    .x(tile_0_x),
    .y(tile_0_y),
    .r(tile_0_mult_r));
  /* /home/mlevental/dev_projects/bragghls/scripts/flopoco_fmul_3_4.vhdl:104:38  */
  assign n119_o = tile_0_filtered_output[0];
  /* /home/mlevental/dev_projects/bragghls/scripts/flopoco_fmul_3_4.vhdl:105:38  */
  assign n120_o = tile_0_filtered_output[1];
  /* /home/mlevental/dev_projects/bragghls/scripts/flopoco_fmul_3_4.vhdl:106:38  */
  assign n121_o = tile_0_filtered_output[2];
  /* /home/mlevental/dev_projects/bragghls/scripts/flopoco_fmul_3_4.vhdl:107:38  */
  assign n122_o = tile_0_filtered_output[3];
  /* /home/mlevental/dev_projects/bragghls/scripts/flopoco_fmul_3_4.vhdl:108:38  */
  assign n123_o = tile_0_filtered_output[4];
  /* /home/mlevental/dev_projects/bragghls/scripts/flopoco_fmul_3_4.vhdl:109:38  */
  assign n124_o = tile_0_filtered_output[5];
  /* /home/mlevental/dev_projects/bragghls/scripts/flopoco_fmul_3_4.vhdl:110:38  */
  assign n125_o = tile_0_filtered_output[6];
  /* /home/mlevental/dev_projects/bragghls/scripts/flopoco_fmul_3_4.vhdl:111:38  */
  assign n126_o = tile_0_filtered_output[7];
  /* /home/mlevental/dev_projects/bragghls/scripts/flopoco_fmul_3_4.vhdl:112:38  */
  assign n127_o = tile_0_filtered_output[8];
  /* /home/mlevental/dev_projects/bragghls/scripts/flopoco_fmul_3_4.vhdl:113:38  */
  assign n128_o = tile_0_filtered_output[9];
  /* /home/mlevental/dev_projects/bragghls/scripts/flopoco_fmul_3_4.vhdl:118:40  */
  assign n129_o = {bh7_w9_0, bh7_w8_0};
  /* /home/mlevental/dev_projects/bragghls/scripts/flopoco_fmul_3_4.vhdl:118:51  */
  assign n130_o = {n129_o, bh7_w7_0};
  /* /home/mlevental/dev_projects/bragghls/scripts/flopoco_fmul_3_4.vhdl:118:62  */
  assign n131_o = {n130_o, bh7_w6_0};
  /* /home/mlevental/dev_projects/bragghls/scripts/flopoco_fmul_3_4.vhdl:118:73  */
  assign n132_o = {n131_o, bh7_w5_0};
  /* /home/mlevental/dev_projects/bragghls/scripts/flopoco_fmul_3_4.vhdl:118:84  */
  assign n133_o = {n132_o, bh7_w4_0};
  /* /home/mlevental/dev_projects/bragghls/scripts/flopoco_fmul_3_4.vhdl:118:95  */
  assign n134_o = {n133_o, bh7_w3_0};
  /* /home/mlevental/dev_projects/bragghls/scripts/flopoco_fmul_3_4.vhdl:118:106  */
  assign n135_o = {n134_o, bh7_w2_0};
  /* /home/mlevental/dev_projects/bragghls/scripts/flopoco_fmul_3_4.vhdl:118:117  */
  assign n136_o = {n135_o, bh7_w1_0};
  /* /home/mlevental/dev_projects/bragghls/scripts/flopoco_fmul_3_4.vhdl:118:128  */
  assign n137_o = {n136_o, bh7_w0_0};
endmodule

module fmul #(parameter ID = 1)
  (input  clk,
   input  [9:0] X,
   input  [9:0] Y,
   output [9:0] R);
  wire sign;
  wire sign_d1;
  wire [2:0] expx;
  wire [2:0] expy;
  wire [4:0] expsumpresub;
  wire [4:0] bias;
  wire [4:0] expsum;
  wire [4:0] sigx;
  wire [4:0] sigy;
  wire [9:0] sigprod;
  wire [3:0] excsel;
  wire [1:0] exc;
  wire [1:0] exc_d1;
  wire norm;
  wire [4:0] exppostnorm;
  wire [9:0] sigprodext;
  wire [8:0] expsig;
  wire sticky;
  wire guard;
  wire round;
  wire [8:0] expsigpostround;
  wire [1:0] excpostnorm;
  wire [1:0] finalexc;
  wire n7_o;
  wire n8_o;
  wire n9_o;
  wire [2:0] n10_o;
  wire [2:0] n11_o;
  wire [4:0] n13_o;
  wire [4:0] n15_o;
  wire [4:0] n16_o;
  wire [4:0] n18_o;
  wire [3:0] n19_o;
  wire [4:0] n21_o;
  wire [3:0] n22_o;
  wire [4:0] n24_o;
  wire [9:0] significandmultiplication_n25;
  wire [9:0] significandmultiplication_r;
  wire [1:0] n28_o;
  wire [1:0] n29_o;
  wire [3:0] n30_o;
  wire n33_o;
  wire n35_o;
  wire n36_o;
  wire n38_o;
  wire n39_o;
  wire n42_o;
  wire n45_o;
  wire n47_o;
  wire n48_o;
  wire n50_o;
  wire n51_o;
  wire [2:0] n53_o;
  reg [1:0] n54_o;
  wire n55_o;
  wire [4:0] n57_o;
  wire [4:0] n58_o;
  wire [8:0] n59_o;
  wire [9:0] n61_o;
  wire [9:0] n62_o;
  wire [7:0] n63_o;
  wire [9:0] n65_o;
  wire [3:0] n66_o;
  wire [8:0] n67_o;
  wire n68_o;
  wire [4:0] n70_o;
  wire n72_o;
  wire n73_o;
  wire n75_o;
  wire n76_o;
  wire n77_o;
  wire n78_o;
  wire n79_o;
  wire n80_o;
  localparam [8:0] n81_o = 9'b000000000;
  wire [8:0] roundingadder_n82;
  wire [8:0] roundingadder_r;
  wire [1:0] n85_o;
  wire n88_o;
  wire n91_o;
  wire n94_o;
  wire n96_o;
  wire n97_o;
  wire [2:0] n99_o;
  reg [1:0] n100_o;
  wire n102_o;
  wire n104_o;
  wire n105_o;
  wire n107_o;
  wire n108_o;
  reg [1:0] n109_o;
  wire [2:0] n110_o;
  wire [6:0] n111_o;
  wire [9:0] n112_o;
  reg n113_q;
  reg [1:0] n114_q;
  assign R = n112_o;
  /* /home/mlevental/dev_projects/bragghls/scripts/flopoco_fmul_3_4.vhdl:220:8  */
  assign sign = n9_o; // (signal)
  /* /home/mlevental/dev_projects/bragghls/scripts/flopoco_fmul_3_4.vhdl:220:14  */
  assign sign_d1 = n113_q; // (signal)
  /* /home/mlevental/dev_projects/bragghls/scripts/flopoco_fmul_3_4.vhdl:221:8  */
  assign expx = n10_o; // (signal)
  /* /home/mlevental/dev_projects/bragghls/scripts/flopoco_fmul_3_4.vhdl:222:8  */
  assign expy = n11_o; // (signal)
  /* /home/mlevental/dev_projects/bragghls/scripts/flopoco_fmul_3_4.vhdl:223:8  */
  assign expsumpresub = n16_o; // (signal)
  /* /home/mlevental/dev_projects/bragghls/scripts/flopoco_fmul_3_4.vhdl:224:8  */
  assign bias = 5'b00011; // (signal)
  /* /home/mlevental/dev_projects/bragghls/scripts/flopoco_fmul_3_4.vhdl:225:8  */
  assign expsum = n18_o; // (signal)
  /* /home/mlevental/dev_projects/bragghls/scripts/flopoco_fmul_3_4.vhdl:226:8  */
  assign sigx = n21_o; // (signal)
  /* /home/mlevental/dev_projects/bragghls/scripts/flopoco_fmul_3_4.vhdl:227:8  */
  assign sigy = n24_o; // (signal)
  /* /home/mlevental/dev_projects/bragghls/scripts/flopoco_fmul_3_4.vhdl:228:8  */
  assign sigprod = significandmultiplication_n25; // (signal)
  /* /home/mlevental/dev_projects/bragghls/scripts/flopoco_fmul_3_4.vhdl:229:8  */
  assign excsel = n30_o; // (signal)
  /* /home/mlevental/dev_projects/bragghls/scripts/flopoco_fmul_3_4.vhdl:230:8  */
  assign exc = n54_o; // (signal)
  /* /home/mlevental/dev_projects/bragghls/scripts/flopoco_fmul_3_4.vhdl:230:13  */
  assign exc_d1 = n114_q; // (signal)
  /* /home/mlevental/dev_projects/bragghls/scripts/flopoco_fmul_3_4.vhdl:231:8  */
  assign norm = n55_o; // (signal)
  /* /home/mlevental/dev_projects/bragghls/scripts/flopoco_fmul_3_4.vhdl:232:8  */
  assign exppostnorm = n58_o; // (signal)
  /* /home/mlevental/dev_projects/bragghls/scripts/flopoco_fmul_3_4.vhdl:233:8  */
  assign sigprodext = n62_o; // (signal)
  /* /home/mlevental/dev_projects/bragghls/scripts/flopoco_fmul_3_4.vhdl:234:8  */
  assign expsig = n67_o; // (signal)
  /* /home/mlevental/dev_projects/bragghls/scripts/flopoco_fmul_3_4.vhdl:235:8  */
  assign sticky = n68_o; // (signal)
  /* /home/mlevental/dev_projects/bragghls/scripts/flopoco_fmul_3_4.vhdl:236:8  */
  assign guard = n73_o; // (signal)
  /* /home/mlevental/dev_projects/bragghls/scripts/flopoco_fmul_3_4.vhdl:237:8  */
  assign round = n80_o; // (signal)
  /* /home/mlevental/dev_projects/bragghls/scripts/flopoco_fmul_3_4.vhdl:238:8  */
  assign expsigpostround = roundingadder_n82; // (signal)
  /* /home/mlevental/dev_projects/bragghls/scripts/flopoco_fmul_3_4.vhdl:239:8  */
  assign excpostnorm = n100_o; // (signal)
  /* /home/mlevental/dev_projects/bragghls/scripts/flopoco_fmul_3_4.vhdl:240:8  */
  assign finalexc = n109_o; // (signal)
  /* /home/mlevental/dev_projects/bragghls/scripts/flopoco_fmul_3_4.vhdl:249:13  */
  assign n7_o = X[7];
  /* /home/mlevental/dev_projects/bragghls/scripts/flopoco_fmul_3_4.vhdl:249:22  */
  assign n8_o = Y[7];
  /* /home/mlevental/dev_projects/bragghls/scripts/flopoco_fmul_3_4.vhdl:249:17  */
  assign n9_o = n7_o ^ n8_o;
  /* /home/mlevental/dev_projects/bragghls/scripts/flopoco_fmul_3_4.vhdl:250:13  */
  assign n10_o = X[6:4];
  /* /home/mlevental/dev_projects/bragghls/scripts/flopoco_fmul_3_4.vhdl:251:13  */
  assign n11_o = Y[6:4];
  /* /home/mlevental/dev_projects/bragghls/scripts/flopoco_fmul_3_4.vhdl:252:26  */
  assign n13_o = {2'b00, expx};
  /* /home/mlevental/dev_projects/bragghls/scripts/flopoco_fmul_3_4.vhdl:252:42  */
  assign n15_o = {2'b00, expy};
  /* /home/mlevental/dev_projects/bragghls/scripts/flopoco_fmul_3_4.vhdl:252:34  */
  assign n16_o = n13_o + n15_o;
  /* /home/mlevental/dev_projects/bragghls/scripts/flopoco_fmul_3_4.vhdl:254:27  */
  assign n18_o = expsumpresub - bias;
  /* /home/mlevental/dev_projects/bragghls/scripts/flopoco_fmul_3_4.vhdl:255:19  */
  assign n19_o = X[3:0];
  /* /home/mlevental/dev_projects/bragghls/scripts/flopoco_fmul_3_4.vhdl:255:16  */
  assign n21_o = {1'b1, n19_o};
  /* /home/mlevental/dev_projects/bragghls/scripts/flopoco_fmul_3_4.vhdl:256:19  */
  assign n22_o = Y[3:0];
  /* /home/mlevental/dev_projects/bragghls/scripts/flopoco_fmul_3_4.vhdl:256:16  */
  assign n24_o = {1'b1, n22_o};
  /* /home/mlevental/dev_projects/bragghls/scripts/flopoco_fmul_3_4.vhdl:261:23  */
  assign significandmultiplication_n25 = significandmultiplication_r; // (signal)
  /* /home/mlevental/dev_projects/bragghls/scripts/flopoco_fmul_3_4.vhdl:257:4  */
  intmultiplier_f300_uid5 significandmultiplication (
    .clk(clk),
    .x(sigx),
    .y(sigy),
    .r(significandmultiplication_r));
  /* /home/mlevental/dev_projects/bragghls/scripts/flopoco_fmul_3_4.vhdl:262:15  */
  assign n28_o = X[9:8];
  /* /home/mlevental/dev_projects/bragghls/scripts/flopoco_fmul_3_4.vhdl:262:31  */
  assign n29_o = Y[9:8];
  /* /home/mlevental/dev_projects/bragghls/scripts/flopoco_fmul_3_4.vhdl:262:28  */
  assign n30_o = {n28_o, n29_o};
  /* /home/mlevental/dev_projects/bragghls/scripts/flopoco_fmul_3_4.vhdl:264:16  */
  assign n33_o = excsel == 4'b0000;
  /* /home/mlevental/dev_projects/bragghls/scripts/flopoco_fmul_3_4.vhdl:264:29  */
  assign n35_o = excsel == 4'b0001;
  /* /home/mlevental/dev_projects/bragghls/scripts/flopoco_fmul_3_4.vhdl:264:29  */
  assign n36_o = n33_o | n35_o;
  /* /home/mlevental/dev_projects/bragghls/scripts/flopoco_fmul_3_4.vhdl:264:38  */
  assign n38_o = excsel == 4'b0100;
  /* /home/mlevental/dev_projects/bragghls/scripts/flopoco_fmul_3_4.vhdl:264:38  */
  assign n39_o = n36_o | n38_o;
  /* /home/mlevental/dev_projects/bragghls/scripts/flopoco_fmul_3_4.vhdl:265:16  */
  assign n42_o = excsel == 4'b0101;
  /* /home/mlevental/dev_projects/bragghls/scripts/flopoco_fmul_3_4.vhdl:266:16  */
  assign n45_o = excsel == 4'b0110;
  /* /home/mlevental/dev_projects/bragghls/scripts/flopoco_fmul_3_4.vhdl:266:28  */
  assign n47_o = excsel == 4'b1001;
  /* /home/mlevental/dev_projects/bragghls/scripts/flopoco_fmul_3_4.vhdl:266:28  */
  assign n48_o = n45_o | n47_o;
  /* /home/mlevental/dev_projects/bragghls/scripts/flopoco_fmul_3_4.vhdl:266:37  */
  assign n50_o = excsel == 4'b1010;
  /* /home/mlevental/dev_projects/bragghls/scripts/flopoco_fmul_3_4.vhdl:266:37  */
  assign n51_o = n48_o | n50_o;
  assign n53_o = {n51_o, n42_o, n39_o};
  /* /home/mlevental/dev_projects/bragghls/scripts/flopoco_fmul_3_4.vhdl:263:4  */
  always @*
    case (n53_o)
      3'b100: n54_o = 2'b10;
      3'b010: n54_o = 2'b01;
      3'b001: n54_o = 2'b00;
      default: n54_o = 2'b11;
    endcase
  /* /home/mlevental/dev_projects/bragghls/scripts/flopoco_fmul_3_4.vhdl:268:19  */
  assign n55_o = sigprod[9];
  /* /home/mlevental/dev_projects/bragghls/scripts/flopoco_fmul_3_4.vhdl:270:36  */
  assign n57_o = {4'b0000, norm};
  /* /home/mlevental/dev_projects/bragghls/scripts/flopoco_fmul_3_4.vhdl:270:26  */
  assign n58_o = expsum + n57_o;
  /* /home/mlevental/dev_projects/bragghls/scripts/flopoco_fmul_3_4.vhdl:272:25  */
  assign n59_o = sigprod[8:0];
  /* /home/mlevental/dev_projects/bragghls/scripts/flopoco_fmul_3_4.vhdl:272:38  */
  assign n61_o = {n59_o, 1'b0};
  /* /home/mlevental/dev_projects/bragghls/scripts/flopoco_fmul_3_4.vhdl:272:44  */
  assign n62_o = norm ? n61_o : n65_o;
  /* /home/mlevental/dev_projects/bragghls/scripts/flopoco_fmul_3_4.vhdl:273:33  */
  assign n63_o = sigprod[7:0];
  /* /home/mlevental/dev_projects/bragghls/scripts/flopoco_fmul_3_4.vhdl:273:46  */
  assign n65_o = {n63_o, 2'b00};
  /* /home/mlevental/dev_projects/bragghls/scripts/flopoco_fmul_3_4.vhdl:274:38  */
  assign n66_o = sigprodext[9:6];
  /* /home/mlevental/dev_projects/bragghls/scripts/flopoco_fmul_3_4.vhdl:274:26  */
  assign n67_o = {exppostnorm, n66_o};
  /* /home/mlevental/dev_projects/bragghls/scripts/flopoco_fmul_3_4.vhdl:275:24  */
  assign n68_o = sigprodext[5];
  /* /home/mlevental/dev_projects/bragghls/scripts/flopoco_fmul_3_4.vhdl:276:32  */
  assign n70_o = sigprodext[4:0];
  /* /home/mlevental/dev_projects/bragghls/scripts/flopoco_fmul_3_4.vhdl:276:44  */
  assign n72_o = n70_o == 5'b00000;
  /* /home/mlevental/dev_projects/bragghls/scripts/flopoco_fmul_3_4.vhdl:276:17  */
  assign n73_o = n72_o ? 1'b0 : 1'b1;
  /* /home/mlevental/dev_projects/bragghls/scripts/flopoco_fmul_3_4.vhdl:277:51  */
  assign n75_o = sigprodext[6];
  /* /home/mlevental/dev_projects/bragghls/scripts/flopoco_fmul_3_4.vhdl:277:37  */
  assign n76_o = ~n75_o;
  /* /home/mlevental/dev_projects/bragghls/scripts/flopoco_fmul_3_4.vhdl:277:33  */
  assign n77_o = guard & n76_o;
  /* /home/mlevental/dev_projects/bragghls/scripts/flopoco_fmul_3_4.vhdl:277:71  */
  assign n78_o = sigprodext[6];
  /* /home/mlevental/dev_projects/bragghls/scripts/flopoco_fmul_3_4.vhdl:277:57  */
  assign n79_o = n77_o | n78_o;
  /* /home/mlevental/dev_projects/bragghls/scripts/flopoco_fmul_3_4.vhdl:277:20  */
  assign n80_o = sticky & n79_o;
  /* /home/mlevental/dev_projects/bragghls/scripts/flopoco_fmul_3_4.vhdl:283:23  */
  assign roundingadder_n82 = roundingadder_r; // (signal)
  /* /home/mlevental/dev_projects/bragghls/scripts/flopoco_fmul_3_4.vhdl:278:4  */
  intadder_9_f300_uid13 roundingadder (
    .clk(clk),
    .x(expsig),
    .y(n81_o),
    .cin(round),
    .r(roundingadder_r));
  /* /home/mlevental/dev_projects/bragghls/scripts/flopoco_fmul_3_4.vhdl:284:24  */
  assign n85_o = expsigpostround[8:7];
  /* /home/mlevental/dev_projects/bragghls/scripts/flopoco_fmul_3_4.vhdl:285:26  */
  assign n88_o = n85_o == 2'b00;
  /* /home/mlevental/dev_projects/bragghls/scripts/flopoco_fmul_3_4.vhdl:286:49  */
  assign n91_o = n85_o == 2'b01;
  /* /home/mlevental/dev_projects/bragghls/scripts/flopoco_fmul_3_4.vhdl:287:49  */
  assign n94_o = n85_o == 2'b11;
  /* /home/mlevental/dev_projects/bragghls/scripts/flopoco_fmul_3_4.vhdl:287:58  */
  assign n96_o = n85_o == 2'b10;
  /* /home/mlevental/dev_projects/bragghls/scripts/flopoco_fmul_3_4.vhdl:287:58  */
  assign n97_o = n94_o | n96_o;
  assign n99_o = {n97_o, n91_o, n88_o};
  /* /home/mlevental/dev_projects/bragghls/scripts/flopoco_fmul_3_4.vhdl:284:4  */
  always @*
    case (n99_o)
      3'b100: n100_o = 2'b00;
      3'b010: n100_o = 2'b10;
      3'b001: n100_o = 2'b01;
      default: n100_o = 2'b11;
    endcase
  /* /home/mlevental/dev_projects/bragghls/scripts/flopoco_fmul_3_4.vhdl:290:23  */
  assign n102_o = exc_d1 == 2'b11;
  /* /home/mlevental/dev_projects/bragghls/scripts/flopoco_fmul_3_4.vhdl:290:33  */
  assign n104_o = exc_d1 == 2'b10;
  /* /home/mlevental/dev_projects/bragghls/scripts/flopoco_fmul_3_4.vhdl:290:33  */
  assign n105_o = n102_o | n104_o;
  /* /home/mlevental/dev_projects/bragghls/scripts/flopoco_fmul_3_4.vhdl:290:38  */
  assign n107_o = exc_d1 == 2'b00;
  /* /home/mlevental/dev_projects/bragghls/scripts/flopoco_fmul_3_4.vhdl:290:38  */
  assign n108_o = n105_o | n107_o;
  /* /home/mlevental/dev_projects/bragghls/scripts/flopoco_fmul_3_4.vhdl:289:4  */
  always @*
    case (n108_o)
      1'b1: n109_o = exc_d1;
      default: n109_o = excpostnorm;
    endcase
  /* /home/mlevental/dev_projects/bragghls/scripts/flopoco_fmul_3_4.vhdl:292:18  */
  assign n110_o = {finalexc, sign_d1};
  /* /home/mlevental/dev_projects/bragghls/scripts/flopoco_fmul_3_4.vhdl:292:45  */
  assign n111_o = expsigpostround[6:0];
  /* /home/mlevental/dev_projects/bragghls/scripts/flopoco_fmul_3_4.vhdl:292:28  */
  assign n112_o = {n110_o, n111_o};
  /* /home/mlevental/dev_projects/bragghls/scripts/flopoco_fmul_3_4.vhdl:244:10  */
  always @(posedge clk)
    n113_q <= sign;
  /* /home/mlevental/dev_projects/bragghls/scripts/flopoco_fmul_3_4.vhdl:244:10  */
  always @(posedge clk)
    n114_q <= exc;
endmodule
