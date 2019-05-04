library(tidyverse)
library(reshape2)
#导入数据
rate <- read.csv("人口变化率.csv", header = TRUE)
names(rate)
#使用reshape2中melt将变量合并到一列
new_rate <- melt(rate, id.vars = "index",
                variable.name = "year", value.name = "rate")

#将year转换为字符,并删除字符中的"X", "年"
new_rate$year <- as.character(new_rate$year)
new_rate$year <- as.numeric(str_sub(new_rate$year, start = 2, 5))
new_rate$index <- as.character(new_rate$index)
#人口出生率、死亡率、自然增长率折线图
ggplot(new_rate)+
  geom_line(aes(year, rate, color = index))+
  ylab("rate(‰)")+
  theme_bw()
ggsave("rate.png")
