Updated by R. Kahn

Use this code to pulse compress raw EK80 echo sounder data and output .mat files.
See README file inside the main folder for instructions. 

Updated by R. Kahn
The 2020 version (and possibly later) of EK80 raw files include weird strings of characters that raise an error that has something to do with java... 
If you get this error, set a 'pause on error' before running and you should be able to find the script where multiple lines have been added to delete
these extra strings. The error means that there is probably a string that hasn't already been accounted for, in which case set a breakpoint at the end of 
this batch of string removal commands, open up the raw text file, find the string of odd characters, and add an additional line of code to remove them.
Reach out if you need help with this.

