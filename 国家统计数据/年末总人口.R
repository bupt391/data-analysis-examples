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
#画总人口折线图
p1 <- ggplot(subset(new_pop, index == "population"))+
  geom_line(aes(year, population))
#男性与女性人口条形图
ggplot(subset(new_pop, index == "male" | index == "female"))+
  geom_col(aes(year, population, fill = index), 
           position = "dodge")
#男性与女性人口折线图
p2 <- ggplot(subset(new_pop, index == "male" | index == "female"))+
  geom_line(aes(year, population, color = index))
#城镇与乡村人口折线图
p3 <- ggplot(subset(new_pop, index == "town" | index == "village"))+
  geom_line(aes(year, population, color = index)
#在一幅图中展示            
ggplot(new_pop)+
  geom_line(aes(year, population, color = index))
