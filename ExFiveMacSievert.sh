#usage: bash ExFiveMacSievert.sh

#1. this line takes the yearsexperience and gender column sorts them by gender and returns the unique
#combinations for gender/yearsExperience. The yearsExperience are ordered 1, 10, 11, 12, 13, 2, 3, 4 and 
# I couldn't get them to order 0,1, 2, 3, 10, 11, 12

cat wages.csv | cut -d ',' -f 1,2 | tr ',' ' ' | sort | uniq > GenderExperienceMACS.csv

##Brittni: If you use 'sort -t " " -k1,1 -k2,2n' this works. (-0.25)

#2A. these lines sorts wages.csv by the wage column, cuts out the gender years experience and wage, and 
# prints the row with the highest wage (which is at the bottom of the list, hence 'tail' not 'head'

echo This is the gender, years experience, and wage of the top earner:
cat wages.csv | sort -t ',' -nk 4 | cut -d ',' -f 1,2,4 | tail -1

#2B these lines sorts wages.csv by the wage column, cuts out the gender years experience and wage, and
# prints the row with the lowest wage (which is at the top of the list under the column names, hence 
#'head -2' | 'tail -1'
 
echo This is the gender, years experience, and wage of the lowest earner:
cat wages.csv | sort -t ',' -nk 4 | cut -d ',' -f 1,2,4 | head -2 | tail -1

#2C these lines sorts wages.csv by the wage column, cuts out the gender years experience and wage.
# then takes the top ten earners and uses grep to count the number of females in the top 10

echo The number of females in the top ten earners is:
cat wages.csv | sort -t ',' -nk 4 | cut -d ',' -f 1,2,4 | tail -10 | grep -c 'female'

#3. this code takes the years of school and wages column, takes row with a 12 in years of school, sorts 
# them, takes the lowest wage and assigns the value to a. I didn't know how to grep lines by a single
# column (ie take all the 12's from column 1) and google told me to use awk, so i used awk.

echo minimum wage of someone with 12 years of school is:
a= cat wages.csv | cut -d ',' -f 3,4 | sort | awk -F, '$1=="12"' | cut -d ',' -f 2 | sort -n | head -1

echo minimum wage of someone with 16 years of school is:
b= cat wages.csv | cut -d ',' -f 3,4 | sort | awk -F, '$1=="16"' | cut -d ',' -f 2 | sort -n | head -1

# this code subrtacts the minimum wage of 12 years of school from 16 years of school. 
echo the effect of graduating college on minimum wage is:
echo "$b - $a" | bc

#Brittni: This doesn't parse correctly because you need to assign variables with the variable=$() notation. (-0.25)
