library(stringr)

print('Creating yaml files in data/abstracts/')

file_path <- "https://docs.google.com/spreadsheets/d/e/2PACX-1vRWk1K6nVoGeeYWmosAkTBuS4shpV7eZ7T7cQElCiV3ZOa9q5HdH1IR2h4Y7x1G-_wRpgoQ7TAeANp9/pub?gid=0&single=true&output=tsv"
schedule <- read.csv(file = file_path, 
                     sep = "\t", stringsAsFactors = F, 
                     na.strings = "")
#use "" instead of NAs
scheduleBlank <- schedule #make copy
scheduleBlank[is.na(scheduleBlank)] <- "" 

##  datetime to character
scheduleBlank$time <- sub("^.+ (.+):00", "\\1", scheduleBlank$time)

output_dir <- "data/abstracts/"
if (!file.exists(output_dir)) {
    dir.create(output_dir)
} else {
    ## Overwrite whatever output was generated before
    unlink(output_dir, recursive=TRUE)
    dir.create(output_dir)
}


iCount = 1
while(iCount <= nrow(scheduleBlank)) {
    #print(paste("iCount=", iCount))
    
    oneRow <- scheduleBlank[iCount, ] #one row
    
    ## get file name ready 
    fileNameSpace <- paste(oneRow$day, "_",
                           oneRow$time, "_",
                           oneRow$session_type,"_",
                           oneRow$paper,
                           ".yaml", 
                           sep = "" )
    
    #replace space and semi-colon by underscore
    fileNameFinal <- str_replace_all(string = fileNameSpace, 
                                     pattern =  c(" |:"), 
                                     replacement =   '')
    
    ## There are some trailing underscores in names without the paper field
    ## that should be removed
    fileNameFinal <- sub("_.yaml$", ".yaml", fileNameFinal)
    
    #loop through each columns to create the yaml file 
    iCount2 = 1
    while(iCount2 <= ncol(oneRow)) {
        #print(paste("iCount2=", iCount2))
        
        # write key value pair into file
        
        oneValueName <- names(oneRow)[iCount2]
        oneValue <- paste("\"",unlist(oneRow[iCount2]),"\"", sep ="")
       
        # Remove quotes form talks if it contains one or more papers 
        if (oneValueName == "talks" && any(grepl("paper", oneValue))) {
            oneValue <- sub("^\"(.+)\"$", "\\1", oneValue)
        }
        
        #write to file for the first time. Create new file
        if (iCount2 == 1) {
            #create file , no append
            line <- paste(oneValueName, ": ", oneValue, sep = "")
            write.table(line, col.names = FALSE, row.names = FALSE, 
                        file = paste(output_dir, 
                                     fileNameFinal, sep=""), 
                        append = FALSE, 
                        quote = FALSE, )
            
        } else {
            #append to existing file
            line <- paste(oneValueName, ": ", oneValue, sep = "")
            write.table(line, col.names = FALSE, row.names = FALSE,
                        file = paste(output_dir, 
                                     fileNameFinal, sep=""), 
                        append = TRUE, 
                        quote = FALSE)
        } # end of else
        
        iCount2 <- iCount2 + 1
    } #end of inside  loop
    
    iCount <- iCount + 1
} # end of outside loop
