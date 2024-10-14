import java.util.*;

//jflex
%%
//class name
%class Laxer 
//position error
%line
%column
//run standalone 
%standalone

// Declaration
keyword = "if" | "then"  | "else"  | "endif"  | "while"  | "do"  | "endwhile"  | "print"  | "newline" | "read"


%{
    private HashSet<String> symbolTable = new HashSet<>();
    public enum Sym{
        keyword
    }
}

//Laxer rules
%%
{keyword}(ckecksymbolTableAndPut(new Token(Sym.keyword,yytext()));)