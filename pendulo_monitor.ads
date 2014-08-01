with System;
with Ada.Real_Time;   use Ada.Real_Time;
with Common_Types; use Common_Types;

package Pendulo_Monitor is

   type Index is mod 92;
   type Secuencia is array (Index) of Byte;

   type Seccion is mod 9;
   type Imagen is array (Seccion) of Byte;

   type Fotograma is mod 12;
   type Animacion is array (Fotograma) of Secuencia;

   type Position is
      record
         A, B, C, D: Time := Clock;
      end record;

   protected Monitor is
      pragma Priority(System.Priority'Last - 1);
      function Get_Period return Time_Span;
      procedure Set_Period (P : in Time_Span);
      procedure Reset_Period;
      function Get_Position return Position;
      procedure Set_Position (P : in Position);
      function Get_Inicio return Time;
      procedure Set_Inicio (I : in Time);
   private
      Per : Time_Span;
      Pos : Position;
      Ini : Time;
   end Monitor;

   function Conversor(L: in String) return Secuencia;

   function Animador(I1, I2, I3, I4, I5, I6, I7, I8 : in Imagen) return Secuencia;

   function Inversor (S : in Secuencia) return Secuencia;

   task Posicionador is
      pragma Priority(System.Priority'Last - 1);
   end Posicionador;

   procedure Iluminador (Cadena: in Secuencia);

   procedure Iluminador (Film: in Animacion);

end Pendulo_Monitor;
