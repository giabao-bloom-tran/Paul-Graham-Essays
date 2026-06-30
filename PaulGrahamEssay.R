needed <- c("rvest","httr","tibble",'dplyr','tidyverse')
new_pkgs <- needed[!(needed %in% installed.packages()[,"Package"])]
if(length(new_pkgs)) install.packages(new_pkgs)
lapply(needed, require, character.only = TRUE)

url <- "https://www.paulgraham.com/articles.html"
page <- read_html(url)

essays<-page %>%
  html_elements("a") %>%
  {
    tibble(
      title=html_text(.),
      url=html_attr(.,"href")
    )
  }

essays$url <- url_absolute(essays$url,base=url)
print(essays)


# Sample ------------------------------------------------------------------

sample_url<- 'https://www.paulgraham.com/greatwork.html'
sample_html <- read_html(sample_url)

##Grab title
sample_title <- sample_html %>% 
  html_node('title') %>% 
  html_text(trim=TRUE)

##Grab text
sample_body <- sample_html %>% 
  html_nodes('body') %>% 
  html_text(trim=TRUE)

##Print
cat('Title: ', sample_title)
cat('Snippets of text: ', substr(sample_body,1,500))

# Write the scraping function ---------------------------------------------
collect_essay <- function(url) {
  Sys.sleep(1)
  
  tryCatch({
    html<-read_html(url)
    
    title <- html %>% 
      html_node('title') %>% 
      html_text(trim=TRUE)
    
    body <- html %>% 
      html_nodes('body') %>% 
      html_text(trim =TRUE)
    
    return(tibble(Title=title,Text=body))
    
  }, error=function(e){
    return(tibble(url=url,title='Fail',text=NA))
    }
  )
}

pg_essays <- map_df(essays$url,collect_essay)


# Export ------------------------------------------------------------------

combined_text <- paste(pg_essays$Text,collapse='\n\n ---- NEW ESSAY ---- \n\n')
writeLines(combined_text,'Paul Graham Essays.txt')

