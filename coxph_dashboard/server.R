data_dt <- readRDS('../km_dashboard/data_dt.rds')

fit_coxph <- coxph(Surv(obs_time, fail) ~ gender + health + age_at_start, data = data_dt)

server <- function(input, output) {

    data_input <- reactive({
        data_frame(gender       = input$gender
                  ,health       = input$health
                  ,age_at_start = input$age_at_start)
    })

    output$coxph_plot <- renderPlot({
        predict_tbl <- data_input()

        fit_survfit <- survfit(fit_coxph, newdata = predict_tbl)

        ggsurvplot(fit_survfit, censor = FALSE, size = 0.5, break.time.by = 12)
    })
}
