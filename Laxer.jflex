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

%{
    private HashSet<String> symbolTable = new HashSet<>();

    public enum Sym {
        keyword,
        operator  // เพิ่ม enum สำหรับตัวดำเนินการ
    }

public void checkSymbolTableAndPut(Token token) {
        if (token.type == Sym.identifier) {
            if (symbolTable.contains(token.value)) {
                System.out.println("Identifier \"" + token.value + "\" already in symbol table");
            } else {
                symbolTable.add(token.value);
                System.out.println("New identifier added: \"" + token.value + "\"");
            }
        }
        System.out.println(token);  
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
}
