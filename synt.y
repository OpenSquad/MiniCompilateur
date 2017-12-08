%{ 
#include <stdio.h> 
#include <string.h>
int nb_ligne;
int nb_colonne;
char[10] type;
%}

%union {
int entier;
float reel;
char* chaine;}

%token  mc_ALGORITHME mc_entier mc_reel mc_chaine mc_VAR mc_DEBUT mc_FIN mc_Pour mc_jusque mc_Faire mc_Fait mc_SI op_AFF op_comp <chaine>op_arith bar parenthese_gauche parenthese_droite <chaine>identificateur <entier>const_entier <reel>const_reel <chaine>const_chaine dp pvg crochet_gauche crochet_droit 


%%

structure_generale:dec_algo mc_VAR partieDeclaration mc_DEBUT partieInstruction mc_FIN {printf("correcte");}
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
dec_tableau: identificateur crochet_gauche constante crochet_droit dp mc_entier pvg 
	         |identificateur crochet_gauche constante crochet_droit dp mc_reel pvg
			 |identificateur crochet_gauche constante crochet_droit dp mc_chaine pvg
;

dec_var2: mc_entier ListeIDF pvg
		 | mc_reel ListeIDF pvg
		 | mc_chaine ListeIDF pvg
;

dec_var: identificateur dp mc_entier pvg 
	     |identificateur dp mc_reel pvg 
         | identificateur dp mc_chaine pvg 
;


ListeIDF: identificateur bar ListeIDF
			           | identificateur
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

exp_arith: exp_arith op_arith identificateur  { if ( $3==0 && strcmp("/",$2)==0) printf(" erreur : division par zero ligne %d colonne %d \n ",nb_ligne,nb_colonne-1); }
           |exp_arith op_arith const_reel  { if ( $3==0 && strcmp("/",$2)==0) printf(" erreur : division par zero ligne %d colonne %d \n ",nb_ligne,nb_colonne-1); }
		   |exp_arith op_arith const_entier  { if ( $3==0 && strcmp("/",$2)==0) printf(" erreur : division par zero ligne %d colonne %d \n ",nb_ligne,nb_colonne-1); }
		   |identificateur
		   |const_reel
		   |const_entier
;

//----------------constante = entier ou reel -----------------
constante: const_entier
		   | const_reel		   
;



// TESTS 



structure_generale:dec_algo mc_VAR partieDeclaration mc_DEBUT partieInstruction mc_FIN {printf("correcte");}
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
dec_tableau: identificateur crochet_gauche constante crochet_droit dp mc_type pvg  {inserer($6,$1,$3)}
;
dec_var2: mc_type ListeIDF pvg
;
dec_var: identificateur dp mc_type pvg {inserer($3,$1,1);}
;
ListeIDF: identificateur bar ListeIDF {inserer(type,$1,1);}
			           | identificateur {inserer(type,$1,1);}
;

mc_type: mc_entier {type="entier";}
 | mc_reel {type="reel";}
  | mc_chaine {ŧype="chaine";}
					   
//------------------PartieInstruction---------------------
partieInstruction: inst_aff partieInstruction    
					| inst_boucle partieInstruction 
					| inst_cond  partieInstruction
					| inst_aff
					|inst_boucle
					|inst_cond
;					


//-------------------Boucle------------
inst_boucle: mc_Pour identificateur op_AFF constante mc_jusque constante mc_Faire partieInstruction mc_Fait 
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

exp_arith: exp_arith op_arith identificateur  { if ( $3==0 && strcmp("/",$2)==0) printf(" erreur : division par zero ligne %d colonne %d \n ",nb_ligne,nb_colonne-1); }
           |exp_arith op_arith const_reel  { if ( $3==0 && strcmp("/",$2)==0) printf(" erreur : division par zero ligne %d colonne %d \n ",nb_ligne,nb_colonne-1); }
		   |exp_arith op_arith const_entier  { if ( $3==0 && strcmp("/",$2)==0) printf(" erreur : division par zero ligne %d colonne %d \n ",nb_ligne,nb_colonne-1); }
		   |identificateur
		   |const_reel
		   |const_entier
;




// END TESTS










%%
main ()
{
printf("Taper stop pour arreter \n");
yyparse();
}
