%{ 
#include <stdio.h> 
#include<string.h>
#include "ts.h"
extern nb_ligne;
extern nb_colonne;
%}

%union {
int entier;
float reel;
char* chaine;}

%token  mc_ALGORITHME <chaine>mc_entier <chaine>mc_reel <chaine>mc_chaine mc_VAR mc_DEBUT mc_FIN mc_Pour mc_jusque mc_Faire mc_Fait mc_SI op_AFF op_comp <chaine>op_arith bar parenthese_gauche parenthese_droite <chaine>identificateur <entier>const_entier <reel>const_reel <chaine>const_chaine dp pvg crochet_gauche crochet_droit 


%%

structure_generale:dec_algo mc_VAR partieDeclaration mc_DEBUT partieInstruction mc_FIN {printf("----------programme syntaxiquement juste------\n ecrire quelque chose puis appuyer sur entre pour afficher la table des symboles");}
;



//-------------------------declaration de l'algorithme-----------
dec_algo: mc_ALGORITHME identificateur 
;

//-------------Partie Declaration--------------
partieDeclaration: dec_var2 partieDeclaration 
						  | dec_var2	
				  |dec_tableau partieDeclaration
					         | dec_tableau
				  |dec_var partieDeclaration
						 | dec_var
;

//----------------les declarations------------
dec_tableau: identificateur crochet_gauche const_entier crochet_droit dp mc_entier pvg {inserer($1,"entier",1);}
	         |identificateur crochet_gauche const_entier crochet_droit dp mc_reel pvg   {inserer($1,"reel",1);}
			 |identificateur crochet_gauche const_entier crochet_droit dp mc_chaine pvg  {inserer($1,"chaine",1);}
;

dec_var2: mc_entier ListeIDF pvg {inserer($3,"entier",1);}
		 | mc_reel ListeIDF pvg   {inserer($3,"reel",1);}
		 | mc_chaine ListeIDF pvg  {inserer($3,"chaine",1);}
;

dec_var: identificateur dp mc_entier pvg {inserer($1,"entier",1);}
	     |identificateur dp mc_reel pvg  {inserer($1,"reel",1);}
         | identificateur dp mc_chaine pvg {inserer($1,"chaine",1);}
;


ListeIDF: identificateur bar ListeIDF {if(recherche($1)!=-1) printf("-----------ERREUR:semantique - la variable: %s deja declare ligne %d  \n ",$1,nb_ligne,"------------");}
			           | identificateur  {if(recherche($1)!=-1) printf("-----------ERREUR:semantique - la variable: %s deja déclare ligne %d  \n ",$1,nb_ligne,"------------");}
;
					   
//------------------PartieInstruction---------------------
partieInstruction: inst_aff partieInstruction    
					| inst_boucle partieInstruction 
					| inst_cond  partieInstruction
					| inst_aff
					|inst_boucle
					|inst_cond
;					


//-------------------Boucle------------
inst_boucle: mc_Pour identificateur op_AFF identificateur mc_jusque identificateur mc_Faire partieInstruction mc_Fait 
			|mc_Pour identificateur op_AFF constante mc_jusque constante mc_Faire partieInstruction mc_Fait 
			|mc_Pour constante op_AFF constante mc_jusque constante mc_Faire partieInstruction mc_Fait 
			|mc_Pour constante op_AFF identificateur mc_jusque constante mc_Faire partieInstruction mc_Fait 
			;

//------------------Instruction Condition-------------
inst_cond:mc_Faire inst_aff mc_SI parenthese_gauche cond parenthese_droite 
;

//------------------Condition-------------
cond: identificateur op_comp constante 
				             		     
	 | constante op_comp constante					     	 
;


//------------------Instruction Affectation-----------
inst_aff: identificateur op_AFF exp_arith pvg 

exp_arith: exp_arith op_arith identificateur  { if ( $3==0 && strcmp("/",$2)==0) printf("ERREUR SEMANTIQUE : division par zero ligne %d colonne %d \n ",nb_ligne,nb_colonne-1); }
           |exp_arith op_arith const_reel  { if ( $3==0 && strcmp("/",$2)==0) printf(" ERREUR SEMANTIQUE: division par zero ligne %d colonne %d \n ",nb_ligne,nb_colonne-1); }
		   |exp_arith op_arith const_entier  { if ( $3==0 && strcmp("/",$2)==0) printf(" ERREUR SEMANTIQUE: division par zero ligne %d colonne %d \n ",nb_ligne,nb_colonne-1); }
		   |identificateur
		   |const_reel
		   |const_entier
;

//----------------constante = entier ou reel -----------------
constante: const_entier
		   | const_reel		   
;

%%
main ()
{
printf("Taper stop pour arreter \n");
yyparse();
afficher();
system("pause");

}
