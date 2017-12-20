%{
int nb_ligne=1,nb_colonne=1;
int taille=0;
#include "synt.tab.h"
#include <stdio.h> 
#include<string.h>
extern YYSTYPE yylval;
%}

lettre [a-zA-Z]
chiffre [0-9]
idf {lettre}({lettre}|{chiffre})*
constReel {chiffre}+"."{chiffre}+
constEntier [0-9]*
constChaine \"([^\"]*)*\" 

%%
stop yyterminate();

ALGORITHME {taille=yyleng;nb_colonne+=yyleng;return mc_ALGORITHME;}
entier {yylval.chaine=strdup(yytext);taille=yyleng;nb_colonne+=yyleng; return mc_entier;}
reel  {yylval.chaine=strdup(yytext);taille=yyleng;nb_colonne+=yyleng; return mc_reel;  }
chaine {yylval.chaine=strdup(yytext);taille=yyleng;nb_colonne+=yyleng; return mc_chaine;}

VAR {taille=yyleng;nb_colonne+=yyleng;return mc_VAR;}
DEBUT {taille=yyleng;nb_colonne+=yyleng; return mc_DEBUT;}
FIN {taille=yyleng;nb_colonne+=yyleng; return mc_FIN; }

Pour {taille=yyleng;nb_colonne+=yyleng; return mc_Pour; }
jusque {taille=yyleng;nb_colonne+=yyleng; return mc_jusque;}
Faire {taille=yyleng;nb_colonne+=yyleng; return mc_Faire;}
Fait {taille=yyleng;nb_colonne+=yyleng; return mc_Fait;}
SI {taille=yyleng;nb_colonne+=yyleng; return mc_SI; }

"<--" {taille=yyleng;nb_colonne+=yyleng;return op_AFF; }
!=|=|<|>|<=|>= {taille=yyleng;yylval.chaine=strdup(yytext);nb_colonne+=yyleng; return op_comp;}
[+*-/] {taille=yyleng;yylval.chaine=strdup(yytext); nb_colonne+=yyleng;return op_arith; }
\| {taille=yyleng;nb_colonne+=yyleng; return bar;}


{idf} {if (yyleng >12) printf ("erreur , il faut moins de 12 car") ;
        else {taille=yyleng;yylval.chaine=strdup(yytext);	nb_colonne+=yyleng; return identificateur;}}
		
{constEntier} {if(atoi(yytext)>32767 || atoi(yytext)<-32768){printf("Dépassement de valeur maximale ,doit etre entre 32767 et -32768.\n ");} else taille=yyleng;yylval.entier=atoi(yytext); nb_colonne+=yyleng; return const_entier;}
{constReel} {if(atof(yytext)>32767 || atof(yytext)<-32768){printf("Dépassement de valeur maximale ,doit etre entre 32767 et -32768.\n ");} else taille=yyleng;yylval.reel=atof(yytext); nb_colonne+=yyleng; return const_reel;}
{constChaine} {taille=yyleng;yylval.chaine=strdup(yytext); nb_colonne+=yyleng; return const_chaine;}
	
"(" {taille=yyleng;nb_colonne+=yyleng; return parenthese_gauche;}
")" {taille=yyleng;nb_colonne+=yyleng; return parenthese_droite;}
"/*"([^*]*("*"+[^*/])*)*"*"+"/" {taille=yyleng;nb_colonne+=yyleng;}
"//"(.)* 

[ \t] {taille=yyleng;nb_colonne+=yyleng;}
\n {nb_ligne++;nb_colonne=1;taille=0;}
: {taille=yyleng;nb_colonne+=yyleng; return dp;}
; {taille=yyleng;nb_colonne+=yyleng; return pvg;}
"[" {taille=yyleng;nb_colonne+=yyleng; return crochet_gauche;}
"]" {taille=yyleng;nb_colonne+=yyleng; return crochet_droit;}

. printf("erreur lexicale a la ligne %d colonne %d\n",nb_ligne,nb_colonne) ;

%%
int yywrap()
{ return 1;}


