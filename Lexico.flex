package analizadorLexico;
import java_cup.runtime.*;
import java.util.*;
import java.lang.*;
import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;
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
/*
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
/*
%}

%%

<YYINITIAL> {

"WHILE"                      {return new Symbol(sym.WHILE,yytext());}

"IF"                         {return new Symbol(sym.IF,yytext());}

"THEN"                       {return new Symbol(sym.THEN,yytext());}

"ELSE"                       {return new Symbol(sym.ELSE,yytext());}

"::="                        {return new Symbol(sym.ASIGN,yytext());}

":="                         {return new Symbol(sym.DECLARA,yytext());}

"+"                          {return new Symbol(sym.OP_SUMA,yytext());}

"*"                          {return new Symbol(sym.OP_POR,yytext());}

"-"                          {return new Symbol(sym.OP_RESTA,yytext());}

"/"                          {return new Symbol(sym.OP_DIVISION,yytext());}

"["                          {return new Symbol(sym.COR_APERTURA,yytext());}

"]"                          {return new Symbol(sym.COR_CIERRE,yytext());}

"WRITE"                      {return new Symbol(sym.WRITE,yytext());}

">"                          {return new Symbol(sym.MAYOR,yytext());}

"<"                          {return new Symbol(sym.MENOR,yytext());}

">="                         {return new Symbol(sym.MAYOR_IGUAL,yytext());}

"<="                         {return new Symbol(sym.MENOR_IGUAL,yytext());}

"=="                         {return new Symbol(sym.IGUAL,yytext());}

"!"                          {return new Symbol(sym.NEGACION,yytext());}

"!="                         {return new Symbol(sym.DISTINTO,yytext());}

"&&"                         {return new Symbol(sym.AND,yytext());}

"("                          {return new Symbol(sym.PAR_APERTURA,yytext());}

")"                          {return new Symbol(sym.PAR_CIERRE,yytext());}

"||"                         {return new Symbol(sym.OR,yytext());}

"DECLARE.SECTION"            {return new Symbol(sym.DECLARE_SECTION,yytext());}

"ENDDECLARE.SECTION"         {return new Symbol(sym.ENDDECLARE_SECTION,yytext());}

"PROGRAM.SECTION"            {return new Symbol(sym.PROGRAM_SECTION,yytext());}

"ENDPROGRAM.SECTION"         {return new Symbol(sym.ENDPROGRAM_SECTION,yytext());}

";"                          {return new Symbol(sym.END_LINE,yytext());}

","                          {return new Symbol(sym.SEP_LIST,yytext());}

"INT"                        {return new Symbol(sym.TIPO_INT,yytext());}

"FLOAT"                      {return new Symbol(sym.TIPO_FLOAT,yytext());}

"STRING"                     {return new Symbol(sym.TIPO_STRING,yytext());}

"TAKE"                       {return new Symbol(sym.TAKE,yytext());}

{ID} {
    /*
    String id = yytext();
    boolean existe = false;

    for (String[] simbolo : tabla_de_simbolos) {
        if (simbolo[0].equals(id)) {
            existe = true;
            break;
        }
    }

    if (!existe) {
        String[] simbolo = {id, "ID", "_", "_", "_"};
        tabla_de_simbolos.add(simbolo);
    }
    guardarTablaSimbolos();
    */

    return new Symbol(sym.ID,yytext());
}

{CONST_BIN}                  {return new Symbol(sym.CONST_BIN,yytext());}

{ESPACIO}                    {}

{COMENTARIO_BLOQUE}          {}

{COMENTARIO_LINEA}           {}

{CONST_FLOAT} {
    float valor = Float.parseFloat(yytext());
    if (valor < -3.4028235E38 || valor > 3.4028235E38) {
        throw new Error("Caracter inválido: <" + yytext() + "> en la linea " + yyline + " excede el limite de tamaño");
    } else {
        /*
        String[] simbolo = {"_" + yytext(), "CONST_FLOAT", "_", yytext(), "_"};
        tabla_de_simbolos.add(simbolo);
        guardarTablaSimbolos();
        */
        return new Symbol(sym.CONST_FLOAT,yytext());
    }
}

{CONST_INT} {
    int valor = Integer.parseInt(yytext());
    if (valor < -32768 || valor > 32767) {
        throw new Error("Caracter inválido: <" + yytext() + "> en la linea " + yyline + " excede el limite de tamaño");
    } else {
        /*
        String[] simbolo = {"_" + yytext(), "CONST_INT", "_", yytext(), "_"};
        tabla_de_simbolos.add(simbolo);
        guardarTablaSimbolos();
        */
        return new Symbol(sym.CONST_INT,yytext());
    }
}

{CONST_STR} {
    String value = yytext();
    if (value.length() > 32) {
        throw new Error("Caracter inválido: <" + yytext() + "> en la linea " + yyline + " excede el limite de caracteres");
    } else {
        /*
        String[] simbolo = {"_" + yytext(), "CONST_STR", "_", yytext(), String.valueOf(value.length())};
        tabla_de_simbolos.add(simbolo);
        guardarTablaSimbolos();
        */
        return new Symbol(sym.CONST_STR,yytext());
    }
}

}

[^] {     throw new Error("Caracter inválido: <" + yytext() + "> en la linea " + yyline);
      }