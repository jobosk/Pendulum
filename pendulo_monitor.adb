with Pendulum_Io; use Pendulum_Io;
with Chars_8x5;       use Chars_8x5;
with Common_Types; use Common_Types;
with Ada.Real_Time;   use Ada.Real_Time;
with Gnat.IO;       use Gnat.IO;

package body Pendulo_Monitor is

   protected body Monitor is

      function Get_Period return Time_Span is
      begin
         return Per;
      end Get_Period;

      procedure Set_Period (P : in Time_Span) is
      begin
         Per := P;
      end Set_Period;

      procedure Reset_Period is
      begin
         Per := Milliseconds(115);
      end Reset_Period;

      function Get_Position return Position is
      begin
         return Pos;
      end Get_Position;

      procedure Set_Position (P : in Position) is
      begin
         Pos := P;
      end Set_Position;

      function Get_Inicio return Time is
      begin
         return Ini;
      end Get_Inicio;

      procedure Set_Inicio (I : in Time) is
      begin
         Ini := I;
      end Set_Inicio;

   end Monitor;

   function Conversor(L: in String) return Secuencia is
      I : Index := 0;
      S : Secuencia;
      Letra : Character;
      Espacio : Byte := 2#0000_0000#;
   begin
      -- Metemos espacios al principio
      while (I < 10) loop
         S(I) := Espacio;
         I := I + 1;
      end loop;

      -- Leemos la cadena de entrada, caracter a caracter
      for K in L'Range loop
         Letra := L(K);
         for J in Integer range 0 .. 5 loop
            if (J /= 5) then
               -- Para las 5 primeras metemos la codificacion del Byte de esa fila
               S(I) := Chars_8x5.Char_Map(Letra,J);
            else
               -- Para la 6 metemos un espacio
               S(I) := Espacio;
            end if;
            I := I + 1;
         end loop;
      end loop;

      -- Metemos mas espacios hasta el final
      while (I /= 0) loop
         S(I) := Espacio;
         I := I + 1;
      end loop;

      return S;

   end Conversor;

   function Animador(I1, I2, I3, I4, I5, I6, I7, I8 : in Imagen) return Secuencia is
      S : Secuencia;
      J : Index := 10;
   begin
      for I in Index range 0 .. 9 loop
         S(I) := 16#00#;
      end loop;

      -- Imagen 1
      for I in Seccion range 0 .. 8 loop
         S(J) := I1(I);
         J := J + 1;
      end loop;

      -- Imagen 2
      for I in Seccion range 0 .. 8 loop
         S(J) := I2(I);
         J := J + 1;
      end loop;

      -- Imagen 3
      for I in Seccion range 0 .. 8 loop
         S(J) := I3(I);
         J := J + 1;
      end loop;

      -- Imagen 4
      for I in Seccion range 0 .. 8 loop
         S(J) := I4(I);
         J := J + 1;
      end loop;

      -- Imagen 5
      for I in Seccion range 0 .. 8 loop
         S(J) := I5(I);
         J := J + 1;
      end loop;

      -- Imagen 6
      for I in Seccion range 0 .. 8 loop
         S(J) := I6(I);
         J := J + 1;
      end loop;

      -- Imagen 7
      for I in Seccion range 0 .. 8 loop
         S(J) := I7(I);
         J := J + 1;
      end loop;

      -- Imagen 8
      for I in Seccion range 0 .. 8 loop
         S(J) := I8(I);
         J := J + 1;
      end loop;

      for I in Index range 82 .. 91 loop
         S(I) := 16#00#;
      end loop;

      return S;

   end Animador;

   function Inversor (S : in Secuencia) return Secuencia is
      S_aux : Secuencia;
      I : Index := 91;
   begin
      for J in Index range 0 .. 91 loop
         S_aux(J) := S(I);
         I := I - 1;
      end loop;
      return S_aux;
   end Inversor;

   task body Posicionador is
      Periodo_Pos : Time_Span := Milliseconds(1);
      Next : Time := Clock;
      P : Position;
      Orig : Time_Span;
      Ini, Fin : Time := Clock;
      Period : Time_Span := Milliseconds(115);
      Prev_Barrier : Boolean := False;
      Barrier, Sync : Boolean := False;
   begin
      loop
         Barrier := Get_Barrier;
         Sync := Get_Sync;

         if (Barrier = True) then
            if (Sync = True and Prev_Barrier = False) then
               P.A := Clock;
               Orig := (P.A - P.D) / 2;
               Monitor.Set_Inicio(P.A + (Period - Orig));
            end if;
         else
            if (Sync = False and Prev_Barrier = True) then
               P.D := Clock;
               Fin := Clock;
               Period := Fin - Ini;
               Ini := Fin;
               Monitor.Set_Period(Period);
            end if;
         end if;

         Prev_Barrier := Barrier;


         -- FORMA ANTIGUA DE CALCULAR EL PERIODO Y EL SIGUIENTE INICIO
         -- Esta comentado y no borrado porque al probarlo con el simulador
         -- la nueva forma daba problemas mientras que la vieja no.

         --while (Get_Barrier = False and Get_Sync = False and Prev_Barrier = False) loop
            --delay 0.001;
         --end loop;
         --P.A := Clock;
         --Prev_Barrier := True;

         --Orig := (P.A - P.D) / 2;
         --Monitor.Set_Inicio(P.A + (Period - Orig));

         --while (Get_Barrier = True and Get_Sync = True) loop
            --delay 0.001;
         --end loop;
         --P.B := Clock;

         --while (Get_Barrier = False and Get_Sync = True) loop
            --delay 0.001;
         --end loop;

         --while (Get_Barrier = False and Get_Sync = False and Prev_Barrier = True) loop
            --delay 0.001;
         --end loop;
         --P.C := Clock;
         --Prev_Barrier := False;

         --while (Get_Barrier = True and Get_Sync = False) loop
            --delay 0.001;
         --end loop;
         --P.D := Clock;

         --Fin := Clock;
         --Period := Fin - Ini;
         --Ini := Fin;

         --Monitor.Set_Period(Period);
         --Monitor.Set_Position(P);

         Next := Next + Periodo_Pos;
         delay until Next;
      end loop;
   end Posicionador;

   procedure Iluminador (Cadena: in Secuencia) is
      Periodo_Leds : Time_Span;
      Next, Ini : Time;
      CadenaI : Secuencia := Inversor(Cadena);
   begin
      loop
         Ini := Monitor.Get_Inicio;

         Periodo_Leds := Monitor.Get_Period / 184;

         Next := Ini;
         for I in Index range 0..91 loop
            Set_Leds(Cadena(I));
            delay 0.00035;
            Reset_Leds;

            Next := Next + Periodo_Leds;
            delay until Next;
         end loop;

         for I in Index range 0..91 loop
            Set_Leds(CadenaI(I));
            delay 0.00035;
            Reset_Leds;

            Next := Next + Periodo_Leds;
            delay until Next;
         end loop;

         Reset_Leds;
         delay until Ini;
      end loop;
   end Iluminador;

   procedure Iluminador (Film: in Animacion) is
      Periodo_Leds : Time_Span;
      Next, Ini : Time;
      Cadena, CadenaI : Secuencia;
      I : Fotograma := 0;
   begin
      loop
         Cadena := Film(I);
         CadenaI := Inversor(Cadena);
         I := I + 1;

         Ini := Monitor.Get_Inicio;

         Periodo_Leds := Monitor.Get_Period / 184;

         Next := Ini;
         for I in Index range 0..91 loop
            Set_Leds(Cadena(I));
            delay 0.00035;
            Reset_Leds;

            Next := Next + Periodo_Leds;
            delay until Next;
         end loop;

         for I in Index range 0..91 loop
            Set_Leds(CadenaI(I));
            delay 0.00035;
            Reset_Leds;

            Next := Next + Periodo_Leds;
            delay until Next;
         end loop;

         Reset_Leds;
         delay until Ini;
      end loop;
   end Iluminador;

end Pendulo_Monitor;
