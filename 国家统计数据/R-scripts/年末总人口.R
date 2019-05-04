library(tidyverse)
library(reshape2)
#导入数据
population <- read.csv("年末总人口.csv", header = TRUE)
names(population)
#使用reshape2中melt将变量合并到一列
new_pop <- melt(population, id.vars = "index",
                variable.name = "year", value.name = "population")
head(new_pop)
#将year转换为字符,并删除字符中的"X", "年"
new_pop$year <- as.character(new_pop$year)
new_pop$year <- as.numeric(str_sub(new_pop$year, start = 2, 5))
new_pop$index <- as.character(new_pop$index)
#增加变量class, population→population, male/female→sex, town/village→region
trans_fun <- function(x){
  if(x == "population"){
    return("population")
  }else{
   if(x == "male" | x == "female"){
     return("sex")
   }else{
     return("region")
   } 
  }
}
new_pop$class <- unlist(lapply(new_pop$index, trans_fun))
#人口折线图，使用class分面，使用index着色
ggplot(new_pop)+
  geom_line(aes(year, population, color = index))+
  facet_wrap(~ class)+
  ylab("population(万)")+
  theme_bw()
ggsave("population.png")
