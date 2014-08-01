--pragma Task_Dispatching_Policy(FIFO_Within_Priorities);
--pragma Locking_Policy(Ceiling_Locking);

with Pendulo_Monitor;   use Pendulo_Monitor;
with Gnat.IO;       use Gnat.IO;

procedure Main is
   Ani1, Ani2 : Animacion;
   Img0, Img1, Img2, Img3, Img4, Img5, Img6 : Imagen;
begin
   Put_Line("Begining of program.");

   -- Animacion: ¡BRAVO!

   Img0(0) := 16#00#;
   Img0(1) := 16#90#; --   ###
   Img0(2) := 16#C8#; --   # #
   Img0(3) := 16#A7#; --   ###
   Img0(4) := 16#1D#; --  # # #
   Img0(5) := 16#A7#; -- #  #  #
   Img0(6) := 16#C8#; --   # #
   Img0(7) := 16#90#; --  #   #
   Img0(8) := 16#00#; -- ### ###

   Img1(0) := 16#00#;
   Img1(1) := 16#88#; --   ###
   Img1(2) := 16#C8#; --   # #
   Img1(3) := 16#A7#; --   ###
   Img1(4) := 16#1D#; -- ## # ##
   Img1(5) := 16#A7#; --    #
   Img1(6) := 16#C8#; --   # #
   Img1(7) := 16#88#; --  #   #
   Img1(8) := 16#00#; -- ### ###

   Img2(0) := 16#00#;
   Img2(1) := 16#84#; --   ###
   Img2(2) := 16#C8#; --   # #
   Img2(3) := 16#A7#; -- # ### #
   Img2(4) := 16#1D#; --  # # #
   Img2(5) := 16#A7#; --    #
   Img2(6) := 16#C8#; --   # #
   Img2(7) := 16#84#; --  #   #
   Img2(8) := 16#00#; -- ### ###

   Img3(0) := 16#00#;
   Img3(1) := 16#83#; -- # ### #
   Img3(2) := 16#C4#; -- # # # #
   Img3(3) := 16#A7#; --  #####
   Img3(4) := 16#1D#; --    #
   Img3(5) := 16#A7#; --    #
   Img3(6) := 16#C4#; --   # #
   Img3(7) := 16#83#; --  #   #
   Img3(8) := 16#00#; -- ### ###

   Ani1(0) := Pendulo_Monitor.Animador(Img3, Img0, Img2, Img1, Img3, Img2, Img1, Img0);
   Ani1(1) := Pendulo_Monitor.Animador(Img3, Img0, Img2, Img1, Img3, Img2, Img1, Img0);
   Ani1(2) := Pendulo_Monitor.Animador(Img2, Img1, Img1, Img2, Img2, Img1, Img2, Img1);
   Ani1(3) := Pendulo_Monitor.Animador(Img2, Img1, Img1, Img2, Img2, Img1, Img2, Img1);
   Ani1(4) := Pendulo_Monitor.Animador(Img1, Img2, Img0, Img3, Img1, Img0, Img3, Img2);
   Ani1(5) := Pendulo_Monitor.Animador(Img1, Img2, Img0, Img3, Img1, Img0, Img3, Img2);
   Ani1(6) := Pendulo_Monitor.Animador(Img0, Img3, Img1, Img2, Img0, Img1, Img2, Img3);
   Ani1(7) := Pendulo_Monitor.Animador(Img0, Img3, Img1, Img2, Img0, Img1, Img2, Img3);
   Ani1(8) := Pendulo_Monitor.Animador(Img1, Img2, Img2, Img1, Img1, Img2, Img1, Img2);
   Ani1(9) := Pendulo_Monitor.Animador(Img1, Img2, Img2, Img1, Img1, Img2, Img1, Img2);
   Ani1(10) := Pendulo_Monitor.Animador(Img2, Img1, Img3, Img0, Img2, Img3, Img0, Img1);
   Ani1(11) := Pendulo_Monitor.Animador(Img2, Img1, Img3, Img0, Img2, Img3, Img0, Img1);

   -- Animacion: Corredor

   Img0(0) := 16#00#;
   Img0(1) := 16#00#;
   Img0(2) := 16#00#;
   Img0(3) := 16#00#;
   Img0(4) := 16#00#;
   Img0(5) := 16#00#;
   Img0(6) := 16#00#;
   Img0(7) := 16#00#;
   Img0(8) := 16#00#;

   Img1(0) := 16#00#;
   Img1(1) := 16#48#; --     ###
   Img1(2) := 16#C4#; --     # #
   Img1(3) := 16#B4#; --  ######
   Img1(4) := 16#1C#; -- #  #
   Img1(5) := 16#D7#; --   ###
   Img1(6) := 16#A5#; --   #  #
   Img1(7) := 16#87#; -- ##  #
   Img1(8) := 16#00#; --  ## ###

   Img2(0) := 16#00#;
   Img2(1) := 16#68#; --     ###
   Img2(2) := 16#24#; --     # #
   Img2(3) := 16#34#; --  ######
   Img2(4) := 16#1C#; -- #  #
   Img2(5) := 16#D7#; --   ####
   Img2(6) := 16#B5#; -- ###  #
   Img2(7) := 16#87#; -- #   #
   Img2(8) := 16#00#; --     ###

   Img3(0) := 16#00#;
   Img3(1) := 16#08#; --     ###
   Img3(2) := 16#24#; --     # #
   Img3(3) := 16#34#; --  ######
   Img3(4) := 16#3C#; -- #  #
   Img3(5) := 16#D7#; --   ####
   Img3(6) := 16#B5#; --  ### #
   Img3(7) := 16#87#; --     #
   Img3(8) := 16#00#; --     ###

   Img4(0) := 16#00#;
   Img4(1) := 16#88#; --     ###
   Img4(2) := 16#C4#; --     # #
   Img4(3) := 16#B4#; --  ######
   Img4(4) := 16#1C#; -- #  #
   Img4(5) := 16#57#; --   ###
   Img4(6) := 16#E5#; --   #  #
   Img4(7) := 16#87#; --  #  ##
   Img4(8) := 16#00#; -- ###  ##

   Img5(0) := 16#00#;
   Img5(1) := 16#88#; --     ###
   Img5(2) := 16#C4#; --     # #
   Img5(3) := 16#B4#; --  ######
   Img5(4) := 16#1C#; -- #  #
   Img5(5) := 16#57#; --   ####
   Img5(6) := 16#75#; --   #  #
   Img5(7) := 16#47#; --  #  ###
   Img5(8) := 16#00#; -- ###

   Img6(0) := 16#00#;
   Img6(1) := 16#88#; --     ###
   Img6(2) := 16#C4#; --     # #
   Img6(3) := 16#B4#; --  ######
   Img6(4) := 16#1C#; -- #  #
   Img6(5) := 16#37#; --   ####
   Img6(6) := 16#35#; --   # ###
   Img6(7) := 16#27#; --  #
   Img6(8) := 16#00#; -- ###

   Ani2(0) := Pendulo_Monitor.Animador(Img1, Img0, Img5, Img0, Img3, Img0, Img5, Img0);
   Ani2(1) := Pendulo_Monitor.Animador(Img1, Img0, Img5, Img0, Img3, Img0, Img5, Img0);
   Ani2(2) := Pendulo_Monitor.Animador(Img0, Img2, Img0, Img4, Img0, Img2, Img0, Img6);
   Ani2(3) := Pendulo_Monitor.Animador(Img0, Img2, Img0, Img4, Img0, Img2, Img0, Img6);
   Ani2(4) := Pendulo_Monitor.Animador(Img5, Img0, Img3, Img0, Img1, Img0, Img1, Img0);
   Ani2(5) := Pendulo_Monitor.Animador(Img5, Img0, Img3, Img0, Img1, Img0, Img1, Img0);
   Ani2(6) := Pendulo_Monitor.Animador(Img0, Img4, Img0, Img2, Img0, Img2, Img0, Img4);
   Ani2(7) := Pendulo_Monitor.Animador(Img0, Img4, Img0, Img2, Img0, Img2, Img0, Img4);
   Ani2(8) := Pendulo_Monitor.Animador(Img5, Img0, Img1, Img0, Img1, Img0, Img3, Img0);
   Ani2(9) := Pendulo_Monitor.Animador(Img5, Img0, Img1, Img0, Img1, Img0, Img3, Img0);
   Ani2(10) := Pendulo_Monitor.Animador(Img0, Img6, Img0, Img2, Img0, Img4, Img0, Img2);
   Ani2(11) := Pendulo_Monitor.Animador(Img0, Img6, Img0, Img2, Img0, Img4, Img0, Img2);

   Put_Line("String converted to animation.");

   delay 3.0;
   Pendulo_Monitor.Iluminador(Ani2);
end Main;
