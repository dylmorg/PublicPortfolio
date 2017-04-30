terror = read.csv(file.choose()) #Dataset
names(terror) 
before = terror[0:73054,] #This was calculated to be the point before 9/11
after = terror[73059:156773,] #This is all attacks post 9/11
summary(after$nkill) #basic summary
boxplot(before$nkill) #basic boxplot
#While this was not my original intent, I clearly underestimated the number of nondeadly terror attacks. Thus, I need to limitmy data to just deadly ones.
deadly_before = subset(before, nkill  > 2) 
deadly_after = subset(after, nkill > 2)
summary(deadly_before$nkill) #summaries of new data
summary(deadly_after$nkill) #summaries of new data
boxplot(after$nkill) #boxplot of new data
plot(deadly_before$nkill) #plots of new data
plot(deadly_after$nkill) #another plot of new data
#Obviously there are some outliers in this dataset, mostly related to tragic Russian and Iraqi incidents.  Let's remove the most flagrant ones
deadly_before = subset(before, nkill  < 1000)
deadly_after = subset(after, nkill < 1000)
wilcox.test(deadly_before$nkill,deadly_after$nkill, alternative = "two.sided") #T is not powerful enough to examine this dataset, wilcox removes those assumptions
wilcox.test(deadly_before$suicide,deadly_after$suicide)
wilcox.test(deadly_before$nkillus,deadly_after$nkillUS, alternative = "two.sided")
wilcox.test(deadly_before$nkillter,deadly_after$nkillter, alternative = "two.sided")
#Short answer: There's a difference between the two; there is no difference in the number of terrorists dying, but there evidence of a significant difference in the number of suicide attacks, the number of American deaths, and the number of overall deaths. It appears further that it is an increase in all catagories.
#Let's talk specifically about American terrorism
Murica_before_deadly = subset(deadly_before, country_txt == "United States")
Murica_after_deadly = subset(deadly_after, country_txt == "United States")
Murica_before_deadly = subset(Murica_before_deadly, nkill < 100) #There is one outlier here; Oklahoma City 1995. Let's remove it
summary(Murica_after_deadly$nkill)
wilcox.test(Murica_before_deadly$nkill,Murica_after_deadly$nkill) #Still a significant difference, but that's a much smaller P. examining the dataset further suggests bigger changes in number of incidents and fatalities are because of Iraq and Afghanistan consisiting of the vast majority of incidents and deaths, whereas before 9/11 their share was relatively small.
summary(Murica_before_deadly$nkillus)
temp = table(Murica_before_deadly$country_txt) #Shows most deadly attacks before were from fairly likely hotspots; examining further can show specific groups involved in these attacks in all the top 9 except the United States.
summary(deadly_before$country_txt)
temp = table(Murica_before_deadly$nkill)
plot(Murica_after_deadly$iyear,Murica_after_deadly$nkill) #While there would not be a large enough dataset, it does appear terror in the United Staes has increased and become more deadly as time went on post 9/11.
table(Murica_before_deadly$nkillter)
table(Murica_after_deadly$nkillter) #There's just not enough data to really examine terrorist deaths before and after 9/11 in the United States and come to a meaningful conclusion, though there definitely seems to be an increase.
Murica_before_deadly = subset(Murica_before_deadly, nkill >2)
Murica_after_deadly = subset(Murica_after_deadly, nkill > 2)""
summary(Murica_before_deadly$gname) #There's some organized armed terror attacks, but, outside of two incidents total involving "Black Muslims" being near the top, there doesn't seem to be a consistent pattern
summary(Murica_after_deadly$gname) #Not enough to really analyze, but the differencce is striking. NO organized groups committing deadly attacks, only unafflinated individuals and unknown motivations. Worth emphasizing that some of these cases pledge allegiance to other groups, but have no official contact or public evidence of being commanded by them
table(Murica_before_deadly$iyear) #Mostly 70's related deaths, almost seems partially economic in nature at first glance
table(Murica_after_deadly$iyear) #Skewed towards 2015and more happening in recent years.
names(terror)
American_terror = subset(terror,country_txt == "United States") #Let's backup and examine error in the more general sense in the United States, especially when our sample sizes are running fairly small
summary(American_terror$gname)
American_terror_affiliated = subset(test, gname != "Unaffiliated Individual(s)") #So most attacks we either know very little about those individuals' motivations or are extremists towards a certain cause? Eeven some of these categories like "Student Radicals" are fairly broad
American_terror_unaffiliated = subset(test, gname == "Unaffiliated Individual(s)")
al = subset(test, gname == "Earth Liberation Front (ELF)")
al$nkill #Examining a specific major group, they've literally killed no one. Looking further, part of what they pride themselves in is picking targets and times where no one'll get hurt. However, in March of 2001, it was also stated that this was the future of terrorism in the United States, and that just because they've had a track record of solely sabotage doesn't mean they'll continue to succeed
summary(American_terror_unaffiliated$nkill) #Let's examine specifically those unaffliated individuals and their deaths.
plot(American_terror_unaffiliated$nkill)
#We can allege that virtually all deadly domestic terrorism after 9/11 was unorganized and committed by unaffiliated individuals
