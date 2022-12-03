rm(list = ls())
require(minpack.lm)
require(ggplot2)

source("model_def.R")
source("stat_cal.R")


MyData <- read.csv("../data/ModiData.csv")
MyData$ID <- as.factor(MyData$ID)

set.seed(1234)

# Create matrix of AIC, BIC and R^2 for storing results
QuadAICc <- matrix(nrow = nlevels(MyData$ID), ncol = 4)
colnames(QuadAICc) <- c("ID", "AICc", "model", "score")
CubicAICc <- matrix(nrow = nlevels(MyData$ID), ncol = 4)
colnames(CubicAICc) <- c("ID", "AICc", "model", "score")
LogAICc <- matrix(nrow = nlevels(MyData$ID), ncol = 4)
colnames(LogAICc) <- c("ID", "AICc", "model", "score")
GompAICc <- matrix(nrow = nlevels(MyData$ID), ncol = 4)
colnames(GompAICc) <- c("ID", "AICc", "model", "score")

QuadBIC <- matrix(nrow = nlevels(MyData$ID), ncol = 4)
colnames(QuadBIC) <- c("ID", "BIC", "model", "score")
CubicBIC <- matrix(nrow = nlevels(MyData$ID), ncol = 4)
colnames(CubicBIC) <- c("ID", "BIC", "model", "score")
LogBIC <- matrix(nrow = nlevels(MyData$ID), ncol = 4)
colnames(LogBIC) <- c("ID", "BIC", "model", "score")
GompBIC <- matrix(nrow = nlevels(MyData$ID), ncol = 4)
colnames(GompBIC) <- c("ID", "BIC", "model", "score")

QuadR2 <- matrix(nrow = nlevels(MyData$ID), ncol = 4)
colnames(QuadR2) <- c("ID", "R2", "model", "score")
CubicR2 <- matrix(nrow = nlevels(MyData$ID), ncol = 4)
colnames(CubicR2) <- c("ID", "R2", "model", "score")
LogR2 <- matrix(nrow = nlevels(MyData$ID), ncol = 4)
colnames(LogR2) <- c("ID", "R2", "model", "score")
GompR2 <- matrix(nrow = nlevels(MyData$ID), ncol = 4)
colnames(GompR2) <- c("ID", "R2", "model", "score")




print("It takes few mins for model fitting, plotting and calculating AICc, BIC, R squared values ......")


pdf("../results/Modelfitting_plot.pdf", onefile = TRUE)

####################################################################################################################
for (i in 1:nlevels(MyData$ID)){
    
    data <- subset(MyData, ID == i)

    # create time ponit for plotting
    timepoint <- seq(min(data$Time), max(data$Time), (max(data$Time) - min(data$Time)) / 500)

   

    ## fit models ##

    # quadratic model #
    try(quad_model <- lm(data = data, PopBio ~ poly(Time, degree = 2, raw = TRUE)), silent = TRUE)

    # calculate prediction value of quadratic models then calculate RSS
    n <- nrow(data)
    p_quad <- length(coef(quad_model))

    pred_quad <- coef(quad_model)[1] + coef(quad_model)[2] * data$Time + coef(quad_model)[3] * (data$Time^2)

    RSS_quad <- LMRSS(n, pred_quad, data)
 


    # cubic model #
    try(cubic_model <- lm(data = data, PopBio ~ poly(Time, degree = 3, raw = TRUE)), silent = TRUE)

    # calculate prediction value of cubic models then calculate RSS
    n <- nrow(data)
    p_cubic <- length(coef(cubic_model))

    pred_cubic <- coef(cubic_model)[1] + coef(cubic_model)[2] * data$Time + coef(cubic_model)[3] * (data$Time^2) + coef(cubic_model)[4] * (data$Time^3)

    RSS_cubic <- LMRSS(n, pred_cubic, data)



    # logistic model, firstly we need to set our parameters then fit the model #
    N_0_start_l <- min(data$PopBio)
    K_start_l <- max(data$PopBio)
    r_max_start_l <- summary(lm(LogPopBio ~ Time, data = data))$coefficients[2]

    try(fit_logistic <- nlsLM(PopBio ~ logistic_model(t = Time, r_max, K, N_0), data,
      list(r_max = r_max_start_l, N_0 = N_0_start_l, K = K_start_l)), silent = TRUE)

    # calculate prediction value of logistic models then calculate RSS
    n <- nrow(data)
    p_logis <- length(coef(fit_logistic))

    pred_logis <- logistic_model(t = data$Time, r_max = coef(fit_logistic)["r_max"],
                    K = coef(fit_logistic)["K"], N_0 = coef(fit_logistic)["N_0"])

    RSS_logis <- LMRSS(n, pred_logis, data)



    # gompertz model, we still need to set our parameters in first #
    N_0_start_g <- min(data$LogPopBio)
    K_start_g <- max(data$LogPopBio)
    r_max_start_g <- summary(lm(LogPopBio ~ Time, data = data))$coefficients[2]
    t_lag_start <- data$Time[which.max(diff(diff(data$LogPopBio)))]
    
    # use trycatch to fit gompertz model. If failed, try generate new parameters and fit repeatly until it sucesses
    tryCatch(
    {
      fit_gompertz <- nlsLM(LogPopBio ~ gompertz_model(t = Time, r_max, K, N_0, t_lag), data,
      list(t_lag=t_lag_start, r_max=r_max_start_g, N_0 = N_0_start_g, K = K_start_g))


    },
    # use sampling to find coefficients that make gompertz model fitting successful
    error = repeat {
      pass <- 0
      N_0_start_g <- rnorm(1, mean = min(data$LogPopBio), sd = abs(4*min(data$LogPopBio)))
      K_start_g <- rnorm(1, mean = max(data$LogPopBio), sd = abs(6*min(data$LogPopBio)))
      r_max_start_g <- summary(lm(LogPopBio ~ Time, data = data))$coefficients[2]
      t_lag_start <- rnorm(1, mean = data$Time[which.max(diff(diff(data$LogPopBio)))], sd = abs(6*data$Time[which.max(diff(diff(data$LogPopBio)))]))
    
      try(
        {fit_gompertz <- nlsLM(LogPopBio ~ gompertz_model(t = Time, r_max, K, N_0, t_lag), data,
        list(t_lag=t_lag_start, r_max=r_max_start_g, N_0 = N_0_start_g, K = K_start_g))

        pass <- 1}, silent = TRUE
    )
      if (pass == 1) {
        break
      }
    }
    )

    # calculate prediction value of gompertz models then calculate RSS
    n <- nrow(data)
    p_Gompertz <- length(coef(fit_gompertz))

    pred_gomp <- gompertz_model(t = data$Time, r_max = coef(fit_gompertz)["r_max"],
                    K = coef(fit_gompertz)["K"], N_0 = coef(fit_gompertz)["N_0"], t_lag = coef(fit_gompertz)["t_lag"])

    RSS_gomp <- NonLogRSS(n, pred_gomp, data)


    

    ## calculate AICc, BIC and R^2 then store them ##
    TSS <- sum((data$PopBio - mean(data$PopBio)) ^ 2) # First calculate TSS for R^2

    Q_AICc <- MyAICc(n, RSS_quad, p_quad)
    Q_BIC <- MyBIC(n, RSS_quad, p_quad)
    Q_R2 <- 1 - (RSS_quad / TSS)

    C_AICc <- MyAICc(n, RSS_cubic, p_cubic)
    C_BIC <- MyBIC(n, RSS_cubic, p_cubic)
    C_R2 <- 1 - (RSS_cubic / TSS)

    L_AICc <- MyAICc(n, RSS_logis, p_logis)
    L_BIC <- MyBIC(n, RSS_logis, p_logis)
    L_R2 <- 1 - (RSS_logis / TSS)

    G_AICc <- MyAICc(n, RSS_gomp, p_Gompertz)
    G_BIC <- MyBIC(n, RSS_gomp, p_Gompertz)
    G_R2 <- 1 - (RSS_gomp / TSS)

    QuadAICc[i,1:3] <- c(i, Q_AICc, "Quadratic")
    CubicAICc[i,1:3] <- c(i, C_AICc, "Cubic")
    LogAICc[i,1:3] <- c(i, L_AICc, "Logistic")
    GompAICc[i,1:3] <- c(i, Q_AICc, "Gompertz")

    AICc_results <- rbind(QuadAICc, CubicAICc, LogAICc, GompAICc)

    QuadBIC[i,1:3] <- c(i, Q_BIC, "Quadratic")
    CubicBIC[i,1:3] <- c(i, C_BIC, "Cubic")
    LogBIC[i,1:3] <- c(i, L_BIC, "Logistic")
    GompBIC[i,1:3] <- c(i, Q_BIC, "Gompertz")

    BIC_results <- rbind(QuadBIC, CubicBIC, LogBIC, GompBIC)

    QuadR2[i,1:3] <- c(i, Q_R2, "Quadratic")
    CubicR2[i,1:3] <- c(i, C_R2, "Cubic")
    LogR2[i,1:3] <- c(i, L_R2, "Logistic")
    GompR2[i,1:3] <- c(i, Q_R2, "Gompertz")

    R2_results <- rbind(QuadR2, CubicR2, LogR2, GompR2)





    ## calculate simulation points of 4 models for plotting ##

    quadratic_point <- coef(quad_model)[1] + coef(quad_model)[2] * timepoint + coef(quad_model)[3] * (timepoint^2)

    cubic_point <- coef(cubic_model)[1] + coef(cubic_model)[2] * timepoint + coef(cubic_model)[3] * (timepoint^2) + coef(cubic_model)[4] * (timepoint^3)

    logistic_point <- logistic_model(t = timepoint, r_max = coef(fit_logistic)["r_max"],
                    K = coef(fit_logistic)["K"], N_0 = coef(fit_logistic)["N_0"])
    
    # for gompertz model I take exponential value to make gompertz model looks nice in non-log scale space

    gompertz_point <- exp(gompertz_model(t = timepoint, r_max = coef(fit_gompertz)["r_max"],
                    K = coef(fit_gompertz)["K"], N_0 = coef(fit_gompertz)["N_0"], t_lag = coef(fit_gompertz)["t_lag"]))




    ## Store simulation points of 4 models for plotting ##
   
    df1 <- data.frame(timepoint, quadratic_point)
    df1$model <- "Quadratic model"
    names(df1) <- c("Time", "PopBio", "model")

    df2 <- data.frame(timepoint, cubic_point)
    df2$model <- "Cubic model"
    names(df2) <- c("Time", "PopBio", "model")


    df3 <- data.frame(timepoint, logistic_point)
    df3$model <- "Logistic model"
    names(df3) <- c("Time", "PopBio", "model")

    df4 <- data.frame(timepoint, gompertz_point)
    df4$model <- "Gompertz model"
    names(df4) <- c("Time", "PopBio", "model")

    model_frame <- rbind(df1, df2, df3, df4)




    ## Plot ##
    
    
    p <- ggplot(data, aes(x = Time, y = PopBio)) +
     geom_point(size = 2) +
     geom_line(data = model_frame, aes(x = Time, y = PopBio, col = model), size = 1) +
     theme_bw() +
     theme(aspect.ratio = 1) +
     labs(x = "Time", y = paste("PopBio", toString(unique(data$PopBio_units), sep = "_")))

    print(p)

}

####################################################################################################################

dev.off()

write.csv(AICc_results, "../results/tempAICc.csv")
write.csv(BIC_results, "../results/tempBIC.csv")
write.csv(R2_results, "../results/tempR2.csv")

print("Model fitting, plotting and calculating completed")