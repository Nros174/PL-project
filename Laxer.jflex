import java.util.*;

// jflex
%%
// class name
%class Laxer 
// position error
%line
%column
// run standalone 
%standalone

// Declaration
keyword = "if" | "then"  | "else"  | "endif"  | "while"  | "do"  | "endwhile"  | "print"  | "newline" | "read"
operator = "==" | "++" | "--" | "<=" | ">=" | "+=" | "-=" | "*=" | "/=" | "%=" | "!=" | "&&" | "||" | [+\-*/<>=&|!-]
Identifier = [a-zA-Z][a-zA-Z0-9]* 
parenth = [\(|\)]]
semicolon = [\;]


%{
    private HashSet<String> symbolTable = new HashSet<>();

    public enum Sym {
        keyword,
        operator,
	parenth,
	semicolon  // เพิ่ม enum สำหรับตัวดำเนินการ
    }


//identifier
 public boolean checkSymbolTableAndPut(Token token) {
        if (token.type == Sym.identifier) {
            if (symbolTable.contains(token.value)) {
                logInfo("Identifier \"" + token.value + "\" already exists in the symbol table.");
                return false; // Return false if identifier already exists
            } else {
                symbolTable.add(token.value);
                logInfo("New identifier added: \"" + token.value + "\"");
                return true; // Return true if new identifier is added
            }
        }

        logInfo(token.toString());
        return false;
    }

    private void logInfo(String message) {
        System.out.println(message);
    }
  //identifier

    // Token class to store token type and value
    public class Token {
        public Sym type;
        public String value;

        public Token(Sym type, String value) {
            this.type = type;
            this.value = value;
        }
    }
%}

// Laxer rules
%%
{operator} {
    System.out.println("operator: " + yytext());
    return new Token(Sym.operator, yytext());
}
{keyword} {
    checksymbolTableAndPut(new Token(Sym.keyword, yytext()));
}

{identifier} {
    Token token = new Token(Sym.identifier, yytext());
    checksymbolTableAndPut(token);
    return token;
{parenth} {
	checksymbolTableAndPut(new Token(Sym.parenth, yytext()));
}
{semicolon}{
	checksymbolTableAndPut(new Token(Sym.semicolon, yytext()));

}
