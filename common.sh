STAT() {
  if [ $1 -eq 0 ]; then
    echo -e "\e[32mSUCCESS\e[0m"
  else
    echo -e "\e[31mFAILURE\e[0m"
    exit
  fi
}

PRINT() {
  echo -e "\e[33m$1\e[0m"
}