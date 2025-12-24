#' Monthly differences
#'
#' @param df name of the data frame
#' @param previous30 if TRUE it compares current temperatures with previous reference period
#' @import ggplot2
#' @import dplyr
#' @return plot of differences in temperatures
#' @export
#'
#' @examples
#' monthlydiff(simtemperatures, previous30=TRUE)
monthlydiff <- function(df, previous30 = FALSE) {

  month_levels <- c("Gener", "Febrer", "Març", "Abril", "Maig", "Juny",
                    "Juliol", "Agost", "Setembre", "Octubre", "Novembre", "Desembre")
  df$depth <- factor(df$depth, levels = c(0, -20, -50, -80))

  if (previous30 == TRUE) {

    mean_diff<-df %>% group_by(year, depth) %>% summarise(mean=mean(diff), .groups = "drop")

    labels_df <- df %>%
      group_by(year) %>%
      summarise(ref_hist = unique(ref_hist)[1], .groups = "drop")

    g <- ggplot(df) +
      aes(x = factor(month, levels = unique(month)),
          y = diff,
          color = as.factor(depth),
          group = depth) +
      geom_point() +
      geom_line() +
      geom_hline(yintercept = 0, linetype = "dashed") +
      facet_wrap(~ year) +
      geom_text(data = labels_df, aes(x = 10, y = -2, label = ref_hist), inherit.aes = FALSE) +
      labs(title = "Temperature differences",
           subtitle = "between each month and the historical base. Differences in degree Celsius.") +
      xlab("Month") +
      ylab("Differences") +
      theme_bw() +
      theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust = 1),
            plot.title = element_text(face = "bold", colour = "black", size = 14),
            strip.text = element_text(colour = "white", size = 8),
            strip.background = element_rect(fill = "black", color = "black", linewidth = 1)) +
      labs(color = "Depth")
    show(g)
    return(mean_diff)
  }


  df <- df %>%
    mutate(month = factor(month, levels = month_levels, ordered = TRUE)) %>%
    arrange(year, depth, month)

  df_dif <- df %>%
    group_by(year, depth) %>%
    mutate(d.temp = temp.present - dplyr::lag(temp.present)) %>%
    ungroup() %>%
    dplyr::filter(complete.cases(d.temp))

  mean_df_dif <- df_dif %>%
    group_by(year, depth) %>%
    summarise(mean = mean(d.temp), .groups = "drop")

  p <- ggplot(df_dif, aes(x = month, y = d.temp, color = as.factor(depth), group = depth)) +
    geom_line() +
    geom_hline(yintercept = 0, linetype = "dashed")+
    geom_point() +
    facet_wrap(~ year) +
    labs(
      title = "Monthly temperature differences per year",
      x = "Month",
      y = "Increase in temperature",
      color = "Depth"
    ) +
    theme_bw() +
    theme(axis.text.x