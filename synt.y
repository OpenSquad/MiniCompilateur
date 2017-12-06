%{ 
#include <stdio.h> 
#include<string.h>
extern nb_ligne;
extern nb_colonne;
%}

%union {
int entier;
float reel;
char* chaine;}

%token  mc_ALGORITHME mc_entier mc_reel mc_chaine mc_VAR mc_DEBUT mc_FIN mc_Pour mc_jusque mc_Faire mc_Fait mc_SI op_AFF op_comp <chaine>op_arith bar parenthese_gauche parenthese_droite <chaine>identificateur <entier>const_entier <reel>const_reel <chaine>const_chaine dp pvg crochet_gauche crochet_droit 


%%

chaines:const_chaine {printf("juste");}
;




%%
main ()
{
printf("Taper stop pour arreter \n");
yyparse();
}
