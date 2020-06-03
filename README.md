# frade2020taxRelief
Replication code for paper: "Does payroll tax relief increase employment level? Evidence from Brazil" 

Information regarding "Plano Brazil Maior": pt.wikipedia.org/wiki/Plano_Brasil_Maior


You will need to download the RAIS('vínculos') datasets from ftp://ftp.mtps.gov.br/pdet/microdados/RAIS/ ;
Select the datasets ESTB__year__.7z from 2010 to 2013 and unzip in the same folder of the project.
You will also need to download the file NCM2012XCNAE20.xls from concla.ibge.gov.br/classificacoes/correspondencias/produtos.html

The script translateNCMtoCNAE.r translate the NCM (Mercosur) code to CNAE (Brazilian Code). This codes refer to the production activity of the firm. They are used to filter which firms were treated.

Then script frade2020_tax_relief.r  generates the files with cleaned data and runs the regression;

The script frade2020graph.r generates the graphs. 
