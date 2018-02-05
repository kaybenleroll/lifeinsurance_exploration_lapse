calculate_recession_timesplits <- function(policy_start_date, policy_final_date
                                          ,recess_start_date, recess_end_date
                                          ,status) {

    observed_month  <- (as.numeric(policy_final_date - policy_start_date) / 30.4)
    recession_month <- (as.numeric(recess_end_date   - recess_start_date) / 30.4)

    polstart_start_month <- (as.numeric(recess_start_date - policy_start_date) / 30.4)
    polstart_end_month   <- (as.numeric(recess_end_date   - policy_start_date) / 30.4)

    polfinal_start_month <- (as.numeric(recess_start_date - policy_final_date) / 30.4)
    polfinal_end_month   <- (as.numeric(recess_end_date   - policy_final_date) / 30.4)


    before_tbl <- data_frame(
        start_month = 0
       ,end_month   = pmin(polstart_start_month, observed_month)
       ,status      = ifelse(polstart_start_month < observed_month, FALSE, status)
    )

    during_tbl <- data_frame(
        start_month = pmax(0, pmin(observed_month, polstart_start_month))
       ,end_month   = polstart_end_month %>% pmax(0L) %>% pmin(observed_month)
       ,status      = ifelse(polstart_start_month < observed_month, FALSE, status)
    )

    after_tbl <- data_frame(
        start_month = pmax(0, polstart_end_month)
       ,end_month   = pmax(observed_month, polfinal_end_month)
       ,status      = status
    )


    split_tbl <- list(BEFORE = before_tbl
                     ,DURING = during_tbl
                     ,AFTER  = after_tbl) %>%
        bind_rows(.id = 'epoch') %>%
        mutate(start_month = start_month %>% as.integer
              ,end_month   = end_month   %>% as.integer
               ) %>%
        filter(start_month >= 0, start_month < end_month)


    return(split_tbl)
}

