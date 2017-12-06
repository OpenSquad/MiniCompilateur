%{
int nb_ligne=0;
#include "synt.tab.h"
#include <stdio.h> 
#include<string.h>
extern YYSTYPE yylval;
%}

lettre [a-zA-Z]
chiffre [0-9]
idf {lettre}({lettre}|{chiffre})*
const {chiffre}+("."{chiffre}*)?
%%
stop yyterminate();

ALGORITHME return mc_ALGORITHME;
entier|reel|chaine return mc_type;


VAR return mc_VAR;
DEBUT return mc_DEBUT;
FIN return mc_FIN;

Pour return mc_Pour;
jusque return mc_jusque;
Faire return mc_Faire;
Fait return mc_Fait;
SI return mc_SI;

"<--" return op_AFF;
!=|=|<|>|<=|>= return op_comp;
[+*-/] {yylval.chaine=strdup(yytext);
		return op_arith;}
\| return bar;


{idf} {if (yyleng >12) printf ("erreur , il faut moins de 12 car") ;
        else {yylval.chaine=strdup(yytext);
        return identificateur;}}
		
{const} {yylval.entier=atoi(yytext);return constante;}

															
"(" return parenthese_gauche;
")" return parenthese_droite;
"/*"([^*]*("*"+[^*/])*)*"*"+"/" 

[ \t] 
\n {nb_ligne++;}
: return dp;
; return pvg;
"[" return crochet_gauche;
"]" return crochet_droit;

. printf("erreur lexicale à la ligne %d \n",nb_ligne) ;
