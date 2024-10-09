package analizadorLexico;
import java_cup.runtime.*;
import java.util.*;
import java.lang.*;
import jflex.core.sym;

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

"WHILE"                      {System.out.println("Token WHILE encontrado, Lexema "+ yytext());}

"IF"                         {System.out.println("Token IF encontrado, Lexema "+ yytext());}

"THEN"                       {System.out.println("Token THEN encontrado, Lexema "+ yytext());}

"ELSE"                       {System.out.println("Token ELSE encontrado, Lexema "+ yytext());}

"::="                        {System.out.println("Token ASIGN encontrado, Lexema "+ yytext());}

":="                         {System.out.println("Token DECLARA encontrado, Lexema "+ yytext());}

"+"                          {System.out.println("Token SUMA encontrado, Lexema "+ yytext());}

"*"                          {System.out.println("Token MULTIPLICACION encontrado, Lexema "+ yytext());}

"-"                          {System.out.println("Token RESTA encontrado, Lexema "+ yytext());}

"/"                          {System.out.println("Token DIVISION encontrado, Lexema "+ yytext());}

"["                          {System.out.println("Token APERTURA encontrado, Lexema "+ yytext());}

"]"                          {System.out.println("Token CIERRE encontrado, Lexema "+ yytext());}

"WRITE"                      {System.out.println("Token WRITE encontrado, Lexema "+ yytext());}

">"                          {System.out.println("Token MAYOR encontrado, Lexema "+ yytext());}

"<"                          {System.out.println("Token MENOR encontrado, Lexema "+ yytext());}

">="                         {System.out.println("Token MAYOR_IGUAL encontrado, Lexema "+ yytext());}

"<="                         {System.out.println("Token MENOR_IGUAL encontrado, Lexema "+ yytext());}

"=="                         {System.out.println("Token COMPARAR_IGUAL encontrado, Lexema "+ yytext());}

"!"                          {System.out.println("Token NEGACION encontrado, Lexema "+ yytext());}

"!="                         {System.out.println("Token DISTINTO encontrado, Lexema "+ yytext());}

"&&"                         {System.out.println("Token AND encontrado, Lexema "+ yytext());}

"("                          {System.out.println("Token ABRIR_PARENTESIS encontrado, Lexema "+ yytext());}

")"                          {System.out.println("Token CERRAR_PARENTESIS encontrado, Lexema "+ yytext());}

"||"                         {System.out.println("Token OR encontrado, Lexema "+ yytext());}

"DECLARE.SECTION"            {System.out.println("Token DECLARE_SECTION encontrado, Lexema "+ yytext());}

"ENDDECLARE.SECTION"         {System.out.println("Token ENDDECLARE_SECTION encontrado, Lexema "+ yytext());}

"PROGRAM.SECTION"            {System.out.println("Token PROGRAM.SECTION encontrado, Lexema "+ yytext());}

"ENDPROGRAM.SECTION"         {System.out.println("Token ENDPROGRAM.SECTION  encontrado, Lexema "+ yytext());}

";"                          {System.out.println("Token TERMINACION_LINEA encontrado, Lexema "+ yytext());}

","                          {System.out.println("Token SEP_LISTA encontrado, Lexema "+ yytext());}

"INT"                        {System.out.println("Token TIPO_INT encontrado, Lexema "+ yytext());}

"FLOAT"                      {System.out.println("Token TIPO_FLOAT encontrado, Lexema "+ yytext());}

"STRING"                     {System.out.println("Token TIPO_STRING encontrado, Lexema "+ yytext());}

"TAKE"                       {System.out.println("Token TAKE encontrado, Lexema "+ yytext());}

{ID}                         {System.out.println("Token ID encontrado, lexema " + yytext());}

{CONST_BIN}                  {System.out.println("Token CONST_BIN encontrado, lexema " + yytext());}

{ESPACIO}                    {}

{COMENTARIO_BLOQUE}          {}

{COMENTARIO_LINEA}           {}

{CONST_FLOAT} {
        float valor = Float.parseFloat(yytext());
        if (valor < -3.4028235E38|| valor > 3.4028235E38) {
            throw new Error("Valor fuera del rango de 32 bits: " + yytext() + " en linea " + yyline);
        } else {
            System.out.println("Token CONST_FLOAT encontrado, lexema " + yytext());
        }
}

{CONST_INT} {
        int valor = Integer.parseInt(yytext());
        if (valor < -32768 || valor > 32767) {
            throw new Error("Valor fuera del rango de 16 bits: " + yytext() + " en linea " + yyline);
        } else {
            System.out.println("Token CONST_INT encontrado, lexema " + yytext());
        }
}

{CONST_STR} {
        String value = yytext();
        if (value.length() > 32) {
            throw new Error("Valor supera cant. máx. de caracteres: " + yytext() + " en linea " + yyline);
        } else {
            System.out.println("Token CONST_STR encontrado, lexema " + yytext());
        }
    }

}

[^] { throw new Error("Caracter inválido: <" + yytext() + "> en la linea " + yyline); }