%error-verbose
%{ 
#include <stdio.h> 
#include<string.h>
#include "ts.h"
#include "quad.h"
extern nb_ligne;
extern nb_colonne;
extern yytext;
extern taille;
int t=0; // Compteur des états temporaires
int qc=0;
char tmp[20],tmp2[20],tmp3[20],type[20],tmp4[20],tmp6[20],tmp7[20];
int x=0;
int jump=0;
int sauv_cond=0,sauv_inst=0,sauv_fin;

%}

%union {
int entier;
float reel;
char* chaine;}

%token  mc_ALGORITHME <chaine>mc_entier <chaine>mc_reel <chaine>mc_chaine mc_VAR mc_DEBUT mc_FIN mc_Pour mc_jusque mc_Faire mc_Fait mc_SI op_AFF <chaine>op_comp <chaine>op_arith bar parenthese_gauche parenthese_droite <chaine>identificateur <entier>const_entier <reel>const_reel <chaine>const_chaine dp pvg crochet_gauche crochet_droit  


%%

structure_generale:dec_algo mc_VAR partieDeclaration mc_DEBUT partieInstruction mc_FIN {printf("----------programme syntaxiquement juste------\n ecrire quelque chose puis appuyer sur entre pour afficher la table des symboles et des quadruplets");}
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
dec_tableau: identificateur crochet_gauche const_entier crochet_droit dp mc_entier pvg {inserer($1,"entier",$3);}
	         |identificateur crochet_gauche const_entier crochet_droit dp mc_reel pvg   {inserer($1,"reel",$3);}
			 |identificateur crochet_gauche const_entier crochet_droit dp mc_chaine pvg  {inserer($1,"chaine",$3);}
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

inst_cond:B mc_SI parenthese_gauche identificateur op_comp const_entier  parenthese_droite{sprintf(tmp4,"quadr N %d",sauv_inst);sprintf(tmp,"%d",$6);
if (strcmp($5,"=")==0) strcpy(tmp6,"BE");if (strcmp($5,"<")==0) strcpy(tmp6,"BL");if (strcmp($5,">")==0) strcpy(tmp6,"BG");if (strcmp($5,"<=")==0) strcpy(tmp6,"BLE");if (strcmp($5,">=")==0) strcpy(tmp6,"BGE");if (strcmp($5,"!=")==0) strcpy(tmp6,"BNE"); quadr(tmp6,tmp4,$4,tmp);t++;sprintf(tmp4,"quadr N %d",t);ajour_quad(sauv_fin,1,tmp4);}
		  |B mc_SI parenthese_gauche identificateur op_comp const_reel  parenthese_droite{sprintf(tmp4,"quadr N %d",sauv_inst);sprintf(tmp,"%.2f",$6);
if (strcmp($5,"=")==0) strcpy(tmp6,"BE");if (strcmp($5,"<")==0) strcpy(tmp6,"BL");if (strcmp($5,">")==0) strcpy(tmp6,"BG");if (strcmp($5,"<=")==0) strcpy(tmp6,"BLE");if (strcmp($5,">=")==0) strcpy(tmp6,"BGE");if (strcmp($5,"!=")==0) strcpy(tmp6,"BNE"); quadr(tmp6,tmp4,$4,tmp);t++;sprintf(tmp4,"quadr N %d",t);ajour_quad(sauv_fin,1,tmp4);}
		  |B mc_SI parenthese_gauche identificateur op_comp identificateur  parenthese_droite{sprintf(tmp4,"quadr N %d",sauv_inst);sprintf(tmp,"%s",$6);
if (strcmp($5,"=")==0) strcpy(tmp6,"BE");if (strcmp($5,"<")==0) strcpy(tmp6,"BL");if (strcmp($5,">")==0) strcpy(tmp6,"BG");if (strcmp($5,"<=")==0) strcpy(tmp6,"BLE");if (strcmp($5,">=")==0) strcpy(tmp6,"BGE");if (strcmp($5,"!=")==0) strcpy(tmp6,"BNE"); quadr(tmp6,tmp4,$4,tmp);t++;sprintf(tmp4,"quadr N %d",t);ajour_quad(sauv_fin,1,tmp4);}
		  |B mc_SI parenthese_gauche const_entier op_comp identificateur  parenthese_droite{sprintf(tmp4,"quadr N %d",sauv_inst);sprintf(tmp,"%s",$6);sprintf(tmp7,"%d",$4);
if (strcmp($5,"=")==0) strcpy(tmp6,"BE");if (strcmp($5,"<")==0) strcpy(tmp6,"BL");if (strcmp($5,">")==0) strcpy(tmp6,"BG");if (strcmp($5,"<=")==0) strcpy(tmp6,"BLE");if (strcmp($5,">=")==0) strcpy(tmp6,"BGE");if (strcmp($5,"!=")==0) strcpy(tmp6,"BNE"); quadr(tmp6,tmp4,tmp7,tmp);t++;sprintf(tmp4,"quadr N %d",t);ajour_quad(sauv_fin,1,tmp4);}
		  |B mc_SI parenthese_gauche const_entier op_comp const_reel  parenthese_droite{sprintf(tmp4,"quadr N %d",sauv_inst);sprintf(tmp,"%.2f",$6);sprintf(tmp7,"%d",$4);
if (strcmp($5,"=")==0) strcpy(tmp6,"BE");if (strcmp($5,"<")==0) strcpy(tmp6,"BL");if (strcmp($5,">")==0) strcpy(tmp6,"BG");if (strcmp($5,"<=")==0) strcpy(tmp6,"BLE");if (strcmp($5,">=")==0) strcpy(tmp6,"BGE");if (strcmp($5,"!=")==0) strcpy(tmp6,"BNE"); quadr(tmp6,tmp4,tmp7,tmp);t++;sprintf(tmp4,"quadr N %d",t);ajour_quad(sauv_fin,1,tmp4);}
		  |B mc_SI parenthese_gauche const_entier op_comp const_entier  parenthese_droite{sprintf(tmp4,"quadr N %d",sauv_inst);sprintf(tmp,"%d",$6);sprintf(tmp7,"%d",$4);
if (strcmp($5,"=")==0) strcpy(tmp6,"BE");if (strcmp($5,"<")==0) strcpy(tmp6,"BL");if (strcmp($5,">")==0) strcpy(tmp6,"BG");if (strcmp($5,"<=")==0) strcpy(tmp6,"BLE");if (strcmp($5,">=")==0) strcpy(tmp6,"BGE");if (strcmp($5,"!=")==0) strcpy(tmp6,"BNE"); quadr(tmp6,tmp4,tmp7,tmp);t++;sprintf(tmp4,"quadr N %d",t);ajour_quad(sauv_fin,1,tmp4);}
		  |B mc_SI parenthese_gauche const_reel op_comp const_entier  parenthese_droite{sprintf(tmp4,"quadr N %d",sauv_inst);sprintf(tmp,"%d",$6);sprintf(tmp7,"%.2f",$4);
if (strcmp($5,"=")==0) strcpy(tmp6,"BE");if (strcmp($5,"<")==0) strcpy(tmp6,"BL");if (strcmp($5,">")==0) strcpy(tmp6,"BG");if (strcmp($5,"<=")==0) strcpy(tmp6,"BLE");if (strcmp($5,">=")==0) strcpy(tmp6,"BGE");if (strcmp($5,"!=")==0) strcpy(tmp6,"BNE"); quadr(tmp6,tmp4,tmp7,tmp);t++;sprintf(tmp4,"quadr N %d",t);ajour_quad(sauv_fin,1,tmp4);}
		  |B mc_SI parenthese_gauche const_reel op_comp identificateur parenthese_droite{sprintf(tmp4,"quadr N %d",sauv_inst);sprintf(tmp,"%s",$6);sprintf(tmp7,"%.2f",$4);
if (strcmp($5,"=")==0) strcpy(tmp6,"BE");if (strcmp($5,"<")==0) strcpy(tmp6,"BL");if (strcmp($5,">")==0) strcpy(tmp6,"BG");if (strcmp($5,"<=")==0) strcpy(tmp6,"BLE");if (strcmp($5,">=")==0) strcpy(tmp6,"BGE");if (strcmp($5,"!=")==0) strcpy(tmp6,"BNE"); quadr(tmp6,tmp4,tmp7,tmp);t++;sprintf(tmp4,"quadr N %d",t);ajour_quad(sauv_fin,1,tmp4);}
		  |B mc_SI parenthese_gauche const_reel op_comp const_reel  parenthese_droite{sprintf(tmp4,"quadr N %d",sauv_inst);sprintf(tmp,"%.2f",$6);sprintf(tmp7,"%.2f",$4);
if (strcmp($5,"=")==0) strcpy(tmp6,"BE");if (strcmp($5,"<")==0) strcpy(tmp6,"BL");if (strcmp($5,">")==0) strcpy(tmp6,"BG");if (strcmp($5,"<=")==0) strcpy(tmp6,"BLE");if (strcmp($5,">=")==0) strcpy(tmp6,"BGE");if (strcmp($5,"!=")==0) strcpy(tmp6,"BNE"); quadr(tmp6,tmp4,tmp7,tmp);t++;sprintf(tmp4,"quadr N %d",t);ajour_quad(sauv_fin,1,tmp4);}

;
B :A inst_aff {quadr("BR"," "," "," "); sauv_fin=t;t++;sprintf(tmp4,"quadr N %d",t);ajour_quad(sauv_cond,1,tmp4);}
;
A:mc_Faire {sauv_cond=t;quadr("BR"," ","  "," ");t++;sauv_inst=t;}
;



 



//------------------Instruction Affectation-----------
// on peut affecter un entier  à un reel ex: a<--5; ça devient a=5.0 , c'est pour ça qu'on a rajouté des conditions dans la ligne juste en dessous

inst_aff: identificateur op_AFF exp_arith pvg { if(recherche($1)==-1){printf("Variable %s non declaree(utilisee a la ligne %d).\n",$1,nb_ligne-1);YYABORT;} else   if(strcmp(ts[recherche($1)].TypeEntite,type)!=0 && !(strcmp(ts[recherche($1)].TypeEntite,"reel")==0 && strcmp(type,"entier")==0)) {printf("-----------ERREUR SEMANTIQUE de type d'affectation ! LIGNE : %d . La variable: %s declare commme %s  \n ",nb_ligne,$1,ts[recherche($1)].TypeEntite);}
			else {quadr(":=",tmp2," ",$1);t++;}}
	      |identificateur op_AFF const_chaine pvg {if(recherche($1)==-1){printf("Variable %s non declaree(utilisee a la ligne %d ).\n",$1,nb_ligne-1);YYABORT;} else strcpy(type,"chaine");if(strcmp(ts[recherche($1)].TypeEntite,type)!=0) {printf("-----------ERREUR SEMANTIQUE de type d'affectation ! LIGNE : %d . La variable: %s declare commme %s  \n ",nb_ligne,$1,ts[recherche($1)].TypeEntite);}
			else {quadr(":=",$3," ",$1);t++;}}
		  | identificateur crochet_gauche const_entier crochet_droit op_AFF exp_arith pvg {if(recherche($1)==-1){printf("Variable %s non declaree(utilisee a la ligne %d).\n",$1,nb_ligne-1);YYABORT;} else if(strcmp(ts[recherche($1)].TypeEntite,type)!=0 && !(strcmp(ts[recherche($1)].TypeEntite,"reel")==0 && strcmp(type,"entier")==0)) {printf("-----------ERREUR SEMANTIQUE de type d'affectation ! LIGNE : %d . La variable: %s declare commme %s  \n ",nb_ligne,$1,ts[recherche($1)].TypeEntite);}
			else if($3>ts[recherche($1)].TailleEntite-1){printf("Dépassement de la taille du tableau %s qui est de :  %d",$1,ts[recherche($1)].TailleEntite);} 
			else {quadr(":=",tmp2,"  ",$1);t++;} }	
; 
exp_arith: exp_arith op_arith identificateur  { if( $3==0 && strcmp("/",$2)==0) {printf("ERREUR SEMANTIQUE : division par zero ligne %d colonne %d \n ",nb_ligne,nb_colonne-1);} 
			else {sprintf(tmp,"%s",$3);sprintf(tmp3,"T%d",t);quadr($2,tmp2,tmp,tmp3);sprintf(tmp2,"T%d",t);t=t+1;}}
           |exp_arith op_arith const_reel  { if($3==0 && strcmp("/",$2)==0){printf(" ERREUR SEMANTIQUE: division par zero ligne %d colonne %d \n ",nb_ligne,nb_colonne-1);}
            else{sprintf(tmp,"%.2f",$3);sprintf(tmp3,"T%d",t);quadr($2,tmp2,tmp,tmp3);sprintf(tmp2,"T%d",t);t=t+1;}}
		   |exp_arith op_arith const_entier  { if ( $3==0 && strcmp("/",$2)==0) {printf(" ERREUR SEMANTIQUE: division par zero ligne %d colonne %d \n ",nb_ligne,nb_colonne-1);}
		   else {sprintf(tmp,"%d",$3);sprintf(tmp3,"T%d",t);quadr($2,tmp2,tmp,tmp3);sprintf(tmp2,"T%d",t);t=t+1;}}
		   |identificateur {strcpy(type,ts[recherche($1)].TypeEntite);sprintf(tmp2,"%s",$1);}
		   |const_reel {strcpy(type,"reel");sprintf(tmp2,"%.2f",$1);sprintf(tmp3,"T%.2f",$1);}
		   |const_entier {strcpy(type,"entier");sprintf(tmp2,"%d",$1);sprintf(tmp3,"T%d",$1);}
;

//----------------constante = entier ou reel -----------------
constante: const_entier {strcpy(type,"entier");}
		   | const_reel {strcpy(type,"reel");}
		   | const_chaine {strcpy(type,"chaine");}
;

%%

int yyerror(char*  message)
{ sprintf(message,"%s#",message);
printf("erreur syntaxique: ligne :%d detecte %s ,plus d informations: %s \n",nb_ligne,yytext,message);
return 1;}

int main()
{
printf("Taper stop pour arreter \n");
yyparse();
printf("\n\n");
afficher();
printf("\n\n");
afficher_qdr();
system("PAUSE");

}
