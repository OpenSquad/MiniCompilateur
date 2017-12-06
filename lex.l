%{
int nb_ligne=1,nb_colonne=1;

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

ALGORITHME {nb_colonne+=yyleng;return mc_ALGORITHME;}
entier {nb_colonne+=yyleng;yylval.chaine=strdup(yytext); return mc_entier;}
reel  {yylval.chaine=strdup(yytext);nb_colonne+=yyleng; return mc_reel;  }
chaine {yylval.chaine=strdup(yytext);nb_colonne+=yyleng; return mc_chaine;}

VAR {nb_colonne+=yyleng;return mc_VAR;}
DEBUT {nb_colonne+=yyleng; return mc_DEBUT;}
FIN {nb_colonne+=yyleng; return mc_FIN; }

Pour {nb_colonne+=yyleng; return mc_Pour; }
jusque {nb_colonne+=yyleng; return mc_jusque;}
Faire {nb_colonne+=yyleng; return mc_Faire;}
Fait {nb_colonne+=yyleng; return mc_Fait;}
SI {nb_colonne+=yyleng; return mc_SI; }

"<--" {nb_colonne+=yyleng;return op_AFF; }
!=|=|<|>|<=|>= {nb_colonne+=yyleng; return op_comp;}
[+*-/] {yylval.chaine=strdup(yytext); nb_colonne+=yyleng;
		return op_arith; }
\| {nb_colonne+=yyleng; return bar;}


{idf} {if (yyleng >12) printf ("erreur , il faut moins de 12 car") ;
        else {yylval.chaine=strdup(yytext);
		nb_colonne+=yyleng;
        return identificateur;}}
		
{const} {yylval.entier=atoi(yytext); nb_colonne+=yyleng; return constante;}

															
"(" {nb_colonne+=yyleng; return parenthese_gauche;}
")" {nb_colonne+=yyleng; return parenthese_droite;}
"/*"([^*]*("*"+[^*/])*)*"*"+"/" 

[ \t] nb_colonne+=yyleng;
\n {nb_ligne++;nb_colonne=1;}
: {nb_colonne+=yyleng; return dp;}
; {nb_colonne+=yyleng; return pvg;}
"[" {nb_colonne+=yyleng; return crochet_gauche;}
"]" {nb_colonne+=yyleng; return crochet_droit;}

. printf("erreur lexicale a la ligne %d colonne %d\n",nb_ligne,nb_colonne) ;

%%
int yywrap()
{ return 1;}


