Name <- c("Jon", "Bill", "Maria", "Ben", "Tina")
Age <- c(23, 41, 32, 58, 26)

df <- data.frame(Name, Age)

library(echarts4r)
library(dplyr)

df %>%
  e_chart(Name) %>%
  e_bar(Age, Name,
        label = list(show = TRUE, formatter = "{b}", position = "insideLeft")) %>%
  e_x_axis(
    inverse = TRUE,
    axisLabel = list(inside = TRUE),
    axisTick = list(show = FALSE),
    axisLine = list(show = FALSE)
  ) %>% 
  e_legend(show = FALSE) %>% 
  e_flip_coords()

#
Name <- c("Jon", "Bill", "Maria", "Ben", "Tina")
Age <- c(23, 41, 32, 58, 26)

df <- data.frame(Name, Age)

library(echarts4r)
library(dplyr)
df %>% 
  e_charts(Name) %>% 
  e_bar(Age,
        label = list(
          show = TRUE,
          position = "right"
        )) %>% 
  e_x_axis(
    inverse = TRUE,
    axisLabel = list(inside = TRUE),
    axisTick = list(show = FALSE),
    axisLine = list(show = FALSE)
  ) %>% 
  e_legend(show = FALSE) %>% 
  e_flip_coords()

# bar custom colors

df <- structure(list(date = structure(c(18293, 18293, 18322, 18322, 
                                        18353, 18353, 18353, 18383, 18383, 18414, 18414, 18444), class = "Date"), 
                     source = c("a", "b", "a", "b", "c", "a", "b", "a", "b", "a", 
                                "b", "a"), value = c(14093, 3454, 99170, 63915, 56143, 125649, 
                                                     58470, 119920, 53307, 43654, 16383, 253068), color = c("#F56040", 
                                                                                                            "#833AB4", "#F56040", "#833AB4", "#3B5998", "#F56040", "#833AB4", 
                                                                                                            "#F56040", "#833AB4", "#F56040", "#833AB4", "#F56040")), row.names = c(NA, 
                                                                                                                                                                                   -12L), class = c("tbl_df", "tbl", "data.frame"))

# set to factor and specify levels
# levels => order
df$source <- factor(df$source, levels = c("b", "c", "a"))

# define colors to use in e_color
# matches order of factors (in group)
colors <- c(
  "red", # b
  "green", # c
  "blue" # a
)

df %>%
  group_by(source) %>%
  e_chart(., date) %>%
  e_bar(
    value,
    stack = 'group',
    emphasis = list(focus = 'series'),
    label = list(show = TRUE)
  ) %>%
  e_color(colors) # use colors


# 
mydata <- readr::read_csv("https://gist.githubusercontent.com/smach/194d26539b0d0deb9f6ac5ca2e7d49d0/raw/f0d3362e06e3cb7dbfc0c9df67e259f1e9dfb898/timeline_data.csv")

mydata %>% 
  group_by(ReportDate) %>% #<<
  e_charts(State, timeline = TRUE) %>% #<<
  e_timeline_opts(autoPlay = TRUE, top = 40) %>% #<<
  e_bar(PctUsed, itemStyle = list(color = "#0072B2"))  %>% 
  e_legend(show = FALSE) %>% 
  e_labels(position = 'insideTop') %>%
  e_title("Percent Received Covid-19 Vaccine Doses Administered", 
          left = "center", top = 5, 
          textStyle = list(fontSize = 24)) %>%
  e_grid(top = 100)

mydata %>%
  group_by(State) %>%
  e_charts(ReportDate) %>%
  e_line(PctUsed) %>%
  e_animation(duration = 8000) 


# TREEMAP JERARQUICO -----------------------------------------------------------

bancas_partido <- read_csv("_posts/500/bancas_partido.csv")

tm <- tribble(
  ~name, ~value, ~children,
  "Frente Amplio", sum(bancas_fa$value), bancas_fa,
  "Partido Nacional", sum(bancas_pn$value), bancas_pn,
  "Partido Colorado", sum(bancas_pc$value), bancas_pc
)

tm %>%
  e_charts() %>%
  e_treemap(
    leafDepth = 1,  #drilldown
    backgroundColor = "red",
    itemStyle = list(
      normal = list(
        borderWidth = 0,
        gapWidth = 2,
        backgroundColor = "gray"
      )
    ),
    name = "",
    upperLabel = list(
      normal = list(
        show = TRUE,
        height = 30,
        formatter = "{b}",
        color = "black",
        fontSize = 24
      )
    )
  )%>%
  e_tooltip() %>%
  e_labels(show = TRUE,
           verticalAlign = "top",
           fontSize = 24,
           formatter = "{b}\n{@value} bancas"
  ) %>%
  e_title("Cámara alta",
          textStyle = list(fontSize = 36),
          textVerticalAlign = "left",
          left = "center",
          backgroundColor = "") %>% 
  e_color(c("#004e9f", "#379fda", "#bc0000")) # colores bandera
