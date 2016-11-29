data_dt <- readRDS('../km_dashboard/data_dt.rds')

fit_coxph <- coxph(Surv(obs_time, fail) ~ gender + health + age_at_start, data = data_dt)

server <- function(input, output) {

    data_input <- reactive({
        data_frame(gender       = c("M",       input$gender)
                  ,health       = c("Average", input$health)
                  ,age_at_start = c(45,        input$age_at_start)
        )
    })

    output$coxph_plot <- renderPlot({
        predict_tbl <- data_input()

        fit_survfit <- survfit(fit_coxph, newdata = predict_tbl)

        person_tbl <- data_frame(person_idx = c("1","2"), person = c('Baseline', 'Calculated'))

        plot_tbl <- fit_survfit$surv %>%
            as_data_frame() %>%
            gather("person_idx", "cuml_surv") %>%
            inner_join(person_tbl, by = 'person_idx') %>%
            group_by(person) %>%
            mutate(month = 1:n())

        ggplot(plot_tbl) +
            geom_line(aes(x = month, y = cuml_surv, colour = person)) +
            xlab("Month") +
            ylab("Cumulative Survival")
    })
}
