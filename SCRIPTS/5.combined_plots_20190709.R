

library(ggplot2)
library(ggrepel)
library(pheatmap)


folder_names <- c("NESTED_comparisons_Blood_vs_BAL_SP_vs_HP","PAIR-WISE_comparisons_SP_vs_HC","PAIR-WISE_comparisons_BAL_vs_Blood")

for(k in folder_names[c(3)]){
  setwd(paste0("~/Desktop/NBIS/Projects/A_Smed_Sorensen_1805/ANALYSIS_COMPLETE/",k,"/"))
  
  group_dirs <- list.dirs("./",recursive = F,full.names = F)
  group_dirs <- group_dirs[grep("DGE",group_dirs)]
  groups <- sub("DGE_","",group_dirs)
  cells <- sub(".*_","",group_dirs)
  
  res <- lapply(groups,function(x){
    x <- read.csv2(paste0("DGE_",x,"/GSEA_h.all.v6.2.symbols.gmt.txt/GSEA_ALL_",x,".csv"),row.names = 1)
    x$padj <- -log10(x$padj)
    return(x[,c("ES","padj")]) })
  names(res) <- groups
  
  
  res2 <- lapply( rownames(res[[1]]) , function(x){
    temp <- matrix(unlist(lapply(names(res),function(z){ return(c(res[[z]][x,])) })),ncol = 2,byrow = T)
    colnames(temp) <- c("ES","padj"); rownames(temp) <- groups
    return(temp)
    })
  names(res2) <- rownames(res[[1]])
  
  
  dir.create("combined_enrichment_HALMARK_GENES",recursive = T); setwd("./combined_enrichment_HALMARK_GENES")
  
  for(i in names(res2)){
    cat("\n",i)
    df <- data.frame(ES=res2[[i]][,1],padj=res2[[i]][,2],cells=groups)
    pdf(paste0("Volcano_plot_",i,".pdf"),width = 6,height = 6, useDingbats = F)
    abc <- ggplot(df, aes(x = ES, y = padj))  +   geom_point(aes(color = cells))  + theme_bw(base_size = 12) + theme(legend.position = "bottom") +
      geom_hline(yintercept=-log10(0.01), linetype="dashed", color = "black")   +  geom_vline(xintercept=c(-.5,.5), linetype="dashed", color = "black")  +
      scale_x_continuous(limits=c(-1*max(1,abs(df$ES)), 1*max(1,abs(df$ES)))) + scale_y_continuous(limits=c(0, max(4,df$padj)*1.4)) #+ scale_y_continuous(trans = log2_trans() )
    print(abc + geom_text_repel(data = df,  aes(label = cells),size = 3, box.padding = unit(0.35, "lines"), point.padding = unit(0.3, "lines")))
    invisible(dev.off())
  }
  
  
  
  res3 <- as.data.frame(lapply( res , function(x){  return(x[rownames(res[[1]]),1]) }),row.names = rownames(res[[1]]))
  write.csv2(res3,"./combined_enrichment_NES.csv",row.names = T)
  pheatmap(res3,scale = "none",border_color = NA,fontsize_row = 8, cellheight = 7, cellwidth = 14,clustering_method = "ward.D2",
           color=colorRampPalette(c("navy","grey95","grey95","firebrick"))(99),breaks = seq(-1,1,length.out = 100),
           filename = "./heatmap_combined_enrichment.pdf")
  
  res4 <- as.data.frame(lapply( res , function(x){  return(x[rownames(res[[1]]),2]) }),row.names = rownames(res[[1]]))
  write.csv2(res4,"./combined_enrichment_pvalue.csv",row.names = T)
  
  
}




