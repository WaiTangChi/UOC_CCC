#!/usr/bin/env Rscript

loadLibraries <- function(){
	rm(list = ls())
	if(!require(RCurl)){
		install.packages('RCurl')
		library(RCurl)
	}
	if(!require(XML)){	
		install.packages('XML')
		library(XML)
	}
	if(!require(stringr)){
		install.packages('stringr')
		library(stringr)
	}
	if(!require(rlist)){
		install.packages('rlist')
		library(rlist)
	}
	if(!require(xml2)){
		install.packages("xml2")
		library(xml2)
	}
	if(!require(rvest)){
		install.packages("rvest")
		library(rvest)
	}

}

getUrls <- function(){
	urls <- read.csv("../resources/urls.csv",header=T,sep=",")
	return( urls )
}

getHtml <- function( url ){
	print(paste("Reading URL : ",url))
	return ( read_html ( url ) )
}

getNodes <- function( webDoc ){
	nodeCCC <- html_nodes(webDoc,'.cashgame-list')
	return ( nodeCCC )
}	

getNodeContent <- function( node ){
	htmlText <- html_text( node )
	return ( htmlText )
}	

extractLines <- function ( urls ){
	
	currentGameType <- ""
	currentBlinds <- ""
	currentTables <- ""
	currentDesc <- ""

	lines <- data.frame(group=character(),casino=character(),gametype=character(),desc=character(),blinds=character(),tables=character(),stringsAsFactors=FALSE)
	lineCounter <- 1

	for ( i in 1:length( urls$url ) ){

		tokens <- strsplit( toString(urls[i,]$content) , "  ")
		tokens <- unlist( lapply( tokens ,  function( x ) trimws( x ) ) )


		for ( j in tokens ){
		
			if ( j != "" ){

				if( grepl( "table" , j ) | grepl( "Table" , j )  | grepl( "Tisch" , j ) | grepl( "tisch", j ) ){
					lines[lineCounter,]$group <- toString(urls[i,]$group)
					lines[lineCounter,]$casino <- toString(urls[i,]$casino)
					lines[lineCounter,]$tables <- toString(j)
					lines[lineCounter,]$blinds <- toString(currentBlinds)
					lines[lineCounter,]$gametype <- toString(currentGameType)
					lines[lineCounter,]$desc <- NA
					lineCounter <- lineCounter +1
				}else if( grepl ( "Omaha" , j ) | grepl ( "Hold" , j ) | grepl ( "Stud", j ) | grepl ( "Dealer", j ) | grepl ("Triple", j ) ){
					currentGameType <- j
				}else if( grepl ( "Blinds", j ) | grepl ( "Limit" , j ) ){
					currentBlinds <- j
				}else{
					lines[lineCounter-1,]$desc <- gsub(",","",toString(j))
				}	

			}
	
		
		}

	}

	return (lines)

}

saveLines <- function ( lines ) {

	for (i in 1:length(lines$group) ){

		line <- paste(Sys.time(),Sys.timezone(),lines[i,]$group,lines[i,]$casino,lines[i,]$gametype,lines[i,]$desc,lines[i,]$blinds,lines[i,]$tables,sep=",")
		write(line,file="../resources/CCC.csv",append=TRUE)
	}

}

main <- function (){

	#urls <- getUrls()[2,]
	urls <- getUrls()
	urls$webDocs <-	lapply( as.list( urls$url ), function ( x ) getHtml( toString ( x ) ) )
	urls$nodes <- lapply( as.list( urls$webDocs ), function ( x ) getNodes( x ) )
	urls$content <- lapply( as.list( urls$nodes ), function ( x ) getNodeContent( x ) )
	lines <- extractLines( urls )

	saveLines ( lines ) 	
}

loadLibraries()
main()
