Permutations of pairs using unique values by group

github
https://tinyurl.com/yc3u3t64
https://github.com/rogerjdeangelis/utl_permutations_of_pairs_using_unique_values_by_group

see
https://tinyurl.com/ycrd3z86
https://stackoverflow.com/questions/49075934/get-all-possible-combinations-of-two-columns-by-a-variable-id-in-r

Mohammad Tanvir Ahamed profile
https://stackoverflow.com/users/4933252/mohammad-tanvir-ahamed

The number of permutations of pairs is given by

   2 * (number unique)!
  ------------------------
  2!  (number unique - 2)!

  We expect 6 rows for group 'w' and '12' for group x


INPUT
=====

 SD1.HAVE total obs=7
                          | RULES
                          |
   GROUP  CROSSOVER_PAIRS |  V1  V2
                          |
     W          1         |  1    2
     W          2         |  1    3
     W          3         |  2    1
                          |  2    3
                          |  3    1
                          |  3    2
                          |
     X          1         |
     X          2         |
     X          3         |
     X          4         |

  EXAMPLE OUTPUT

    GROUP    V1    V2

      W      1     2
      W      1     3

      W      2     1
      W      2     3

      W      3     1
      W      3     2


PROCESS  (working code)
========================

   get_permutations <- function(have){
       perm <- permutations(nrow(unique(have[,1])), 2, have$);
       as.data.table(perm)
   };
   want <- have[, get_permutations(.SD), by = GROUP];

OUTPUT
======

 WORK.WANT_wps total obs=18

    GROUP    V1    V2

      W      1     2
      W      1     3
      W      2     1
      W      2     3
      W      3     1
      W      3     2

      X      1     2
      X      1     3
      X      1     4
      X      2     1
      X      2     3
      X      2     4
      X      3     1
      X      3     2
      X      3     4
      X      4     1
      X      4     2
      X      4     3

*                _                _       _
 _ __ ___   __ _| | _____      __| | __ _| |_ __ _
| '_ ` _ \ / _` | |/ / _ \    / _` |/ _` | __/ _` |
| | | | | | (_| |   <  __/   | (_| | (_| | || (_| |
|_| |_| |_|\__,_|_|\_\___|    \__,_|\__,_|\__\__,_|

;

data sd1.have;
input group$ crossover_pairs$;
cards4;
W 1
W 2
W 3
X 1
X 2
X 3
X 4
;;;;
run;quit;

*          _       _   _
 ___  ___ | |_   _| |_(_) ___  _ __
/ __|/ _ \| | | | | __| |/ _ \| '_ \
\__ \ (_) | | |_| | |_| | (_) | | | |
|___/\___/|_|\__,_|\__|_|\___/|_| |_|

;


%utl_submit_wps64('
libname sd1 "d:/sd1";
options set=R_HOME "C:/Program Files/R/R-3.3.2";
libname wrk "%sysfunc(pathname(work))";
proc r;
submit;
source("C:/Program Files/R/R-3.3.2/etc/Rprofile.site", echo=T);
library(haven);
library(gtools);
library(data.table);
have<-as.data.table(read_sas("d:/sd1/have.sas7bdat"));
get_permutations <- function(have){
    perm <- permutations(nrow(unique(have[,1])), 2, have$CROSSOVER_PAIRS);
    as.data.table(perm)
};
want <- have[, get_permutations(.SD), by = GROUP];
endsubmit;
import r=want data=wrk.want_wps;
run;quit;
');

> library(gtools)
> library(data.table)
> have<-as.data.table(read_sas("d:/sd1/have.sas7bdat"))
> head(have)
> get_permutations <- function(have){    perm <- permutations(nrow(unique(have[,1])), 2, have$CROSSOVER_PAIRS)
+ as.data.table(perm)}
> want <- have[, get_permutations(.SD), by = GROUP]

NOTE: Processing of R statements complete

16        import r=want data=wrk.want_wps;
NOTE: Creating data set 'WRK.want_wps' from R data frame 'want'
NOTE: Data set "WRK.want_wps" has 18 observation(s) and 3 variable(s)




