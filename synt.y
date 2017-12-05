%union {
int entier;
char* str;}

%token  mc_ALGORITHME mc_type mc_VAR mc_DEBUT mc_FIN mc_Pour mc_jusque mc_Faire mc_Fait mc_SI op_AFF op_comp op_arith bar parenthese_gauche parenthese_droite identificateur constante commentaire dp pvg crochet_gauche crochet_droit 


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
dec_tableau: identificateur crochet_gauche constante crochet_droit dp mc_type pvg
;
dec_var2: mc_type ListeIDF pvg 
;
dec_var: identificateur dp mc_type pvg 
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
;



//------------------Expression Arithmetique---------
exp_arith: identificateur op_arith exp_arith 
          |constante   op_arith  exp_arith
		  |constante
		  |identificateur
;



%%
main ()
{
printf("Taper stop pour arreter \n");
yyparse();
}
yywrap()
{
}