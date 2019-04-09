#!/bin/bash




#inputIsNotFoundUnix2dosExceptionTest
  comm="./unix2dos -i NotFound"
  echo  ""
  echo  "*******************************************************************************************************"
  echo  "                   Test Unix2dos : Input file is not found. "
  echo  "                   Input File is called NotFound"
  echo  "                   Expected Result: Can not open input file 'NotFound' "
  OUTPUT=$($comm 2>&1);
  echo  "                   Obtained Result: $OUTPUT";

  echo  "*******************************************************************************************************"

  echo ""
  echo ""
  
#fileInputEqualsToFileOutputUnix2dosException
  comm="./unix2dos -i ./testFiles/test2 -o ./testFiles/test2";

 
  echo  "*******************************************************************************************************"
  echo  "                   Test Unix2dos : Input and output file ought to be differents. "
  echo  "                   Input File is called ./testFiles/test2"
  echo  "                   Expected Result: Input and output ought to be different "
  OUTPUT=$($comm 2>&1);
  echo  "                   Obtained Result: $OUTPUT";

  echo  "*******************************************************************************************************"

  echo ""
  echo ""

#inputIsNotFoundDos2unixExceptionTest
  comm="./dos2unix -i NotFound";

  echo  "*******************************************************************************************************";
  echo  "                 Test dos2unix: Input file is not found.";
  echo  "                   Input File is called NotFound"
  echo  "                   Expected Result: Can not open input file 'NotFound' "
  OUTPUT=$($comm 2>&1);
  echo  "                   Obtained Result: $OUTPUT";

  echo  "*******************************************************************************************************"

  echo ""
  echo ""

#fileInputEqualsToFileOutputDos2unixException
  comm="./dos2unix -i ./testFiles/test2 -o ./testFiles/test2";

  echo  "*******************************************************************************************************"
  echo  "                 Test dos2unix: Input and output file ought to be differents.";
  echo  "                   Input File is called ./testFiles/test2"
  echo  "                   Expected Result: Input and output ought to be different "
  OUTPUT=$($comm 2>&1);
  echo  "                   Obtained Result: $OUTPUT";

  echo  "*******************************************************************************************************"
