#Build plot for lionfish length vs weight-----
library(EVR628tools)
library(tidyvers)
data("data_ lionfish",
mapping = aes ( x = total_lergth_mm, y = total_weight_gr))+
geom_soomth(color = "black",  lintype =  "dashed" ) +
geom_ vline(xintercept = c (100, 200), linetype = "dashed") +
geom_point(aes(color = size_class))+
scale_ color_manual(values = palette_UM(3)) +
lads( x = "Total length (mm))",
      y = "Total_weight (gr)",
      color = 
        


