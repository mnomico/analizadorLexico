package analizadorLexico;
import java_cup.runtime.*;
import java.util.*;
import java.lang.*;

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
ID = ( {LETRA} | _ ) ( {LETRA} | {DIGITO} )*
CONST_FLOAT = \-?{DIGITO}+\.{DIGITO}+ | \-?\.{DIGITO}+ | \-?{DIGITO}+\.
CONST_INT = \-?{DIGITO}+
CONST_BIN = "0b" (0|1)+
CONST_STR = "\"" (.{0,30}) "\""
COMENTARIO_BLOQUE = "/*" ~ "*/"
COMENTARIO_LINEA = "//" ~[\n]

%%

<YYINITIAL> {

    ":=" {System.out.println("Token ASSIGN encontrado, lexema " + yytext());}

    "+" {System.out.println("Token SUMA encontrado, lexema " + yytext());}

    "-" {System.out.println("Token RESTA encontrado, lexema " + yytext());}

    "*" {System.out.println("Token PRODUCTO encontrado, lexema " + yytext());}

    "/" {System.out.println("Token DIVISIÓN encontrado, lexema " + yytext());}

    ">" {System.out.println("Token MAYOR encontrado, lexema " + yytext());}

    "<" {System.out.println("Token MENOR encontrado, lexema " + yytext());}

    ">=" {System.out.println("Token MAYOR_IGUAL encontrado, lexema " + yytext());}

    "<=" {System.out.println("Token MENOR_IGUAL encontrado, lexema " + yytext());}

    "==" {System.out.println("Token COMPARADOR_IGUAL encontrado, lexema " + yytext());}

    "!" {System.out.println("Token NEGADOR encontrado, lexema " + yytext());}

    "!=" {System.out.println("Token DISTINTO encontrado, lexema " + yytext());}

    "&&" {System.out.println("Token AND encontrado, lexema " + yytext());}

    "||" {System.out.println("Token OR encontrado, lexema " + yytext());}

    ";" {System.out.println("Token END_LINE encontrado, lexema " + yytext());}

    "(" {System.out.println("Token PAR_A encontrado, lexema " + yytext());}

    ")" {System.out.println("Token PAR_C encontrado, lexema " + yytext());}

    "{" {System.out.println("Token COR_A encontrado, lexema " + yytext());}

    "}" {System.out.println("Token COR_C encontrado, lexema " + yytext());}

    "for" {System.out.println("Token FOR encontrado, lexema " + yytext());}

    "while" {System.out.println("Token WHILE encontrado, lexema " + yytext());}

    "if" {System.out.println("Token IF encontrado, lexema " + yytext());}

    "else" {System.out.println("Token ELSE encontrado, lexema " + yytext());}

    "write" {System.out.println("Token WRITE encontrado, lexema " + yytext());}

    "take" {System.out.println("Token TAKE encontrado, lexema " + yytext());}

    {ID} {System.out.println("Token ID encontrado, lexema " + yytext());}

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

    {CONST_BIN} {System.out.println("Token CONST_BIN encontrado, lexema " + yytext());}

    {CONST_STR} {
        String value = yytext();
        if (value.length() > 32) {
            throw new Error("Valor supera cant. máx. de caracteres: " + yytext() + " en linea " + yyline);
        } else {
            System.out.println("Token CONST_STR encontrado, lexema " + yytext());
        }
    }

    {ESPACIO} {}

    {COMENTARIO_BLOQUE} {}

    {COMENTARIO_LINEA} {}

}

[^] { throw new Error("Caracter inválido: <" + yytext() + "> en la linea " + yyline); }