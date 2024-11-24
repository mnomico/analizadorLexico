package analizadorLexico;
import java.io.FileNotFoundException;
import java.io.FileReader;


public class Main {
    public static void main(String[] args) throws FileNotFoundException, Exception {
        // VentanaPrincipal ventanaPrincipal = new VentanaPrincipal();
        FileReader f = new FileReader("src/main/java/analizadorLexico/pruebense.txt");
        Lexico Lexer = new Lexico(f);
        parser sintactico = new parser(Lexer);
        sintactico.parse();
    }
}
