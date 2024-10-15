import java.util.*;

// jflex
%%
%class Lexer
%line
%column
%standalone

// Declaration
keyword = "if" | "then"  | "else"  | "endif"  | "while"  | "do"  | "endwhile"  | "print"  | "newline" | "read"
operator = "==" | "++" | "--" | "<=" | ">=" | "+=" | "-=" | "*=" | "/=" | "%=" | "!=" | "&&" | "||" | [+\-*/<>=&|!-]
Identifier = [a-zA-Z][a-zA-Z0-9]* 
parenth = [[\(|\)]]
semicolon = [\;]
string = \"[^\"]*\"   // Regular expression for strings

%{
    private HashSet<String> symbolTable = new HashSet<>();

    public enum Sym {
        keyword,
        operator,
        parenth,
        semicolon,
        string,  // เพิ่ม enum สำหรับ string
        identifier
    }

    // Method for identifier
    public boolean checkSymbolTableAndPut(Token token) {
        if (token.type == Sym.identifier) {
            if (symbolTable.contains(token.value)) {
                logInfo("Identifier \"" + token.value + "\" already exists in the symbol table.");
                return false;
            } else {
                symbolTable.add(token.value);
                logInfo("New identifier added: \"" + token.value + "\"");
                return true;
            }
        }

        logInfo(token.toString());
        return false;
    }

    private void logInfo(String message) {
        System.out.println(message);
    }

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

// Lexer rules
%%
{operator} {
    System.out.println("operator: " + yytext());
    return new Token(Sym.operator, yytext());
}

{keyword} {
    checkSymbolTableAndPut(new Token(Sym.keyword, yytext()));
}

{Identifier} {
    Token token = new Token(Sym.identifier, yytext());
    checkSymbolTableAndPut(token);
    return token;
}

{parenth} {
    checkSymbolTableAndPut(new Token(Sym.parenth, yytext()));
}

{semicolon} {
    checkSymbolTableAndPut(new Token(Sym.semicolon, yytext()));
}

{string} {
    System.out.println("string: " + yytext());
    return new Token(Sym.string, yytext());
}

. {
    System.err.println("Unrecognized character: " + yytext());
    System.exit(1);
}
