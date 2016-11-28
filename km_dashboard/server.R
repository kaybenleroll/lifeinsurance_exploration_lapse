
data_dt <- readRDS('data_dt.rds')

server <- function(input, output) {

    data_input <- reactive({
        gender = input$gender
        health = input$health

        return(list(gender = gender, health = health))
    })

    output$km_plot <- renderPlot({
        data_lst <- data_input()

        formula_str <- "Surv(time,fail) ~ 1"

        if(data_lst$gender) formula_str <- paste0(formula_str, " + gender")
        if(data_lst$health) formula_str <- paste0(formula_str, " + health")

        km_formula <- as.formula(formula_str)

        fit_km <- survfit(km_formula, data = data_dt)

        ggsurvplot(fit_km, censor = FALSE, size = 0.5, break.time.by = 12)
    })
}
