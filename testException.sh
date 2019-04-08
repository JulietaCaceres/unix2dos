#!/bin/basht

# Program names.
UNIX2DOS='./unix2dos'
DOS2UNIX='./dos2unix'

# Test folder name.
TEST_FOLDER='./fileTest'

# Files names.
FILES_NAME='test'

# Counter of test
COUNT_TEST=0;

# Define color:
RED="\e[31m";
GREEN="\e[32m";
MAGENTA="\e[35m"
DEFAULT="\e[97m";

function header() {
  echo -e "$MAGENTA*******************************************************************************************************$DEFAULT";
  echo -e "        $DEFAULT$1$DEFAULT";
  echo -e "$MAGENTA*******************************************************************************************************$DEFAULT";
}


function inputIsNotFoundExceptionTest(){
  
  COUNT_TEST=$(($COUNT_TEST+1));
  comm="./unix2dos -i ./fileTest/test$COUNT_TEST";

  header  "Test: Input file is not found."

  echo -e "$comm\n" 
  
  EXPECTED_OUTPUT_INCORRECT_INPUT=("Can not open input file './fileTest/test$COUNT_TEST'")

  OUTPUT=$($comm 2>&1)

    if [[ "$EXPECTED_OUTPUT_INCORRECT_INPUT" == "$OUTPUT" ]]; then

      echo -e "Status:$GREEN OK \n $DEFAULT EXCEPTION OUTPUT:\n\t$OUTPUT\n";
    else
      echo -e "Status:$RED ERROR \n $DEFAULT PROGRAM OUTPUT:\n\t$OUTPUT  and expected: $EXPECTED_OUTPUT_INCORRECT_INPUT\n";
      
    fi

}

function fileInputEqualsToFileOutputException(){

  COUNT_TEST=$(($COUNT_TEST+1));
  comm="./unix2dos -i ./testFiles/test$COUNT_TEST -o ./testFiles/test$COUNT_TEST";

  header  "Test: Input and output file ought to be differents."

  echo -e "$comm\n" 

  EXPECTED_OUTPUT_INCORRECT_INPUT=("Input and output ought to be different")

  OUTPUT=$($comm 2>&1)

    if [[ "$EXPECTED_OUTPUT_INCORRECT_INPUT" == "$OUTPUT" ]]; then

      echo -e "Status:$GREEN OK \n $DEFAULT EXCEPTION OUTPUT:\n\t$OUTPUT\n";
    else
      echo -e "Status:$RED ERROR \n $DEFAULT PROGRAM OUTPUT:\n\t$OUTPUT  and expected: $EXPECTED_OUTPUT_INCORRECT_INPUT\n";

    fi

}



inputIsNotFoundExceptionTest
fileInputEqualsToFileOutputException
