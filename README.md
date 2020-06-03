# frade2020taxRelief
Replication code for paper: "Does payroll tax relief increase employment level? Evidence from Brazil" 

You will need to download the RAIS('vínculos') datasets from ftp://ftp.mtps.gov.br/pdet/microdados/RAIS/ ;
Select the datasets ESTB__year__.7z from 2010 to 2013 and unzip in the same folder of the project.

The script translateNCMtoCNAE.r translate the NCM (Mercosur) code to CNAE (Brazilian Code). 

Then script frade2020_tax_relief.r. This script generates the files with cleaned data and runs the regression;

The script frade2020graph.r generates the graphs. Any questions? Email me at: martins_rafael@student.ceu.edu
