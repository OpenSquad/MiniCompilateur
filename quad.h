typedef struct qdr{
char oper[100]; 
char op1[100];   
char op2[100];   
char res[100];  
}qdr;

qdr quad[1000];

extern int qc;


void quadr(ccar opr[],ccar op1[],ccar op2[],ccar res[])
{
	strcpy(quad[qc].oper,opr);
	strcpy(quad[qc].op1,op1);
	strcpy(quad[qc].op2,op2);
	strcpy(quad[qc].res,res);
	qc++;
}

void ajour_quad(int num_quad, int colon_quad, ccar val [])
{
	if (colon_quad==0)    
		strcpy(quad[num_quad].oper ,  val);
	else if (colon_quad==1)   
		strcpy(quad[num_quad].op1  ,  val);
	else if (colon_quad==2)    
		strcpy(quad[num_quad].op2  ,   val);
	else if (colon_quad==3)    
		strcpy(quad[num_quad].res  ,   val);
}


void afccer_qdr()
{
	printf("*********************LesQuadruplets***********************\n");
	int i;
	for(i=0;i<qc;i++)
	{
	printf("\n %d - (%s,%s,%s,%s )",i,quad[i].oper,quad[i].op1,quad[i].op2,quad[i].res); 
	printf("\n---------------------------------------------------\n");
	}
}