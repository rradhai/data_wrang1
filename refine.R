#load CSV
refine <- read.csv("C:/Users/rradh/Desktop/radhai/Data Science/refine_original.csv")
View(refine)
#correcting company names
j<-grep("ak",refine$company,ignore.case = TRUE)
refine$company[j]<-"akzo"
j<-grep("ps",refine$company,ignore.case = TRUE)
refine$company[j]<-"philips"

j<-grep("un",refine$company,ignore.case = TRUE)
refine$company[j]<-"unilever"

refine$company<-tolower(refine$company)
#separating product code and product number
refine<-refine%>%separate(Product.code...number,c("product_code","product_number"),sep="-")
#add a column for product category
refine<-refine%>%mutate(prod_category=if_else(product_code=='p',"Smartphone",if_else(product_code=='v',"TV",if_else(product_code=='x',"Laptop","Tablet"))))
#combine the address in three columns to a single full address
refine<-transform(refine,full_address=paste(address,city,country,sep=","))

#adding dummy columns for company names
refine<-refine%>%mutate(company_unilever=if_else(company=='unilever',1,0))
refine<-refine%>%mutate(company_van_houten=if_else(company=='van houten',1,0))
refine<-refine%>%mutate(company_akzo=if_else(company=='akzo',1,0))
refine<-refine%>%mutate(company_philips=if_else(company=='philips',1,0))
#saving the changes to a new CSV file
write.csv(refine,'refine_clean.csv')


