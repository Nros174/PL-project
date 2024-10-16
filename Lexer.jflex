import java.util.*;

// jflex
%%
%class Lexer
%line
%column
%standalone

// Declaration
integer = [0-9]+
keyword = "if" | "then"  | "else"  | "endif"  | "while"  | "do"  | "endwhile"  | "print"  | "newline" | "read"
operator = "==" | "++" | "--" | "<=" | ">=" | "+=" | "-=" | "*=" | "/=" | "%=" | "!=" | "&&" | "||" | "+" | "-" | "*" | "/" | "<" | ">" | "=" | "&" | "!"
identifier = [a-zA-Z_][a-zA-Z0-9_]* 
comment = \/\/.*|\/\*[\s\S]*?\*\/
parenth = [\(|\)] | [\{|\}]
semicolon = [\;]
string = \"[^\"]*\"   // Regular expression for strings
space = [ \t\r\n]+
float = [0-9]+\.[0-9]+

%{
    private HashSet<String> symbolTable = new HashSet<>();

    public enum Sym {
        keyword,
        operator,
        identifier,
	    parenth,
	    semicolon,  // เพิ่ม enum สำหรับตัวดำเนินการ
	    integer,
        string,
        space,
        floating
    }

    // Method for identifier
    public void checkSymbolTableAndPut(Token token) {
        if (token.type == Sym.identifier) {
            if (symbolTable.contains(token.value)) {
                logInfo("Identifier \"" + token.value + "\" already exists in the symbol table.");
            } else {
                symbolTable.add(token.value);
                logInfo("New identifier added: \"" + token.value + "\"");
            }
        }
        else{
            logInfo(token.toString());
        }
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

        @Override
        public String toString() {
            return "type= " + type + ", value= " + value;
        }
    }
%}

// Lexer rules
%%
{operator} {
    Token token = new Token(Sym.operator, yytext());
    checkSymbolTableAndPut(token);
}

{keyword} {
    checkSymbolTableAndPut(new Token(Sym.keyword, yytext()));
}

{identifier} {
    Token token = new Token(Sym.identifier, yytext());
    checkSymbolTableAndPut(token);

}
{comment} { /* Ignore */ }
{space} {/*Ignore whitespace*/}
{parenth} {
    checkSymbolTableAndPut(new Token(Sym.parenth, yytext()));
}

{semicolon} {
    checkSymbolTableAndPut(new Token(Sym.semicolon, yytext()));
}

{string} {
    Token token = new Token(Sym.string, yytext());
    checkSymbolTableAndPut(token);
}

{integer} {
    Token token = new Token(Sym.integer, yytext());
    checkSymbolTableAndPut(token);
}

{float} {
    Token token = new Token(Sym.floating, yytext());
    checkSymbolTableAndPut(token);
}

. { 
    System.err.println("Syntax Error: Unexpected character " + yytext());
    System.exit(1); 
}
