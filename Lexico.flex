package analizadorLexico;
import java_cup.runtime.*;
import java.util.*;
import java.lang.*;
import jflex.core.sym;
import vista.VentanaPrincipal;

%%

%cup
%public
%class Lexico
%line
%column
%char

LETRA = [a-zA-Z]
DIGITO = [0-9]
ESPACIO = [ \t\f\n\r\n]+
ID = {LETRA} ({LETRA} | {DIGITO} | _ ({DIGITO}|{LETRA}) )*
CONST_FLOAT = \-?{DIGITO}+\.{DIGITO}+ | \-?\.{DIGITO}+ | \-?{DIGITO}+\.
CONST_INT = \-?{DIGITO}+
CONST_BIN = (0b).(0|1)+
CONST_STR = \" (.{0,30}) \"
COMENTARIO_BLOQUE = "//*"([^*]|"*"+[^/])*"*//"
COMENTARIO_LINEA = "//" ~[\n]

%%

<YYINITIAL> {

"WHILE"                      {System.out.println("Token WHILE encontrado, Lexema "+ yytext());
                              VentanaPrincipal.je.append("Token WHILE encontrado, Lexema "+yytext());                          }

"IF"                         {System.out.println("Token IF encontrado, Lexema "+ yytext());
      VentanaPrincipal.je.append("Token IF encontrado, Lexema "+yytext()+ "\n"); }

"THEN"                       {System.out.println("Token THEN encontrado, Lexema "+ yytext());
       VentanaPrincipal.je.append("Token THEN encontrado, Lexema "+yytext()+"\n");}

"ELSE"                       {System.out.println("Token ELSE encontrado, Lexema "+ yytext());
       VentanaPrincipal.je.append("Token ELSE encontrado, Lexema "+yytext()+"\n");}

"::="                        {System.out.println("Token ASIGN encontrado, Lexema "+ yytext());
       VentanaPrincipal.je.append("Token ASIGN encontrado, Lexema "+yytext()+"\n");}

":="                         {System.out.println("Token DECLARA encontrado, Lexema "+ yytext());
       VentanaPrincipal.je.append("Token DECLARA encontrado, Lexema "+yytext()+"\n");}

"+"                          {System.out.println("Token SUMA encontrado, Lexema "+ yytext());
      VentanaPrincipal.je.append("Token SUMA encontrado, Lexema "+yytext()+"\n");}

"*"                          {System.out.println("Token MULTIPLICACION encontrado, Lexema "+ yytext());
      VentanaPrincipal.je.append("Token MULTIPLICACION encontrado, Lexema "+yytext()+"\n");}

"-"                          {System.out.println("Token RESTA encontrado, Lexema "+ yytext());
      VentanaPrincipal.je.append("Token RESTA encontrado, Lexema "+yytext()+"\n");}

"/"                          {System.out.println("Token DIVISION encontrado, Lexema "+ yytext());
      VentanaPrincipal.je.append("Token DIVISION encontrado, Lexema "+yytext()+"\n");}

"["                          {System.out.println("Token APERTURA encontrado, Lexema "+ yytext());
      VentanaPrincipal.je.append("Token APERTURA encontrado, Lexema "+yytext()+"\n");}

"]"                          {System.out.println("Token CIERRE encontrado, Lexema "+ yytext());
      VentanaPrincipal.je.append("Token CIERRE encontrado, Lexema "+yytext()+"\n");}

"WRITE"                      {System.out.println("Token WRITE encontrado, Lexema "+ yytext());
      VentanaPrincipal.je.append("Token WRITE encontrado, Lexema "+yytext()+"\n");}

">"                          {System.out.println("Token MAYOR encontrado, Lexema "+ yytext());
      VentanaPrincipal.je.append("Token MAYOR encontrado, Lexema "+yytext()+"\n");}

"<"                          {System.out.println("Token MENOR encontrado, Lexema "+ yytext());
      VentanaPrincipal.je.append("Token MENOR encontrado, Lexema "+yytext()+"\n");}

">="                         {System.out.println("Token MAYOR_IGUAL encontrado, Lexema "+ yytext());
      VentanaPrincipal.je.append("Token MAYOR_IGUAL encontrado, Lexema "+yytext()+"\n");}

"<="                         {System.out.println("Token MENOR_IGUAL encontrado, Lexema "+ yytext());
      VentanaPrincipal.je.append("Token MENOR_IGUAL encontrado, Lexema "+yytext()+"\n");}

"=="                         {System.out.println("Token COMPARAR_IGUAL encontrado, Lexema "+ yytext());
      VentanaPrincipal.je.append("Token COMPARAR_IGUAL encontrado, Lexema "+yytext()+"\n");}

"!"                          {System.out.println("Token NEGACION encontrado, Lexema "+ yytext());
      VentanaPrincipal.je.append("Token NEGACION encontrado, Lexema "+yytext()+"\n");}

"!="                         {System.out.println("Token DISTINTO encontrado, Lexema "+ yytext());
      VentanaPrincipal.je.append("Token DISTINTO encontrado, Lexema "+yytext()+"\n");}

"&&"                         {System.out.println("Token AND encontrado, Lexema "+ yytext());
      VentanaPrincipal.je.append("Token AND encontrado, Lexema "+yytext()+"\n");}

"("                          {System.out.println("Token ABRIR_PARENTESIS encontrado, Lexema "+ yytext());
      VentanaPrincipal.je.append("Token ABRIR_PARENTESIS encontrado, Lexema "+yytext()+"\n");}

")"                          {System.out.println("Token CERRAR_PARENTESIS encontrado, Lexema "+ yytext());
      VentanaPrincipal.je.append("Token CERRAR_PARENTESIS encontrado, Lexema "+yytext()+"\n");}

"||"                         {System.out.println("Token OR encontrado, Lexema "+ yytext());
      VentanaPrincipal.je.append("Token OR encontrado, Lexema "+yytext()+"\n");}

"DECLARE.SECTION"            {System.out.println("Token DECLARE_SECTION encontrado, Lexema "+ yytext());
      VentanaPrincipal.je.append("Token DECLARE_SECTION encontrado, Lexema "+yytext()+"\n");}

"ENDDECLARE.SECTION"         {System.out.println("Token ENDDECLARE_SECTION encontrado, Lexema "+ yytext());
      VentanaPrincipal.je.append("Token ENDDECLARE_SECTION encontrado, Lexema "+yytext()+"\n");}

"PROGRAM.SECTION"            {System.out.println("Token PROGRAM.SECTION encontrado, Lexema "+ yytext());
      VentanaPrincipal.je.append("Token PROGRAM.SECTION encontrado, Lexema "+yytext()+"\n");}

"ENDPROGRAM.SECTION"         {System.out.println("Token ENDPROGRAM.SECTION  encontrado, Lexema "+ yytext());
      VentanaPrincipal.je.append("Token ENDPROGRAM.SECTION encontrado, Lexema "+yytext()+"\n");}

";"                          {System.out.println("Token TERMINACION_LINEA encontrado, Lexema "+ yytext());
      VentanaPrincipal.je.append("Token TERMINACION_LINEA encontrado, Lexema "+yytext()+"\n");}

","                          {System.out.println("Token SEP_LISTA encontrado, Lexema "+ yytext());
                              VentanaPrincipal.je.append("Token SEP_LISTA encontrado, Lexema "+yytext()+"\n");}

"INT"                        {System.out.println("Token TIPO_INT encontrado, Lexema "+ yytext());
                              VentanaPrincipal.je.append("Token TIPO_INT encontrado, Lexema "+yytext()+"\n");}

"FLOAT"                      {System.out.println("Token TIPO_FLOAT encontrado, Lexema "+ yytext());
                              VentanaPrincipal.je.append("Token TIPO_FLOAT encontrado, Lexema "+yytext()+"\n");}

"STRING"                     {System.out.println("Token TIPO_STRING encontrado, Lexema "+ yytext());
                              VentanaPrincipal.je.append("Token TIPO_STRING encontrado, Lexema "+yytext()+"\n");}

"TAKE"                       {System.out.println("Token TAKE encontrado, Lexema "+ yytext());
                              VentanaPrincipal.je.append("Token TAKE encontrado, Lexema "+yytext()+"\n");}

{ID}                         {System.out.println("Token ID encontrado, lexema " + yytext());
                              VentanaPrincipal.je.append("Token ID encontrado, Lexema "+yytext()+"\n");}

{CONST_BIN}                  {System.out.println("Token CONST_BIN encontrado, lexema " + yytext());
                              VentanaPrincipal.je.append("Token CONST_BIN encontrado, Lexema "+yytext()+"\n");}

{ESPACIO}                    {}

{COMENTARIO_BLOQUE}          {}

{COMENTARIO_LINEA}           {}

{CONST_FLOAT} {
        float valor = Float.parseFloat(yytext());
        if (valor < -3.4028235E38|| valor > 3.4028235E38) {
            throw new Error("Caracter inválido: <" + yytext() + "> en la linea" + yyline + " excede el limite de tamaño");
        } else {

            System.out.println("Token CONST_FLOAT encontrado, lexema " + yytext());
            VentanaPrincipal.je.append("Token CONST_FLOAT encontrado, Lexema "+yytext()+"\n");
        }
}

{CONST_INT} {
        int valor = Integer.parseInt(yytext());
        if (valor < -32768 || valor > 32767) {
            throw new Error("Caracter inválido: <" + yytext() + "> en la linea " + yyline + " excede el limite de tamaño");
        } else {
            System.out.println("Token CONST_INT encontrado, lexema " + yytext());
            VentanaPrincipal.je.append("Token CONST_INT encontrado, Lexema "+yytext()+"\n");
        }
}

{CONST_STR} {
        String value = yytext();
        if (value.length() > 32) {
            throw new Error("Caracter inválido: <" + yytext() + "> en la linea " + yyline + " excede el limite de caracteres");
        } else {
            System.out.println("Token CONST_STR encontrado, lexema " + yytext());
            VentanaPrincipal.je.append("Token CONST_STR encontrado, Lexema "+yytext()+"\n");
        }
    }

}

[^] {     throw new Error("Caracter inválido: <" + yytext() + "> en la linea " + yyline);
      }