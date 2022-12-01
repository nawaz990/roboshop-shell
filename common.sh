STAT() {
  if [ $1 -eq 0 ]; then
    echo -e "\e[32mSUCCESS\e[0m"
  else
    echo Check the error in $LOG file
    echo -e "\e[31mFAILURE\e[0m"
    exit
  fi
}

PRINT() {
  echo " ------------------$1-------------------" >>${LOG}
  echo -e "\e[33m$1\e[0m"
}

LOG=/tmp/$COMPONENT.log
rm -f $LOG
