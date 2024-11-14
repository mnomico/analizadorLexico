package analizadorLexico;
import java_cup.runtime.*;
import java.util.*;
import java.lang.*;
import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;
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
ID = ( {LETRA} | _ ({DIGITO} | {LETRA}) ) ( {LETRA} | {DIGITO} | _ ({LETRA} | {DIGITO}) )*
CONST_FLOAT = \-?{DIGITO}+\.{DIGITO}+ | \-?\.{DIGITO}+ | \-?{DIGITO}+\.
CONST_INT = \-?{DIGITO}+
CONST_BIN = (0b).(0|1)+
CONST_STR = \" (.{0,30}) \"
COMENTARIO_BLOQUE = "//*"([^*]|"*"+[^/])*"*//"
COMENTARIO_LINEA = "//" ~[\n]

%{

    List<String[]> tabla_de_simbolos = new ArrayList<>();

void guardarTablaSimbolos() {
    try (BufferedWriter writer = new BufferedWriter(new FileWriter("tabla_de_simbolos.txt"))) {
        // Columnas
        writer.write(String.format("%-50s %-15s %-20s %-50s %-5s", "Nombre", "Token", "Tipo", "Valor", "Long"));
        writer.newLine();
        writer.write("--------------------------------------------------------------------------------------------------------------------------------------------------------");
        writer.newLine();

        // Filas
        for (String[] simbolo : tabla_de_simbolos) {
            writer.write(String.format("%-50s %-15s %-20s %-50s %-5s", simbolo[0], simbolo[1], simbolo[2], simbolo[3], simbolo[4]));
            writer.newLine();
        }

    } catch (IOException e) {
        System.err.println("Error al escribir la tabla de símbolos en el archivo: " + e.getMessage());
    }
}

%}

%%

<YYINITIAL> {

"WHILE"                      {VentanaPrincipal.je.append("Token WHILE encontrado, Lexema "+yytext());}

"IF"                         {VentanaPrincipal.je.append("Token IF encontrado, Lexema "+yytext()+ "\n"); }

"THEN"                       {VentanaPrincipal.je.append("Token THEN encontrado, Lexema "+yytext()+"\n");}

"ELSE"                       {VentanaPrincipal.je.append("Token ELSE encontrado, Lexema "+yytext()+"\n");}

"::="                        {VentanaPrincipal.je.append("Token ASIGN encontrado, Lexema "+yytext()+"\n");}

":="                         {VentanaPrincipal.je.append("Token DECLARA encontrado, Lexema "+yytext()+"\n");}

"+"                          {VentanaPrincipal.je.append("Token SUMA encontrado, Lexema "+yytext()+"\n");}

"*"                          {VentanaPrincipal.je.append("Token MULTIPLICACION encontrado, Lexema "+yytext()+"\n");}

"-"                          {VentanaPrincipal.je.append("Token RESTA encontrado, Lexema "+yytext()+"\n");}

"/"                          {VentanaPrincipal.je.append("Token DIVISION encontrado, Lexema "+yytext()+"\n");}

"["                          {VentanaPrincipal.je.append("Token APERTURA encontrado, Lexema "+yytext()+"\n");}

"]"                          {VentanaPrincipal.je.append("Token CIERRE encontrado, Lexema "+yytext()+"\n");}

"WRITE"                      {VentanaPrincipal.je.append("Token WRITE encontrado, Lexema "+yytext()+"\n");}

">"                          {VentanaPrincipal.je.append("Token MAYOR encontrado, Lexema "+yytext()+"\n");}

"<"                          {VentanaPrincipal.je.append("Token MENOR encontrado, Lexema "+yytext()+"\n");}

">="                         {VentanaPrincipal.je.append("Token MAYOR_IGUAL encontrado, Lexema "+yytext()+"\n");}

"<="                         {VentanaPrincipal.je.append("Token MENOR_IGUAL encontrado, Lexema "+yytext()+"\n");}

"=="                         {VentanaPrincipal.je.append("Token COMPARAR_IGUAL encontrado, Lexema "+yytext()+"\n");}

"!"                          {VentanaPrincipal.je.append("Token NEGACION encontrado, Lexema "+yytext()+"\n");}

"!="                         {VentanaPrincipal.je.append("Token DISTINTO encontrado, Lexema "+yytext()+"\n");}

"&&"                         {VentanaPrincipal.je.append("Token AND encontrado, Lexema "+yytext()+"\n");}

"("                          {VentanaPrincipal.je.append("Token ABRIR_PARENTESIS encontrado, Lexema "+yytext()+"\n");}

")"                          {VentanaPrincipal.je.append("Token CERRAR_PARENTESIS encontrado, Lexema "+yytext()+"\n");}

"||"                         {VentanaPrincipal.je.append("Token OR encontrado, Lexema "+yytext()+"\n");}

"DECLARE.SECTION"            {VentanaPrincipal.je.append("Token DECLARE_SECTION encontrado, Lexema "+yytext()+"\n");}

"ENDDECLARE.SECTION"         {VentanaPrincipal.je.append("Token ENDDECLARE_SECTION encontrado, Lexema "+yytext()+"\n");}

"PROGRAM.SECTION"            {VentanaPrincipal.je.append("Token PROGRAM.SECTION encontrado, Lexema "+yytext()+"\n");}

"ENDPROGRAM.SECTION"         {VentanaPrincipal.je.append("Token ENDPROGRAM.SECTION encontrado, Lexema "+yytext()+"\n");}

";"                          {VentanaPrincipal.je.append("Token TERMINACION_LINEA encontrado, Lexema "+yytext()+"\n");}

","                          {VentanaPrincipal.je.append("Token SEP_LISTA encontrado, Lexema "+yytext()+"\n");}

"INT"                        {VentanaPrincipal.je.append("Token TIPO_INT encontrado, Lexema "+yytext()+"\n");}

"FLOAT"                      {VentanaPrincipal.je.append("Token TIPO_FLOAT encontrado, Lexema "+yytext()+"\n");}

"STRING"                     {VentanaPrincipal.je.append("Token TIPO_STRING encontrado, Lexema "+yytext()+"\n");}

"TAKE"                       {VentanaPrincipal.je.append("Token TAKE encontrado, Lexema "+yytext()+"\n");}

{ID} {
    String[] simbolo = {yytext(), "ID", "_", "_", "_"};
    tabla_de_simbolos.add(simbolo);
    VentanaPrincipal.je.append("Token ID encontrado, Lexema "+yytext()+"\n");

    guardarTablaSimbolos();
}

{CONST_BIN}                  {VentanaPrincipal.je.append("Token CONST_BIN encontrado, Lexema "+yytext()+"\n");}

{ESPACIO}                    {}

{COMENTARIO_BLOQUE}          {}

{COMENTARIO_LINEA}           {}

{CONST_FLOAT} {
    float valor = Float.parseFloat(yytext());
    if (valor < -3.4028235E38 || valor > 3.4028235E38) {
        throw new Error("Caracter inválido: <" + yytext() + "> en la linea " + yyline + " excede el limite de tamaño");
    } else {
        String[] simbolo = {"_" + yytext(), "CONST_FLOAT", "_", yytext(), "_"};
        tabla_de_simbolos.add(simbolo);
        VentanaPrincipal.je.append("Token CONST_FLOAT encontrado, Lexema "+yytext()+"\n");
        guardarTablaSimbolos();
    }
}

{CONST_INT} {
    int valor = Integer.parseInt(yytext());
    if (valor < -32768 || valor > 32767) {
        throw new Error("Caracter inválido: <" + yytext() + "> en la linea " + yyline + " excede el limite de tamaño");
    } else {
        String[] simbolo = {"_" + yytext(), "CONST_INT", "_", yytext(), "_"};
        tabla_de_simbolos.add(simbolo);
        VentanaPrincipal.je.append("Token CONST_INT encontrado, Lexema "+yytext()+"\n");
        guardarTablaSimbolos();
    }
}

{CONST_STR} {
    String value = yytext();
    if (value.length() > 32) {
        throw new Error("Caracter inválido: <" + yytext() + "> en la linea " + yyline + " excede el limite de caracteres");
    } else {
        String[] simbolo = {"_" + yytext(), "CONST_STR", "_", yytext(), String.valueOf(value.length())};
        tabla_de_simbolos.add(simbolo);
        VentanaPrincipal.je.append("Token CONST_STR encontrado, Lexema "+yytext()+"\n");
        guardarTablaSimbolos();
    }
}

}

[^] {     throw new Error("Caracter inválido: <" + yytext() + "> en la linea " + yyline);
      }