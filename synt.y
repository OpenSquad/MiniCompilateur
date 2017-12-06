%{ 
#include <stdio.h> 
#include<string.h>
extern nb_ligne;
extern nb_colonne;
%}

%union {
int entier;
char* chaine;}

%token  mc_ALGORITHME mc_entier mc_reel mc_chaine mc_VAR mc_DEBUT mc_FIN mc_Pour mc_jusque mc_Faire mc_Fait mc_SI op_AFF op_comp <chaine>op_arith bar parenthese_gauche parenthese_droite <chaine>identificateur <entier>constante commentaire dp pvg crochet_gauche crochet_droit 


%%


exp_arith: exp_arith op_arith identificateur  { if ( $3==0 && strcmp("/",$2)==0) printf(" erreur : division par zero ligne %d colonne %d \n ",nb_ligne,nb_colonne-1); }
               |exp_arith  op_arith  constante   { if ( $3==0 && strcmp("/",$2)==0) printf(" erreur : division par zero ligne %d colonne %d \n",nb_ligne,nb_colonne-1);}
			   |constante 
 			   |identificateur 
;





%%
main ()
{
printf("Taper stop pour arreter \n");
yyparse();
}
